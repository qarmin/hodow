// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassLowResolutionZTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Coverage for depth optimizations like LRZ (Adreno) and EZ (Broadcom). Every case is a list of steps (begin a
// render pass, bind a pipeline, draw, clear, blit, copy, suspend/resume, secondary command buffers); the expected
// colour of an even and of an odd row is computed on the CPU by replaying the steps, and a compute shader compares
// the rendered image against them. The shaders are in `shaders/manifest/renderpass_low_resolution_z.toml`.
//
// Deviations: the images, views and buffers upstream keeps in a process-wide singleton are created per instance,
// and the colour image is not copied to a host buffer for logging when a case fails.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrCreateRenderpass2ExtensionDeviceCommands};

use crate::generated::shaders::renderpass_low_resolution_z::LOW_RESOLUTION_Z;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_SIZE: u32 = 1024;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// Number of depth images used in tests.
const DEPTH_IMAGE_COUNT: usize = 3;

/// Number of depth image layers available in the first d/s image.
const DEPTH_LAYER_COUNT: usize = 3;

/// `2 * sizeof(tcu::Vec4) + 2 * sizeof(uint32_t)`
const OUT_BUFFER_SIZE: u64 = 2 * 16 + 2 * 4;

/// `sizeof(DrawData)`: a vec4, two floats and an int.
const DRAW_DATA_SIZE: usize = 28;

/// `FS` - every fragment shader variant used in tests.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Fs {
    Basic,
    DepthGreater,
    DepthLess,
    DepthUnchanged,
    DepthGreaterOverride,
    DepthLessOverride,
    WriteDepthOverride,
    EarlyFragTests,
    Discard,
    Atomic,
    ImageStore,
}

impl Fs {
    /// The values `FS::BASIC` .. `FS::IMAGE_STORE`, i.e. everything below `FS::LAST`.
    const ALL: [Fs; 11] = [
        Fs::Basic,
        Fs::DepthGreater,
        Fs::DepthLess,
        Fs::DepthUnchanged,
        Fs::DepthGreaterOverride,
        Fs::DepthLessOverride,
        Fs::WriteDepthOverride,
        Fs::EarlyFragTests,
        Fs::Discard,
        Fs::Atomic,
        Fs::ImageStore,
    ];

    /// `fragShaderToName`
    fn shader_name(self) -> &'static str {
        match self {
            Fs::Basic => "basic-frag",
            Fs::DepthGreater => "depth-greater-frag",
            Fs::DepthLess => "depth-less-frag",
            Fs::DepthUnchanged => "depth-unchanged-frag",
            Fs::DepthGreaterOverride => "depth-greater-override-frag",
            Fs::DepthLessOverride => "depth-less-override-frag",
            Fs::WriteDepthOverride => "write-depth-override-frag",
            Fs::EarlyFragTests => "early-frag-tests-frag",
            Fs::Discard => "discard-frag",
            Fs::Atomic => "atomic-frag",
            Fs::ImageStore => "image-store-frag",
        }
    }

    fn is_depth_override(self) -> bool {
        matches!(
            self,
            Fs::DepthGreaterOverride | Fs::DepthLessOverride | Fs::WriteDepthOverride
        )
    }
}

/// `DrawMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawMode {
    FullQuad = 0,
    EvenRows,
    OddRows,
}

/// `TestStepType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestStepType {
    BeginRenderPass,
    EndRenderPass,
    SuspendResumeRendering,
    BindPipeline,
    Draw,
    ClearAttachment,
    ClearImage,
    Blit,
    BeginSecondary,
    EndSecondary,
    CopyBuffer,
    CopyImage,
    /// Barrier steps are added automatically.
    Barrier,
}

/// `BindPipelineData`
#[derive(Clone, Copy)]
struct BindPipelineData {
    frag: Fs,

    depth_test: bool,
    depth_write: bool,
    depth_compare_op: vk::CompareOp,

    stencil_test: bool,
    stencil_compare_op: vk::CompareOp,
    stencil_pass_op: vk::StencilOp,
    stencil_fail_op: vk::StencilOp,
    stencil_depth_fail_op: vk::StencilOp,
    stencil_compare_mask: u32,
    stencil_write_mask: u32,
    stencil_reference: u32,

    blend: bool,
    color_write_mask: vk::ColorComponentFlags,

    alpha_to_coverage: bool,
}

/// `BeginRenderPassData`
#[derive(Clone, Copy)]
struct BeginRenderPassData {
    depth_load_op: vk::AttachmentLoadOp,
    #[allow(dead_code)]
    depth_store_op: vk::AttachmentStoreOp,
    depth_clear_value: f32,
    stencil_clear_value: u32,
    /// If non zero then `depth_image_layer` is set to 0.
    depth_image_index: u32,
    /// Which layer of the first image is used for the attachment.
    depth_image_layer: u32,
}

/// `DrawData` - also the push constant block.
#[derive(Clone, Copy)]
struct DrawData {
    color: [f32; 4],
    depth: f32,
    height: f32,
    mode: DrawMode,
}

impl DrawData {
    fn to_bytes(self) -> [u8; DRAW_DATA_SIZE] {
        let mut bytes = [0u8; DRAW_DATA_SIZE];
        for (i, value) in self.color.iter().enumerate() {
            bytes[i * 4..i * 4 + 4].copy_from_slice(&value.to_ne_bytes());
        }
        bytes[16..20].copy_from_slice(&self.depth.to_ne_bytes());
        bytes[20..24].copy_from_slice(&self.height.to_ne_bytes());
        bytes[24..28].copy_from_slice(&(self.mode as i32).to_ne_bytes());
        bytes
    }
}

/// `ClearBlitCopyData`
#[derive(Clone, Copy)]
struct ClearBlitCopyData {
    depth: f32,
    depth_image_index: u32,
    depth_image_layer: u32,
}

/// `BarrierData`
#[derive(Clone, Copy)]
struct BarrierData {
    prev_step: TestStepType,
    next_step: TestStepType,
}

/// `TestStepVariant`
#[derive(Clone, Copy)]
enum StepData {
    None,
    BeginRenderPass(BeginRenderPassData),
    BindPipeline(BindPipelineData),
    Draw(DrawData),
    ClearBlitCopy(ClearBlitCopyData),
    Barrier(BarrierData),
}

/// `TestStep`
#[derive(Clone, Copy)]
struct TestStep {
    ty: TestStepType,
    data: StepData,
}

/// `TestParams`
struct TestParams {
    name: String,
    steps: Vec<TestStep>,
}

/// `StepHelpers`
mod step_helpers {
    use super::*;

    fn default_bind_pipeline_data(depth_compare_op: vk::CompareOp) -> BindPipelineData {
        BindPipelineData {
            frag: Fs::Basic,
            depth_test: true,
            depth_write: true,
            depth_compare_op,
            stencil_test: false,
            stencil_compare_op: vk::CompareOp::GREATER,
            stencil_pass_op: vk::StencilOp::ZERO,
            stencil_fail_op: vk::StencilOp::ZERO,
            stencil_depth_fail_op: vk::StencilOp::ZERO,
            stencil_compare_mask: 0xFF,
            stencil_write_mask: 0xFF,
            stencil_reference: 0,
            blend: false,
            color_write_mask: super::all_color_components(),
            alpha_to_coverage: false,
        }
    }

    fn bind(data: BindPipelineData) -> TestStep {
        TestStep {
            ty: TestStepType::BindPipeline,
            data: StepData::BindPipeline(data),
        }
    }

    /// `bindPipeline(depthCompareOp)` with every other argument defaulted.
    pub fn bind_pipeline(depth_compare_op: vk::CompareOp) -> TestStep {
        bind(default_bind_pipeline_data(depth_compare_op))
    }

    /// `bindPipeline(depthCompareOp, frag, depthTest, depthWrite)`
    pub fn bind_pipeline_with(
        depth_compare_op: vk::CompareOp,
        frag: Fs,
        depth_test: bool,
        depth_write: bool,
    ) -> TestStep {
        bind(BindPipelineData {
            frag,
            depth_test,
            depth_write,
            ..default_bind_pipeline_data(depth_compare_op)
        })
    }

    /// `bindPipeline(depthCompareOp, FS::BASIC, ENABLE, ENABLE, StencilTest::ENABLE, stencilCompareOp, ...)`
    #[allow(clippy::too_many_arguments)]
    pub fn bind_stencil_pipeline(
        depth_compare_op: vk::CompareOp,
        stencil_compare_op: vk::CompareOp,
        stencil_pass_op: vk::StencilOp,
        stencil_fail_op: vk::StencilOp,
        stencil_depth_fail_op: vk::StencilOp,
        stencil_compare_mask: u32,
        stencil_write_mask: u32,
        stencil_reference: u32,
    ) -> TestStep {
        bind(BindPipelineData {
            stencil_test: true,
            stencil_compare_op,
            stencil_pass_op,
            stencil_fail_op,
            stencil_depth_fail_op,
            stencil_compare_mask,
            stencil_write_mask,
            stencil_reference,
            ..default_bind_pipeline_data(depth_compare_op)
        })
    }

    /// `bindBlendPipeline`
    pub fn bind_blend_pipeline(
        depth_compare_op: vk::CompareOp,
        depth_write: bool,
        blend: bool,
        color_write_mask: vk::ColorComponentFlags,
        alpha_to_coverage: bool,
    ) -> TestStep {
        bind(BindPipelineData {
            depth_write,
            blend,
            color_write_mask,
            alpha_to_coverage,
            stencil_compare_mask: 0xFF,
            stencil_write_mask: 0xFF,
            ..default_bind_pipeline_data(depth_compare_op)
        })
    }

    /// `beginRenderPass(depthLoadOp, depthClearValue)`
    pub fn begin_render_pass(depth_load_op: vk::AttachmentLoadOp, depth_clear_value: f32) -> TestStep {
        begin_render_pass_full(depth_load_op, depth_clear_value, vk::AttachmentStoreOp::STORE, 0, 0, 0)
    }

    /// `beginRenderPass()`
    pub fn begin_render_pass_default() -> TestStep {
        begin_render_pass(vk::AttachmentLoadOp::CLEAR, 1.0)
    }

    pub fn begin_render_pass_full(
        depth_load_op: vk::AttachmentLoadOp,
        depth_clear_value: f32,
        depth_store_op: vk::AttachmentStoreOp,
        stencil_clear_value: u32,
        depth_image_index: u32,
        mut depth_image_layer: u32,
    ) -> TestStep {
        if depth_image_index != 0 {
            depth_image_layer = 0;
        }
        TestStep {
            ty: TestStepType::BeginRenderPass,
            data: StepData::BeginRenderPass(BeginRenderPassData {
                depth_load_op,
                depth_store_op,
                depth_clear_value,
                stencil_clear_value,
                depth_image_index,
                depth_image_layer,
            }),
        }
    }

    fn plain(ty: TestStepType) -> TestStep {
        TestStep {
            ty,
            data: StepData::None,
        }
    }

    pub fn end_render_pass() -> TestStep {
        plain(TestStepType::EndRenderPass)
    }

    /// This step applies only to dynamic rendering tests.
    pub fn suspend_resume_rendering() -> TestStep {
        plain(TestStepType::SuspendResumeRendering)
    }

    pub fn draw(color: [f32; 4], depth: f32) -> TestStep {
        draw_mode(color, depth, DrawMode::FullQuad)
    }

    pub fn draw_mode(color: [f32; 4], depth: f32, mode: DrawMode) -> TestStep {
        TestStep {
            ty: TestStepType::Draw,
            data: StepData::Draw(DrawData {
                color,
                depth,
                height: 1.0,
                mode,
            }),
        }
    }

    fn clear_blit_copy(ty: TestStepType, depth: f32) -> TestStep {
        TestStep {
            ty,
            data: StepData::ClearBlitCopy(ClearBlitCopyData {
                depth,
                depth_image_index: 0,
                depth_image_layer: 0,
            }),
        }
    }

    pub fn clear_depth_attachment(depth: f32) -> TestStep {
        clear_blit_copy(TestStepType::ClearAttachment, depth)
    }

    pub fn clear_depth_image(depth: f32) -> TestStep {
        clear_blit_copy(TestStepType::ClearImage, depth)
    }

    pub fn blit_depth(depth: f32) -> TestStep {
        clear_blit_copy(TestStepType::Blit, depth)
    }

    pub fn copy_buffer(depth: f32) -> TestStep {
        clear_blit_copy(TestStepType::CopyBuffer, depth)
    }

    pub fn copy_image(depth: f32) -> TestStep {
        clear_blit_copy(TestStepType::CopyImage, depth)
    }

    pub fn begin_secondary() -> TestStep {
        plain(TestStepType::BeginSecondary)
    }

    pub fn end_secondary() -> TestStep {
        plain(TestStepType::EndSecondary)
    }
}

use step_helpers::*;

/// `FramebufferState`
struct FramebufferState {
    color: [f32; 4],
    depth: [[f32; DEPTH_LAYER_COUNT]; DEPTH_IMAGE_COUNT],
    stencil: u32,
}

/// What the first pass over a case's steps collects (`preprocessSteps`).
struct PreparedSteps {
    blit_depths: Vec<f32>,
    pipeline_data: Vec<BindPipelineData>,
    suspend_resume_count_per_rendering: Vec<i32>,
    processed_steps: Vec<TestStep>,
    highest_used_depth_image_index: usize,
    highest_used_depth_image_layer: usize,
    has_render_pass_with_load_op_load: bool,
    number_of_required_secondary_command_buffers: usize,
    has_custom_secondary: bool,
}

pub struct LrzTestCase {
    params: TestParams,
    group_params: GroupParams,
}

impl TestCase for LrzTestCase {
    fn name(&self) -> &str {
        &self.params.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.group_params.rendering_type {
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2")?,
            RenderingType::DynamicRendering => context.require_device_functionality("VK_KHR_dynamic_rendering")?,
            RenderingType::Legacy => {}
        }

        let mut uses_blit = false;
        let mut uses_clear = false;
        let mut uses_secondary = false;
        for step in &self.params.steps {
            uses_blit |= step.ty == TestStepType::Blit;
            uses_clear |= step.ty == TestStepType::ClearImage;
            uses_secondary |= step.ty == TestStepType::BeginSecondary;
        }

        if uses_secondary {
            context.require_device_functionality("VK_KHR_maintenance7")?;
        }

        if uses_blit || uses_clear {
            let mut features = vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT;
            if uses_clear {
                features |= vk::FormatFeatureFlags::TRANSFER_DST;
            }
            if uses_blit {
                features |= vk::FormatFeatureFlags::BLIT_DST;
            }

            let instance = context.get_instance();
            let physical_device = context.get_physical_device();
            let props = unsafe {
                instance.get_physical_device_format_properties(physical_device, vk::Format::D24_UNORM_S8_UINT)
            };
            if !props.optimal_tiling_features.contains(features) {
                let props = unsafe {
                    instance.get_physical_device_format_properties(physical_device, vk::Format::D32_SFLOAT_S8_UINT)
                };
                if !props.optimal_tiling_features.contains(features) {
                    return Err(TestError::NotSupported(
                        "Required format features not supported".to_string(),
                    ));
                }
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        LOW_RESOLUTION_Z.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LrzTestInstance {
            context,
            test_params: &self.params,
            group_params: self.group_params,
        })
    }
}

struct LrzTestInstance<'a> {
    context: &'a Context<'a>,
    test_params: &'a TestParams,
    group_params: GroupParams,
}

fn color_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn ds_aspect() -> vk::ImageAspectFlags {
    vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
}

fn ds_range(base_array_layer: u32, layer_count: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(ds_aspect(), 0, 1, base_array_layer, layer_count)
}

fn render_area() -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: IMAGE_SIZE,
            height: IMAGE_SIZE,
        },
    }
}

/// `doesCompareOpPass` for floats.
fn compare_op_passes_f32(op: vk::CompareOp, reference: f32, value: f32) -> bool {
    match op {
        vk::CompareOp::LESS => reference < value,
        vk::CompareOp::EQUAL => (reference - value).abs() < 1e-6,
        vk::CompareOp::LESS_OR_EQUAL => reference <= value,
        vk::CompareOp::GREATER => reference > value,
        vk::CompareOp::NOT_EQUAL => (reference - value).abs() >= 1e-6,
        vk::CompareOp::GREATER_OR_EQUAL => reference >= value,
        vk::CompareOp::ALWAYS => true,
        _ => false,
    }
}

/// `doesCompareOpPass` for integers.
fn compare_op_passes_u32(op: vk::CompareOp, reference: u32, value: u32) -> bool {
    match op {
        vk::CompareOp::LESS => reference < value,
        vk::CompareOp::EQUAL => reference == value,
        vk::CompareOp::LESS_OR_EQUAL => reference <= value,
        vk::CompareOp::GREATER => reference > value,
        vk::CompareOp::NOT_EQUAL => reference != value,
        vk::CompareOp::GREATER_OR_EQUAL => reference >= value,
        vk::CompareOp::ALWAYS => true,
        _ => false,
    }
}

/// `applyStencilOp`
fn apply_stencil_op(op: vk::StencilOp, val: u32, reference: u32, write_mask: u32) -> u32 {
    let result = match op {
        vk::StencilOp::ZERO => 0,
        vk::StencilOp::REPLACE => reference,
        vk::StencilOp::INCREMENT_AND_CLAMP => {
            if val < 0xFF {
                val + 1
            } else {
                0xFF
            }
        }
        vk::StencilOp::DECREMENT_AND_CLAMP => val.saturating_sub(1),
        vk::StencilOp::INVERT => !val & 0xFF,
        vk::StencilOp::INCREMENT_AND_WRAP => val.wrapping_add(1) & 0xFF,
        vk::StencilOp::DECREMENT_AND_WRAP => val.wrapping_sub(1) & 0xFF,
        _ => val,
    };
    (val & !write_mask) | (result & write_mask)
}

/// `simulateDraw`
fn simulate_draw(
    fb: &mut FramebufferState,
    depth_image_index: usize,
    depth_image_layer: usize,
    pipeline: &BindPipelineData,
    dd: &DrawData,
) {
    if pipeline.alpha_to_coverage {
        let alpha = dd.color[3];
        if alpha < 0.001 {
            return;
        }

        // simulation of a2c works only for alpha 0 or 1
        debug_assert!(alpha > 0.999);
    }

    let stencil_test_enable = pipeline.stencil_test;
    if stencil_test_enable {
        let stencil_ref = pipeline.stencil_reference & pipeline.stencil_compare_mask;
        let stencil_val = fb.stencil & pipeline.stencil_compare_mask;
        let stencil_pass = compare_op_passes_u32(pipeline.stencil_compare_op, stencil_ref, stencil_val);

        if !stencil_pass {
            fb.stencil = apply_stencil_op(
                pipeline.stencil_fail_op,
                fb.stencil,
                pipeline.stencil_reference,
                pipeline.stencil_write_mask,
            );
            return;
        }
    }

    let mut draw_depth = dd.depth;
    let fb_depth = fb.depth[depth_image_index][depth_image_layer];
    if pipeline.frag.is_depth_override() {
        draw_depth = 1.0 - dd.depth;
    }

    if pipeline.depth_test {
        let depth_pass = compare_op_passes_f32(pipeline.depth_compare_op, draw_depth, fb_depth);
        if !depth_pass {
            if stencil_test_enable {
                fb.stencil = apply_stencil_op(
                    pipeline.stencil_depth_fail_op,
                    fb.stencil,
                    pipeline.stencil_reference,
                    pipeline.stencil_write_mask,
                );
            }
            return;
        }
    }

    if stencil_test_enable {
        fb.stencil = apply_stencil_op(
            pipeline.stencil_pass_op,
            fb.stencil,
            pipeline.stencil_reference,
            pipeline.stencil_write_mask,
        );
    }

    if pipeline.depth_write {
        fb.depth[depth_image_index][depth_image_layer] = draw_depth;
    }

    const CHANNEL_BITS: [vk::ColorComponentFlags; 4] = [
        vk::ColorComponentFlags::R,
        vk::ColorComponentFlags::G,
        vk::ColorComponentFlags::B,
        vk::ColorComponentFlags::A,
    ];
    let color_write_mask = pipeline.color_write_mask;
    if pipeline.blend {
        let draw_alpha = dd.color[3];
        for (channel, bit) in CHANNEL_BITS.iter().enumerate() {
            if color_write_mask.contains(*bit) {
                // alpha blending: src*srcAlpha + dst*(1-srcAlpha)
                fb.color[channel] *= 1.0 - draw_alpha;
                fb.color[channel] += if channel < 3 {
                    dd.color[channel] * draw_alpha
                } else {
                    draw_alpha
                };
            }
        }
    } else {
        for (channel, bit) in CHANNEL_BITS.iter().enumerate() {
            if color_write_mask.contains(*bit) {
                fb.color[channel] = dd.color[channel];
            }
        }
    }
}

/// Whether a step type is a transfer operation that needs a barrier on its own.
fn is_transfer_step(ty: TestStepType) -> bool {
    matches!(
        ty,
        TestStepType::ClearImage | TestStepType::Blit | TestStepType::CopyBuffer | TestStepType::CopyImage
    )
}

impl LrzTestInstance<'_> {
    /// `calculateExpectedColor`
    fn calculate_expected_color(&self, y: u32) -> [f32; 4] {
        let mut fb = FramebufferState {
            color: [0.0; 4],
            depth: [[0.0; DEPTH_LAYER_COUNT]; DEPTH_IMAGE_COUNT],
            stencil: 0,
        };
        let is_row_odd = y % 2 != 0;
        let mut depth_image_index = 0usize;
        let mut depth_image_layer = 0usize;
        let mut bound_pipeline: Option<BindPipelineData> = None;

        // note: we don't have to use processed steps here; we can rely on the original steps
        for step in &self.test_params.steps {
            match (step.ty, step.data) {
                (TestStepType::BeginRenderPass, StepData::BeginRenderPass(brpd)) => {
                    depth_image_index = brpd.depth_image_index as usize;
                    depth_image_layer = brpd.depth_image_layer as usize;

                    if brpd.depth_load_op != vk::AttachmentLoadOp::CLEAR {
                        continue;
                    }

                    fb.color = [0.0, 0.0, 0.0, 1.0];
                    fb.stencil = brpd.stencil_clear_value;

                    fb.depth[depth_image_index][depth_image_layer] = brpd.depth_clear_value;
                }
                (TestStepType::BindPipeline, StepData::BindPipeline(data)) => {
                    bound_pipeline = Some(data);
                }
                (TestStepType::Draw, StepData::Draw(dd)) => {
                    let pipeline = bound_pipeline.expect("a draw needs a bound pipeline");

                    // check if this draw doesn't affect the currently checked pixel
                    if (dd.mode == DrawMode::EvenRows && is_row_odd) || (dd.mode == DrawMode::OddRows && !is_row_odd) {
                        continue;
                    }

                    // FS::DISCARD discards when alpha < 0.01 -> skip all writes
                    if pipeline.frag == Fs::Discard && dd.color[3] < 0.01 {
                        continue;
                    }

                    simulate_draw(&mut fb, depth_image_index, depth_image_layer, &pipeline, &dd);
                }
                (TestStepType::ClearAttachment, StepData::ClearBlitCopy(cbd)) => {
                    // clear layer that is used as depth/stencil buffer in current renderpass
                    fb.depth[depth_image_index][depth_image_layer] = cbd.depth;
                }
                (ty, StepData::ClearBlitCopy(cbd)) if is_transfer_step(ty) => {
                    fb.depth[cbd.depth_image_index as usize][cbd.depth_image_layer as usize] = cbd.depth;
                }
                (
                    TestStepType::EndRenderPass
                    | TestStepType::SuspendResumeRendering
                    | TestStepType::BeginSecondary
                    | TestStepType::EndSecondary,
                    _,
                ) => {}
                _ => debug_assert!(false, "missing implementation for other test step types"),
            }
        }

        fb.color
    }

    /// `preprocessSteps`
    fn preprocess_steps(&self) -> PreparedSteps {
        let mut prepared = PreparedSteps {
            blit_depths: Vec::new(),
            pipeline_data: Vec::new(),
            suspend_resume_count_per_rendering: Vec::new(),
            processed_steps: Vec::new(),
            highest_used_depth_image_index: 0,
            highest_used_depth_image_layer: 0,
            has_render_pass_with_load_op_load: false,
            number_of_required_secondary_command_buffers: 0,
            has_custom_secondary: false,
        };

        let mut custom_suspend_resume_count: i32 = 0;
        let mut rendering_fully_in_secondaries = false;
        let mut rendering_partially_in_secondaries = false;

        let use_dynamic_rendering = self.group_params.rendering_type == RenderingType::DynamicRendering;

        if self.group_params.use_secondary_cmd_buffer {
            rendering_fully_in_secondaries = self
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;
            rendering_partially_in_secondaries = !rendering_fully_in_secondaries;
        }

        // gather required information from test steps
        for step in &self.test_params.steps {
            match (step.ty, step.data) {
                (TestStepType::Blit, StepData::ClearBlitCopy(cbd)) => {
                    // memorize depth values used in blit steps - we need to create additional images for them
                    prepared.blit_depths.push(cbd.depth);
                }
                (TestStepType::BeginRenderPass, StepData::BeginRenderPass(brp)) => {
                    // memorize highest depth image and layer used in render pass steps to know how many framebuffers we need to create
                    prepared.highest_used_depth_image_index = prepared
                        .highest_used_depth_image_index
                        .max(brp.depth_image_index as usize);
                    prepared.highest_used_depth_image_layer = prepared
                        .highest_used_depth_image_layer
                        .max(brp.depth_image_layer as usize);

                    prepared.has_render_pass_with_load_op_load |= brp.depth_load_op == vk::AttachmentLoadOp::LOAD;
                }
                (TestStepType::EndRenderPass, _) => {
                    // memorize rendering flags for each render pass (needed for custom suspend/resume)
                    prepared
                        .suspend_resume_count_per_rendering
                        .push(custom_suspend_resume_count);
                    custom_suspend_resume_count = 0;
                }
                (TestStepType::SuspendResumeRendering, _) => {
                    // memorize rendering suspending/resuming steps only when dynamic
                    // rendering and it is not partially contained in secondaries
                    custom_suspend_resume_count +=
                        i32::from(use_dynamic_rendering && !rendering_partially_in_secondaries);
                }
                (TestStepType::BeginSecondary, _) => {
                    prepared.number_of_required_secondary_command_buffers += 1;
                    prepared.has_custom_secondary = true;
                    rendering_fully_in_secondaries = false;
                    rendering_partially_in_secondaries = false;
                }
                // we are now only interested in bind pipeline steps
                (TestStepType::BindPipeline, StepData::BindPipeline(data)) => prepared.pipeline_data.push(data),
                _ => {}
            }
        }

        // when rendering is fully or partially in secondary command buffers,
        // we need one secondary command buffer per render pass (there is as many renderpasses as
        // there are entries in the suspend/resume count vector)
        if rendering_fully_in_secondaries || rendering_partially_in_secondaries {
            prepared.number_of_required_secondary_command_buffers = prepared.suspend_resume_count_per_rendering.len();
        }

        // define variable that will store previous step
        let mut prev_step = TestStepType::Barrier;

        // insert/remove some test steps depending on test configuration
        for step in &self.test_params.steps {
            let curr_step = step.ty;
            let mut add_to_step_vect = true;

            if curr_step == TestStepType::BeginRenderPass {
                // insert additional barrier step if previous step was renderpass, clear, blit or copy
                if prev_step == TestStepType::EndRenderPass || is_transfer_step(prev_step) {
                    prepared.processed_steps.push(TestStep {
                        ty: TestStepType::Barrier,
                        data: StepData::Barrier(BarrierData {
                            prev_step,
                            next_step: curr_step,
                        }),
                    });
                }

                // before starting rendering prepend step in which we start recording to secondary
                if rendering_fully_in_secondaries {
                    prepared.processed_steps.push(TestStep {
                        ty: TestStepType::BeginSecondary,
                        data: StepData::None,
                    });
                }

                prepared.processed_steps.push(*step);

                // after rendering append step in which we start recording to secondary
                if rendering_partially_in_secondaries {
                    prepared.processed_steps.push(TestStep {
                        ty: TestStepType::BeginSecondary,
                        data: StepData::None,
                    });
                }

                add_to_step_vect = false;
            } else if curr_step == TestStepType::EndRenderPass {
                if rendering_partially_in_secondaries {
                    prepared.processed_steps.push(TestStep {
                        ty: TestStepType::EndSecondary,
                        data: StepData::None,
                    });
                }
                prepared.processed_steps.push(*step);
                if rendering_fully_in_secondaries {
                    prepared.processed_steps.push(TestStep {
                        ty: TestStepType::EndSecondary,
                        data: StepData::None,
                    });
                }

                add_to_step_vect = false;
            } else if curr_step == TestStepType::SuspendResumeRendering {
                // include this step only for dynamic rendering but not when rendering is partially contained in secondaries
                add_to_step_vect = use_dynamic_rendering && !rendering_partially_in_secondaries;
            } else if curr_step == TestStepType::Blit || curr_step == TestStepType::ClearImage {
                // insert additional barrier step if previous step was renderpass, clear or blit
                if matches!(
                    prev_step,
                    TestStepType::EndRenderPass | TestStepType::Blit | TestStepType::ClearImage
                ) {
                    prepared.processed_steps.push(TestStep {
                        ty: TestStepType::Barrier,
                        data: StepData::Barrier(BarrierData {
                            prev_step,
                            next_step: curr_step,
                        }),
                    });
                }
            }

            prev_step = step.ty;
            if add_to_step_vect {
                prepared.processed_steps.push(*step);
            }
        }

        prepared
    }

    /// `setupSharedData`'s choice of the depth/stencil format and its usage.
    fn select_depth_stencil_format(&self) -> (vk::Format, vk::ImageUsageFlags) {
        let instance = self.context.get_instance();
        let physical_device = self.context.get_physical_device();

        // check which of required DS formats is supported
        let mut format = vk::Format::D24_UNORM_S8_UINT;
        let mut props = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
        if !props
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            format = vk::Format::D32_SFLOAT_S8_UINT;
            props = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
        }

        // if format supports transfer destination add it to usage as some tests need it
        let mut usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
        if props
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::TRANSFER_DST)
        {
            usage |= vk::ImageUsageFlags::TRANSFER_DST;
        }
        (format, usage)
    }

    /// `makeImageCreateInfo` + `ImageWithMemory`
    fn make_image(
        &self,
        format: vk::Format,
        size: u32,
        usage: vk::ImageUsageFlags,
        array_layers: u32,
    ) -> Result<ImageWithMemory<'_>, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: size,
                height: size,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(array_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        ImageWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            info,
            MemoryRequirement::ANY,
        )
    }

    /// `makeRenderPass<Version>` - colour is attachment 0, depth/stencil attachment 1, both in `GENERAL`.
    fn make_render_pass(
        &self,
        load_op: vk::AttachmentLoadOp,
        ds_format: vk::Format,
    ) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let general = vk::ImageLayout::GENERAL;

        let attachments = [
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: COLOR_FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: general,
                final_layout: general,
            },
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: ds_format,
                samples: vk::SampleCountFlags::_1,
                load_op,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: load_op,
                stencil_store_op: vk::AttachmentStoreOp::STORE,
                initial_layout: general,
                final_layout: general,
            },
        ];
        let color_reference = vk::AttachmentReference {
            attachment: 0,
            layout: general,
        };
        let depth_reference = vk::AttachmentReference {
            attachment: 1,
            layout: general,
        };

        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            let attachments2: Vec<vk::AttachmentDescription2> = attachments
                .iter()
                .map(|a| vk::AttachmentDescription2 {
                    s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                    next: std::ptr::null(),
                    flags: a.flags,
                    format: a.format,
                    samples: a.samples,
                    load_op: a.load_op,
                    store_op: a.store_op,
                    stencil_load_op: a.stencil_load_op,
                    stencil_store_op: a.stencil_store_op,
                    initial_layout: a.initial_layout,
                    final_layout: a.final_layout,
                })
                .collect();
            let color_reference2 = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: color_reference.attachment,
                layout: color_reference.layout,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            };
            let depth_reference2 = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: depth_reference.attachment,
                layout: depth_reference.layout,
                aspect_mask: ds_aspect(),
            };
            let subpass = vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: 0,
                input_attachments: std::ptr::null(),
                color_attachment_count: 1,
                color_attachments: &color_reference2,
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: &depth_reference2,
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            };
            let info = vk::RenderPassCreateInfo2 {
                s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                next: std::ptr::null(),
                flags: vk::RenderPassCreateFlags::empty(),
                attachment_count: attachments2.len() as u32,
                attachments: attachments2.as_ptr(),
                subpass_count: 1,
                subpasses: &subpass,
                dependency_count: 0,
                dependencies: std::ptr::null(),
                correlated_view_mask_count: 0,
                correlated_view_masks: std::ptr::null(),
            };
            let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
            return Ok(Unique::new(device, handle));
        }

        let color_references = [color_reference];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references)
            .depth_stencil_attachment(&depth_reference)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// One graphics pipeline of `preparePipelines`.
    fn create_pipeline(
        &self,
        data: &BindPipelineData,
        layout: vk::PipelineLayout,
        vertex_module: vk::ShaderModule,
        fragment_module: vk::ShaderModule,
        render_pass: vk::RenderPass,
        rendering: Option<&mut vk::PipelineRenderingCreateInfoBuilder<'_>>,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let entry = c"main";
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vertex_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(fragment_module)
                .name(entry.to_bytes_with_nul())
                .build(),
        ];

        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: IMAGE_SIZE as f32,
            height: IMAGE_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [render_area()];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);

        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);

        let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .min_sample_shading(1.0)
            .alpha_to_coverage_enable(data.alpha_to_coverage);

        let stencil_state = vk::StencilOpState::builder()
            .fail_op(data.stencil_fail_op)
            .pass_op(data.stencil_pass_op)
            .depth_fail_op(data.stencil_depth_fail_op)
            .compare_op(data.stencil_compare_op)
            .compare_mask(data.stencil_compare_mask)
            .write_mask(data.stencil_write_mask)
            .reference(data.stencil_reference)
            .build();
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(data.depth_test)
            .depth_write_enable(data.depth_write)
            .depth_compare_op(data.depth_compare_op)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(data.stencil_test)
            .front(stencil_state)
            .back(stencil_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(data.blend)
            .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
            .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(data.color_write_mask)
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .attachments(&blend_attachments);

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(0);
        if let Some(rendering) = rendering {
            info = info.push_next(rendering);
        }

        crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
    }

    /// `PipelineLayoutWrapper(pct, vk, device, descriptorSetLayout, &pushConstantRange)`
    fn make_graphics_pipeline_layout(
        &self,
        set_layout: Option<vk::DescriptorSetLayout>,
    ) -> Result<Unique<'_, vk::PipelineLayout>, TestError> {
        let device = self.context.get_device();
        let set_layouts: Vec<vk::DescriptorSetLayout> = set_layout.into_iter().collect();
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: DRAW_DATA_SIZE as u32,
        }];
        let info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_constant_ranges);
        let layout = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
        Ok(Unique::new(device, layout))
    }
}

/// `getGraphicsPipelineLayout` - the pipelines that do atomics and image stores have their own layouts; the
/// order matches the vector of layouts built in `iterate`.
fn graphics_pipeline_layout_index(frag: Fs) -> usize {
    usize::from(frag == Fs::Atomic) + 2 * usize::from(frag == Fs::ImageStore)
}

impl TestInstance for LrzTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let binaries = self.context.get_binary_collection();

        // some test configurations require altering sequence of steps
        let prepared = self.preprocess_steps();
        let mut suspend_resume_counts = prepared.suspend_resume_count_per_rendering.clone();

        let (ds_format, ds_usage) = self.select_depth_stencil_format();

        // define images for depth/stencil attachment (first one has <DEPTH_LAYER_COUNT> layers)
        let mut depth_stencil_images = Vec::with_capacity(DEPTH_IMAGE_COUNT);
        for i in 0..DEPTH_IMAGE_COUNT {
            let layers = if i == 0 { DEPTH_LAYER_COUNT as u32 } else { 1 };
            depth_stencil_images.push(self.make_image(ds_format, IMAGE_SIZE, ds_usage, layers)?);
        }

        // define image views of every layer of the first depth/stencil image and of layer 0 of the others
        let mut depth_stencil_views: [[Option<Unique<'_, vk::ImageView>>; DEPTH_LAYER_COUNT]; DEPTH_IMAGE_COUNT] =
            Default::default();
        for (i, image) in depth_stencil_images.iter().enumerate() {
            depth_stencil_views[i][0] = Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                ds_format,
                ds_range(0, 1),
            )?);
        }
        for layer in 1..DEPTH_LAYER_COUNT {
            depth_stencil_views[0][layer] = Some(make_image_view(
                device,
                depth_stencil_images[0].get(),
                vk::ImageViewType::_2D,
                ds_format,
                ds_range(layer as u32, 1),
            )?);
        }

        // define image for color attachment
        let color_image = self.make_image(
            COLOR_FORMAT,
            IMAGE_SIZE,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE,
            1,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_range(),
        )?;

        // define image for copy operations
        let copy_image = self.make_image(
            ds_format,
            IMAGE_SIZE,
            vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            1,
        )?;

        // define image for store operations
        let store_image = self.make_image(COLOR_FORMAT, 4, vk::ImageUsageFlags::STORAGE, 1)?;
        let store_view = make_image_view(
            device,
            store_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_range(),
        )?;

        // define buffer for copy operations; enough to store data for D32_SFLOAT_S8_UINT
        let buffer_usage = vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC;
        let copy_buffer_size = u64::from(IMAGE_SIZE) * u64::from(IMAGE_SIZE) * 5;
        let copy_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(copy_buffer_size, buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // define buffer used for cases with atomic operations and for verification with compute shader
        let out_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(OUT_BUFFER_SIZE, buffer_usage | vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let use_dynamic_rendering = self.group_params.rendering_type == RenderingType::DynamicRendering;

        // create renderPasses if test doesn't use dynamic rendering
        let mut render_passes: Vec<Unique<'_, vk::RenderPass>> = Vec::new();
        if !use_dynamic_rendering {
            render_passes.push(self.make_render_pass(vk::AttachmentLoadOp::CLEAR, ds_format)?);
            if prepared.has_render_pass_with_load_op_load {
                render_passes.push(self.make_render_pass(vk::AttachmentLoadOp::LOAD, ds_format)?);
            }
        }

        // create descriptor pool
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 3)?;

        // FS::ATOMIC fragment shader needs access to buffer for atomic
        let fs_storage_buffer_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let fs_storage_buffer_descriptor_set =
            make_descriptor_set(device, *descriptor_pool, *fs_storage_buffer_set_layout)?;

        // FS::IMAGE_STORE fragment shader needs access to storage image for imageStore operation
        let fs_storage_image_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let fs_storage_image_descriptor_set =
            make_descriptor_set(device, *descriptor_pool, *fs_storage_image_set_layout)?;

        // compute shader needs access to rendered image and buffer with expected results
        let compute_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let compute_descriptor_set = make_descriptor_set(device, *descriptor_pool, *compute_set_layout)?;

        // create all needed graphics pipeline layouts with push constant for draw data;
        // order of layouts should be the same as order of returned values in graphics_pipeline_layout_index
        let graphics_pipeline_layouts = [
            self.make_graphics_pipeline_layout(None)?,
            self.make_graphics_pipeline_layout(Some(*fs_storage_buffer_set_layout))?,
            self.make_graphics_pipeline_layout(Some(*fs_storage_image_set_layout))?,
        ];

        // create all needed pipelines
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let color_formats = [COLOR_FORMAT];
        let mut pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        let mut fragment_modules = Vec::new();
        for data in &prepared.pipeline_data {
            let fragment_module = create_shader_module(device, binaries.get(data.frag.shader_name())?)?;
            let layout = *graphics_pipeline_layouts[graphics_pipeline_layout_index(data.frag)];
            let pipeline = if use_dynamic_rendering {
                let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
                    .color_attachment_formats(&color_formats)
                    .depth_attachment_format(ds_format)
                    .stencil_attachment_format(ds_format);
                self.create_pipeline(
                    data,
                    layout,
                    *vertex_module,
                    *fragment_module,
                    vk::RenderPass::null(),
                    Some(&mut rendering_create_info),
                )?
            } else {
                self.create_pipeline(data, layout, *vertex_module, *fragment_module, *render_passes[0], None)?
            };
            pipelines.push(pipeline);
            fragment_modules.push(fragment_module);
        }

        // define image create info for blit images
        let blit_image_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let mut blit_images = Vec::with_capacity(prepared.blit_depths.len());
        for _ in &prepared.blit_depths {
            blit_images.push(self.make_image(ds_format, 1, blit_image_usage, 1)?);
        }

        // create required number of framebuffers
        let mut framebuffers: [[Option<Unique<'_, vk::Framebuffer>>; DEPTH_LAYER_COUNT]; DEPTH_IMAGE_COUNT] =
            Default::default();
        if !use_dynamic_rendering {
            for i in 0..=prepared.highest_used_depth_image_index {
                let views = [
                    *color_view,
                    **depth_stencil_views[i][0].as_ref().expect("view of layer 0"),
                ];
                framebuffers[i][0] = Some(make_framebuffer(
                    device,
                    *render_passes[0],
                    &views,
                    IMAGE_SIZE,
                    IMAGE_SIZE,
                    1,
                )?);
            }
            for i in 0..=prepared.highest_used_depth_image_layer {
                let views = [
                    *color_view,
                    **depth_stencil_views[0][i].as_ref().expect("view of the layer"),
                ];
                framebuffers[0][i] = Some(make_framebuffer(
                    device,
                    *render_passes[0],
                    &views,
                    IMAGE_SIZE,
                    IMAGE_SIZE,
                    1,
                )?);
            }
        }

        // calculate expected result on CPU before executing GPU commands
        let expected_even = self.calculate_expected_color(0);
        let expected_odd = self.calculate_expected_color(1);

        // store expected results for even and odd rows in compute buffer; at the end of the used part of the buffer
        // we store a flag that indicates if test passed: if compute shader writes 1 to it, rendered image was incorrect
        let out_buffer_alloc = out_buffer.get_allocation();
        let mut out_bytes = [0u8; 36];
        for (i, value) in expected_even.iter().chain(expected_odd.iter()).enumerate() {
            out_bytes[i * 4..i * 4 + 4].copy_from_slice(&value.to_ne_bytes());
        }
        out_bytes[32..36].copy_from_slice(&0u32.to_ne_bytes());
        unsafe { std::ptr::copy_nonoverlapping(out_bytes.as_ptr(), out_buffer_alloc.get_host_ptr(), out_bytes.len()) };
        flush_alloc(device, out_buffer_alloc)?;

        // update descriptor sets for some fragment shaders that need descriptors
        let buffer_info = [vk::DescriptorBufferInfo {
            buffer: out_buffer.get(),
            offset: 0,
            range: OUT_BUFFER_SIZE,
        }];
        let store_image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *store_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let color_image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *color_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(*fs_storage_buffer_descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(*fs_storage_image_descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&store_image_info)
                .build(),
            // update descriptor set for compute shader
            vk::WriteDescriptorSet::builder()
                .dst_set(*compute_descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&color_image_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(*compute_descriptor_set)
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // create compute pipeline that will be used to verify rendered image
        let compute_module = create_shader_module(device, binaries.get("comp")?)?;
        let compute_pipeline_layout = make_pipeline_layout(device, &[*compute_set_layout])?;
        let compute_stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_module)
            .name(c"main".to_bytes_with_nul());
        let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(compute_stage)
            .layout(*compute_pipeline_layout);
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

        // define required layout transition barriers
        let general = vk::ImageLayout::GENERAL;
        let transition = |image: vk::Image, range: vk::ImageSubresourceRange| {
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::MEMORY_WRITE,
                vk::ImageLayout::UNDEFINED,
                general,
                image,
                range,
            )
        };
        let mut layout_transition_barriers = vec![
            transition(color_image.get(), color_range()),
            transition(store_image.get(), color_range()),
        ];

        // transition depth images; only the first image has multiple layers
        for (i, image) in depth_stencil_images.iter().enumerate() {
            let layers = if i == 0 { DEPTH_LAYER_COUNT as u32 } else { 1 };
            layout_transition_barriers.push(transition(image.get(), ds_range(0, layers)));
        }

        // transition copy image and the images used for blit steps
        layout_transition_barriers.push(transition(copy_image.get(), ds_range(0, 1)));
        for image in &blit_images {
            layout_transition_barriers.push(transition(image.get(), ds_range(0, 1)));
        }

        let command_pool = make_command_pool(device, queue_family_index)?;
        let primary_command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let mut secondary_command_buffers: Vec<UniqueCommandBuffer<'_>> = Vec::new();

        // `cmd_buffer` is the command buffer to which we currently record rendering commands
        let mut cmd_buffer = *primary_command_buffer;

        let mut common_rendering_flags = vk::RenderingFlags::empty();
        let completely_contains = self
            .group_params
            .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

        begin_command_buffer(device, cmd_buffer)?;

        // if use_secondary_cmd_buffer flag is set then create secondary command buffers
        if self.group_params.use_secondary_cmd_buffer {
            if !completely_contains {
                common_rendering_flags = vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS;
                if prepared.has_custom_secondary {
                    common_rendering_flags |= vk::RenderingFlags::CONTENTS_INLINE_KHR;
                }
            }

            for _ in 0..prepared.number_of_required_secondary_command_buffers {
                secondary_command_buffers.push(allocate_command_buffer(
                    device,
                    *command_pool,
                    vk::CommandBufferLevel::SECONDARY,
                )?);
            }
        }

        let begin_secondary_command_buffer = |secondary: vk::CommandBuffer| -> Result<(), TestError> {
            let color_attachment_formats = [COLOR_FORMAT];
            let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                .flags(if completely_contains {
                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                } else {
                    vk::RenderingFlags::empty()
                })
                .color_attachment_formats(&color_attachment_formats)
                .depth_attachment_format(ds_format)
                .stencil_attachment_format(ds_format)
                .rasterization_samples(vk::SampleCountFlags::_1);
            let inheritance_info =
                vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
            let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
            if !completely_contains {
                usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
            }
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(usage_flags)
                .inheritance_info(&inheritance_info);
            unsafe { device.begin_command_buffer(secondary, &begin_info) }.vk_check("vkBeginCommandBuffer")
        };

        // `beginRendering`
        let begin_rendering = |cmd: vk::CommandBuffer,
                               framebuffer: vk::Framebuffer,
                               flags: vk::RenderingFlags,
                               depth_load_op: vk::AttachmentLoadOp,
                               depth_clear: f32,
                               stencil_clear: u32,
                               depth_image: usize,
                               depth_layer: usize| {
            let color_clear = vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            };
            let ds_clear = vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: depth_clear,
                    stencil: stencil_clear,
                },
            };

            if use_dynamic_rendering {
                // note: using same load op for color and D/S
                let color_attachments = [vk::RenderingAttachmentInfo::builder()
                    .image_view(*color_view)
                    .image_layout(vk::ImageLayout::GENERAL)
                    .load_op(depth_load_op)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(color_clear)
                    .build()];
                let ds_attachment = vk::RenderingAttachmentInfo::builder()
                    .image_view(
                        **depth_stencil_views[depth_image][depth_layer]
                            .as_ref()
                            .expect("view of the depth/stencil layer"),
                    )
                    .image_layout(vk::ImageLayout::GENERAL)
                    .load_op(depth_load_op)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(ds_clear)
                    .build();
                let rendering_info = vk::RenderingInfo::builder()
                    .flags(flags)
                    .render_area(render_area())
                    .layer_count(1)
                    .color_attachments(&color_attachments)
                    .depth_attachment(&ds_attachment)
                    .stencil_attachment(&ds_attachment);
                unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
            } else {
                let clear_values = [color_clear, ds_clear];
                let render_pass = if depth_load_op == vk::AttachmentLoadOp::LOAD {
                    *render_passes[1]
                } else {
                    *render_passes[0]
                };
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass)
                    .framebuffer(framebuffer)
                    .render_area(render_area())
                    .clear_values(&clear_values);

                if self.group_params.rendering_type == RenderingType::Legacy {
                    unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
                } else {
                    let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                    unsafe { device.cmd_begin_render_pass2_khr(cmd, &begin_info, &subpass_begin) };
                }
            }
        };

        // `endRendering`
        let end_rendering = |cmd: vk::CommandBuffer| {
            if use_dynamic_rendering {
                unsafe { device.cmd_end_rendering(cmd) };
            } else if self.group_params.rendering_type == RenderingType::Legacy {
                unsafe { device.cmd_end_render_pass(cmd) };
            } else {
                let subpass_end = vk::SubpassEndInfo::builder();
                unsafe { device.cmd_end_render_pass2_khr(cmd, &subpass_end) };
            }
        };

        unsafe {
            // execute all image layout transitions
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &layout_transition_barriers,
            );

            // if needed setup all blit images with clear values
            for (image, depth) in blit_images.iter().zip(&prepared.blit_depths) {
                let clear_depth = vk::ClearDepthStencilValue {
                    depth: *depth,
                    stencil: 0,
                };
                device.cmd_clear_depth_stencil_image(cmd_buffer, image.get(), general, &clear_depth, &[ds_range(0, 1)]);
            }

            // wait for blits to be finished before starting render pass
            let post_blit_memory_barrier = make_memory_barrier(
                vk::AccessFlags::MEMORY_WRITE,
                vk::AccessFlags::MEMORY_WRITE | vk::AccessFlags::MEMORY_READ,
            );
            let post_blit_memory_barriers: &[vk::MemoryBarrier] = if blit_images.is_empty() {
                &[]
            } else {
                std::slice::from_ref(&post_blit_memory_barrier)
            };
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::DependencyFlags::empty(),
                post_blit_memory_barriers,
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        let mut render_pass_index = 0usize;
        let mut pipeline_index = 0usize;
        let mut blit_image_index = 0usize;
        let mut secondary_index = 0usize;
        let isl = make_image_subresource_layers(ds_aspect(), 0, 0, 1);
        let image_extent = vk::Extent3D {
            width: IMAGE_SIZE,
            height: IMAGE_SIZE,
            depth: 1,
        };

        let mut current_render_pass_data: Option<BeginRenderPassData> = None;
        let mut current_pipeline_data: Option<BindPipelineData> = None;

        // execute all test steps in requested order
        for test_step in &prepared.processed_steps {
            match (test_step.ty, test_step.data) {
                (TestStepType::BeginRenderPass, StepData::BeginRenderPass(brp)) => {
                    let mut rendering_flag = vk::RenderingFlags::empty();
                    if suspend_resume_counts[render_pass_index] > 0 {
                        rendering_flag = vk::RenderingFlags::SUSPENDING;
                    }

                    current_render_pass_data = Some(brp);
                    let framebuffer = framebuffers[brp.depth_image_index as usize][brp.depth_image_layer as usize]
                        .as_ref()
                        .map_or_else(vk::Framebuffer::null, |fb| **fb);
                    begin_rendering(
                        cmd_buffer,
                        framebuffer,
                        common_rendering_flags | rendering_flag,
                        brp.depth_load_op,
                        brp.depth_clear_value,
                        brp.stencil_clear_value,
                        brp.depth_image_index as usize,
                        brp.depth_image_layer as usize,
                    );
                }
                (TestStepType::EndRenderPass, _) => {
                    end_rendering(cmd_buffer);
                    current_render_pass_data = None;
                    render_pass_index += 1;
                }
                (TestStepType::SuspendResumeRendering, _) => {
                    let brp = current_render_pass_data.expect("a suspend/resume step needs a render pass");

                    let mut rendering_flag = vk::RenderingFlags::RESUMING;

                    // if this render pass will be suspended once again then we need to also add suspending flag
                    if suspend_resume_counts[render_pass_index] > 1 {
                        rendering_flag |= vk::RenderingFlags::SUSPENDING;
                    }
                    suspend_resume_counts[render_pass_index] -= 1;

                    end_rendering(cmd_buffer);
                    let framebuffer = framebuffers[brp.depth_image_index as usize][brp.depth_image_layer as usize]
                        .as_ref()
                        .map_or_else(vk::Framebuffer::null, |fb| **fb);
                    begin_rendering(
                        cmd_buffer,
                        framebuffer,
                        rendering_flag,
                        brp.depth_load_op,
                        brp.depth_clear_value,
                        brp.stencil_clear_value,
                        brp.depth_image_index as usize,
                        brp.depth_image_layer as usize,
                    );
                }
                (TestStepType::BindPipeline, StepData::BindPipeline(data)) => {
                    current_pipeline_data = Some(data);
                    unsafe {
                        device.cmd_bind_pipeline(
                            cmd_buffer,
                            vk::PipelineBindPoint::GRAPHICS,
                            *pipelines[pipeline_index],
                        )
                    };
                    pipeline_index += 1;
                }
                (TestStepType::Draw, StepData::Draw(mut dd)) => {
                    dd.height = IMAGE_SIZE as f32;
                    let frag = current_pipeline_data.expect("a draw needs a bound pipeline").frag;
                    let layout = *graphics_pipeline_layouts[graphics_pipeline_layout_index(frag)];
                    unsafe {
                        device.cmd_push_constants(
                            cmd_buffer,
                            layout,
                            vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT,
                            0,
                            &dd.to_bytes(),
                        );

                        let descriptor_set = match frag {
                            Fs::Atomic => Some(*fs_storage_buffer_descriptor_set),
                            Fs::ImageStore => Some(*fs_storage_image_descriptor_set),
                            _ => None,
                        };
                        if let Some(descriptor_set) = descriptor_set {
                            device.cmd_bind_descriptor_sets(
                                cmd_buffer,
                                vk::PipelineBindPoint::GRAPHICS,
                                layout,
                                0,
                                &[descriptor_set],
                                &[] as &[u32],
                            );
                        }

                        let instance_count = if dd.mode == DrawMode::FullQuad {
                            1
                        } else {
                            IMAGE_SIZE / 2
                        };
                        device.cmd_draw(cmd_buffer, 4, instance_count, 0, 0);
                    }
                }
                (TestStepType::BeginSecondary, _) => {
                    // begin recording secondary command buffer
                    cmd_buffer = *secondary_command_buffers[secondary_index];
                    begin_secondary_command_buffer(cmd_buffer)?;
                }
                (TestStepType::EndSecondary, _) => {
                    // end recording secondary command buffer
                    end_command_buffer(device, cmd_buffer)?;
                    cmd_buffer = *primary_command_buffer;
                    unsafe { device.cmd_execute_commands(cmd_buffer, &[*secondary_command_buffers[secondary_index]]) };
                    secondary_index += 1;
                }
                (TestStepType::Barrier, StepData::Barrier(bd)) => {
                    // barrier step should not be called inside render pass
                    debug_assert!(current_render_pass_data.is_none());

                    // by default assume barrier between two render passes
                    let mut src_stage =
                        vk::PipelineStageFlags::LATE_FRAGMENT_TESTS | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
                    let mut src_access = vk::AccessFlags::MEMORY_WRITE;
                    let mut dst_stage = vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | src_stage;
                    let mut dst_access = vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE;

                    if is_transfer_step(bd.prev_step) {
                        src_stage = vk::PipelineStageFlags::TRANSFER;
                        src_access = vk::AccessFlags::MEMORY_WRITE;
                    }

                    if is_transfer_step(bd.next_step) {
                        dst_stage = vk::PipelineStageFlags::TRANSFER;
                        dst_access = vk::AccessFlags::MEMORY_WRITE;
                    }

                    let memory_barrier = make_memory_barrier(src_access, dst_access);
                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            src_stage,
                            dst_stage,
                            vk::DependencyFlags::empty(),
                            &[memory_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                    }
                }
                (TestStepType::ClearAttachment, StepData::ClearBlitCopy(cd)) => {
                    let clear_rect = vk::ClearRect {
                        rect: render_area(),
                        base_array_layer: 0,
                        layer_count: 1,
                    };
                    let clear_attachment = vk::ClearAttachment {
                        aspect_mask: ds_aspect(),
                        color_attachment: 0,
                        clear_value: vk::ClearValue {
                            depth_stencil: vk::ClearDepthStencilValue {
                                depth: cd.depth,
                                stencil: 0,
                            },
                        },
                    };
                    unsafe { device.cmd_clear_attachments(cmd_buffer, &[clear_attachment], &[clear_rect]) };
                }
                (TestStepType::ClearImage, StepData::ClearBlitCopy(cd)) => {
                    debug_assert!(cmd_buffer == *primary_command_buffer);
                    let clear_value = vk::ClearDepthStencilValue {
                        depth: cd.depth,
                        stencil: 0,
                    };
                    let depth_stencil_image = depth_stencil_images[cd.depth_image_index as usize].get();
                    let range = ds_range(cd.depth_image_layer, 1);
                    unsafe {
                        device.cmd_clear_depth_stencil_image(
                            cmd_buffer,
                            depth_stencil_image,
                            general,
                            &clear_value,
                            &[range],
                        )
                    };
                }
                (TestStepType::Blit, StepData::ClearBlitCopy(cd)) => {
                    debug_assert!(cmd_buffer == *primary_command_buffer);
                    let depth_stencil_image = depth_stencil_images[cd.depth_image_index as usize].get();

                    let mut dst_subresource = isl;
                    dst_subresource.base_array_layer = cd.depth_image_layer;
                    let blit_region = vk::ImageBlit {
                        src_subresource: isl,
                        src_offsets: [vk::Offset3D { x: 0, y: 0, z: 0 }, vk::Offset3D { x: 1, y: 1, z: 1 }],
                        dst_subresource,
                        dst_offsets: [
                            vk::Offset3D { x: 0, y: 0, z: 0 },
                            vk::Offset3D {
                                x: IMAGE_SIZE as i32,
                                y: IMAGE_SIZE as i32,
                                z: 1,
                            },
                        ],
                    };

                    unsafe {
                        device.cmd_blit_image(
                            cmd_buffer,
                            blit_images[blit_image_index].get(),
                            general,
                            depth_stencil_image,
                            general,
                            &[blit_region],
                            vk::Filter::NEAREST,
                        );
                    }
                    blit_image_index += 1;
                }
                (TestStepType::CopyBuffer, StepData::ClearBlitCopy(cd)) => {
                    let depth_stencil_image = depth_stencil_images[cd.depth_image_index as usize].get();

                    // wait for previous operations on copy image to be finished
                    let mut image_barrier = make_image_memory_barrier(
                        vk::AccessFlags::MEMORY_READ,
                        vk::AccessFlags::MEMORY_WRITE,
                        general,
                        general,
                        copy_image.get(),
                        ds_range(0, 1),
                    );
                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[image_barrier],
                        );

                        // there is no easy way to clear buffer with specific depth values so we do that via image
                        // and set it to specified depth value first and then copy whole image to buffer
                        let clear_value = vk::ClearDepthStencilValue {
                            depth: cd.depth,
                            stencil: 0,
                        };
                        device.cmd_clear_depth_stencil_image(
                            cmd_buffer,
                            copy_image.get(),
                            general,
                            &clear_value,
                            &[ds_range(0, 1)],
                        );

                        // wait for clear
                        image_barrier.src_access_mask = vk::AccessFlags::MEMORY_WRITE;
                        image_barrier.dst_access_mask = vk::AccessFlags::MEMORY_READ;
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[image_barrier],
                        );

                        // copy image to buffer
                        let mut image_copy = make_buffer_image_copy(image_extent, isl);
                        image_copy.image_subresource.aspect_mask = vk::ImageAspectFlags::DEPTH;
                        device.cmd_copy_image_to_buffer(
                            cmd_buffer,
                            copy_image.get(),
                            general,
                            copy_buffer.get(),
                            &[image_copy],
                        );

                        // make sure that data is in the copy buffer and also that previous operations on the depth/stencil image are finished
                        let buffer_barrier = make_memory_barrier(
                            vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE,
                            vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE,
                        );
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::ALL_COMMANDS,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[buffer_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );

                        // copy buffer back to depth image
                        image_copy.image_subresource.base_array_layer = cd.depth_image_layer;
                        device.cmd_copy_buffer_to_image(
                            cmd_buffer,
                            copy_buffer.get(),
                            depth_stencil_image,
                            general,
                            &[image_copy],
                        );
                    }
                }
                (TestStepType::CopyImage, StepData::ClearBlitCopy(cd)) => {
                    let depth_stencil_image = depth_stencil_images[cd.depth_image_index as usize].get();

                    let mut dst_subresource = isl;
                    dst_subresource.base_array_layer = cd.depth_image_layer;
                    let image_copy = vk::ImageCopy {
                        src_subresource: isl,
                        src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        dst_subresource,
                        dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        extent: image_extent,
                    };

                    // wait for previous operations on copy image to be finished
                    let image_barrier = make_image_memory_barrier(
                        vk::AccessFlags::MEMORY_READ,
                        vk::AccessFlags::MEMORY_WRITE,
                        general,
                        general,
                        copy_image.get(),
                        ds_range(0, 1),
                    );
                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[image_barrier],
                        );

                        // set copy image to specified depth value
                        let clear_value = vk::ClearDepthStencilValue {
                            depth: cd.depth,
                            stencil: 0,
                        };
                        device.cmd_clear_depth_stencil_image(
                            cmd_buffer,
                            copy_image.get(),
                            general,
                            &clear_value,
                            &[ds_range(0, 1)],
                        );

                        // make sure that data is in the copy image and also that previous operations on the depth/stencil image are finished
                        let buffer_barrier = make_memory_barrier(
                            vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE,
                            vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE,
                        );
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::ALL_COMMANDS,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[buffer_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );

                        // copy image to depth image
                        device.cmd_copy_image(
                            cmd_buffer,
                            copy_image.get(),
                            general,
                            depth_stencil_image,
                            general,
                            &[image_copy],
                        );
                    }
                }
                _ => debug_assert!(false, "missing implementation for other test step types"),
            }
        }

        unsafe {
            // wait for all rendering to be finished
            let post_render_memory_barrier =
                make_memory_barrier(vk::AccessFlags::MEMORY_WRITE, vk::AccessFlags::MEMORY_READ);
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[post_render_memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // dispatch verification compute shader
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *compute_pipeline_layout,
                0,
                &[*compute_descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd_buffer, IMAGE_SIZE, IMAGE_SIZE, 1);
        }

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // verify result
        invalidate_alloc(device, out_buffer_alloc)?;

        // get ninth value from compute buffer, which indicates whether test failed (0 means pass, 1 means fail)
        let mut flag = [0u8; 4];
        unsafe { std::ptr::copy_nonoverlapping(out_buffer_alloc.get_host_ptr().add(32), flag.as_mut_ptr(), 4) };
        if u32::from_ne_bytes(flag) == 0 {
            return Ok(TestStatus::pass("Pass"));
        }

        Ok(TestStatus::fail("Fail"))
    }
}

/// `FuzzTestBuilder`
struct FuzzTestBuilder {
    rng: Random,

    // spec doesn't guarantee that 0.3f written via depth clear is exactly equal to 0.3f
    // written via draw call - to prevent errors like that we try to use different depth value
    // in each operation
    depth_values: Vec<f32>,
}

impl FuzzTestBuilder {
    const UNIQUE_DEPTH_VALUES_COUNT: u32 = 21;

    fn new(seed: u32) -> Self {
        Self {
            rng: Random::new(seed),
            depth_values: Vec::with_capacity(Self::UNIQUE_DEPTH_VALUES_COUNT as usize),
        }
    }

    fn rand_percentage(&mut self) -> u32 {
        self.rng.get_uint32() % 100
    }

    fn rand_depth_image_and_layer(&mut self, use_separate_ds_images: bool) -> (u32, u32) {
        let r = self.rand_percentage();
        let i = if r < 75 {
            0
        } else if r < 90 {
            1
        } else {
            2
        };

        if use_separate_ds_images { (i, 0) } else { (0, i) }
    }

    fn rand_depth(&mut self, bias_towards_bounds: bool) -> f32 {
        if bias_towards_bounds {
            let r = self.rand_percentage();
            if r < 45 {
                return 1.0;
            }
            if r < 80 {
                return 0.0;
            }
        }

        if self.depth_values.is_empty() {
            // generate unique depth values from <0.0, 1.0> range
            let step = 1.0f32 / (Self::UNIQUE_DEPTH_VALUES_COUNT - 1) as f32;
            for i in 0..Self::UNIQUE_DEPTH_VALUES_COUNT {
                self.depth_values.push((step * i as f32).clamp(0.0, 1.0));
            }

            // shuffle values
            self.rng.shuffle(&mut self.depth_values);
        }

        // get value from the back
        self.depth_values.pop().expect("depth values were just generated")
    }

    fn build(&mut self, steps: &mut Vec<TestStep>) {
        // determine number of renderpasses; 45% of cases will have 2rp; 20% of cases will have 3 RP
        let mut r = self.rand_percentage();
        let render_pass_count = 1 + u32::from(r > 55) + u32::from(r > 80) + u32::from(r > 92) + u32::from(r > 95);

        // determine if test will operate on layers of same depth image or on separate ds images
        let use_separate_ds_images = self.rand_percentage() < 50;

        // we need to make sure each depth image view is cleared before being used for the first time
        let mut was_depth_view_cleared = [[false; DEPTH_LAYER_COUNT]; DEPTH_IMAGE_COUNT];

        // force regeneration of depth values to reduce the chance that it will happen mid-test
        self.depth_values.clear();

        for _ in 0..render_pass_count {
            // get random depth view and check if it was cleared
            let (depth_image_index, depth_image_layer) = self.rand_depth_image_and_layer(use_separate_ds_images);
            let was_cleared = was_depth_view_cleared[depth_image_index as usize][depth_image_layer as usize];

            let render_pass_data = self.fuzz_render_pass_data(depth_image_index, depth_image_layer, was_cleared);
            steps.push(TestStep {
                ty: TestStepType::BeginRenderPass,
                data: StepData::BeginRenderPass(render_pass_data),
            });

            // mark used depth image layer as cleared
            was_depth_view_cleared[depth_image_index as usize][depth_image_layer as usize] = true;

            let mut pipeline_data = None;
            let mut require_pipeline_bind = true;

            // determine number of draw steps, 1-6 but biased toward 2-3
            r = self.rand_percentage();
            let draw_count =
                1 + u32::from(r > 20) + u32::from(r > 55) + u32::from(r > 80) + u32::from(r > 95) + u32::from(r > 97);

            for _ in 0..draw_count {
                // bind pipeline when necessary or 30% for new pipeline bind
                if require_pipeline_bind || self.rand_percentage() < 30 {
                    let data = self.fuzz_pipeline_data();
                    pipeline_data = Some(data);
                    require_pipeline_bind = false;
                    steps.push(TestStep {
                        ty: TestStepType::BindPipeline,
                        data: StepData::BindPipeline(data),
                    });
                }

                // 10% for suspend/resume
                if self.rand_percentage() < 10 {
                    require_pipeline_bind = true;
                    steps.push(suspend_resume_rendering());
                }

                // 10% for depth attachment clear
                if self.rand_percentage() < 10 {
                    let depth = self.rand_depth(false);
                    steps.push(TestStep {
                        ty: TestStepType::ClearAttachment,
                        data: StepData::ClearBlitCopy(ClearBlitCopyData {
                            depth,
                            depth_image_index: 0,
                            depth_image_layer: 0,
                        }),
                    });
                }

                let draw_data = self.fuzz_draw(&pipeline_data.expect("a pipeline is always bound before a draw"));
                steps.push(TestStep {
                    ty: TestStepType::Draw,
                    data: StepData::Draw(draw_data),
                });
            }

            steps.push(end_render_pass());

            // 40% for depth image clear / blit / copy
            r = self.rand_percentage();
            if r < 40 {
                let (depth_image, depth_layer) = self.rand_depth_image_and_layer(use_separate_ds_images);
                was_depth_view_cleared[depth_image as usize][depth_layer as usize] = true;

                let mut step_type = TestStepType::Blit;
                if r < 10 {
                    step_type = TestStepType::ClearImage;
                } else if r < 20 {
                    step_type = TestStepType::CopyBuffer;
                } else if r < 30 {
                    step_type = TestStepType::CopyImage;
                }

                let depth = self.rand_depth(false);
                steps.push(TestStep {
                    ty: step_type,
                    data: StepData::ClearBlitCopy(ClearBlitCopyData {
                        depth,
                        depth_image_index: depth_image,
                        depth_image_layer: depth_layer,
                    }),
                });
            }
        }
    }

    fn fuzz_render_pass_data(
        &mut self,
        depth_image_index: u32,
        depth_image_layer: u32,
        was_cleared: bool,
    ) -> BeginRenderPassData {
        let mut depth_load_op = vk::AttachmentLoadOp::CLEAR;
        if was_cleared {
            depth_load_op = if self.rand_percentage() < 70 {
                vk::AttachmentLoadOp::LOAD
            } else {
                depth_load_op
            };
        }

        let stencil_clear_value = if self.rand_percentage() < 80 {
            0
        } else {
            self.rng.get_int(0, 0xFF) as u32
        };

        BeginRenderPassData {
            depth_load_op,
            depth_store_op: vk::AttachmentStoreOp::STORE,
            depth_clear_value: self.rand_depth(true),
            stencil_clear_value,
            depth_image_index,
            depth_image_layer,
        }
    }

    fn fuzz_pipeline_data(&mut self) -> BindPipelineData {
        // `BindPipelineData bpd{FS::BASIC}` - every other member is zero
        let mut bpd = BindPipelineData {
            frag: Fs::Basic,
            depth_test: false,
            depth_write: false,
            depth_compare_op: vk::CompareOp::NEVER,
            stencil_test: false,
            stencil_compare_op: vk::CompareOp::NEVER,
            stencil_pass_op: vk::StencilOp::KEEP,
            stencil_fail_op: vk::StencilOp::KEEP,
            stencil_depth_fail_op: vk::StencilOp::KEEP,
            stencil_compare_mask: 0,
            stencil_write_mask: 0,
            stencil_reference: 0,
            blend: false,
            color_write_mask: vk::ColorComponentFlags::empty(),
            alpha_to_coverage: false,
        };

        let mut r = self.rand_percentage();
        if r < 35 {
            bpd.frag = Fs::ALL[self.rng.get_int(0, Fs::ALL.len() as i32 - 1) as usize];

            // dont use override shaders in fuzzing tests, if override FS are selected use basic shader instead
            if bpd.frag.is_depth_override() {
                bpd.frag = Fs::Basic;
            }

            // decrease chance for DISCARD and EARLY_FRAG_TESTS
            if bpd.frag == Fs::Discard || bpd.frag == Fs::EarlyFragTests {
                bpd.frag = if r < 5 { Fs::Basic } else { bpd.frag };
            }
        }

        // depth test 85%
        bpd.depth_test = self.rand_percentage() < 85;
        bpd.depth_write = bpd.depth_test && self.rand_percentage() < 75;

        // pick compare operation, bias toward LESS / GREATER since those are the interesting LRZ ops
        r = self.rand_percentage();
        bpd.depth_compare_op = vk::CompareOp::LESS;
        if r > 93 {
            bpd.depth_compare_op = vk::CompareOp::NEVER;
        } else if r > 87 {
            bpd.depth_compare_op = vk::CompareOp::ALWAYS;
        } else if r > 81 {
            bpd.depth_compare_op = vk::CompareOp::NOT_EQUAL;
        } else if r > 74 {
            bpd.depth_compare_op = vk::CompareOp::EQUAL;
        } else if r > 64 {
            bpd.depth_compare_op = vk::CompareOp::GREATER_OR_EQUAL;
        } else if r > 54 {
            bpd.depth_compare_op = vk::CompareOp::LESS_OR_EQUAL;
        } else if r > 27 {
            bpd.depth_compare_op = vk::CompareOp::GREATER;
        }

        // stencil 5%
        bpd.stencil_test = self.rand_percentage() < 5;
        if bpd.stencil_test {
            // VK_COMPARE_OP_LAST and VK_STENCIL_OP_LAST are both 8
            bpd.stencil_compare_op = vk::CompareOp::from_raw(self.rng.get_int(0, 7));
            bpd.stencil_pass_op = vk::StencilOp::from_raw(self.rng.get_int(0, 7));
            bpd.stencil_fail_op = vk::StencilOp::from_raw(self.rng.get_int(0, 7));
            bpd.stencil_depth_fail_op = vk::StencilOp::from_raw(self.rng.get_int(0, 7));
            bpd.stencil_compare_mask = if self.rand_percentage() > 70 {
                0xFF
            } else {
                self.rng.get_int(0, 0xFF) as u32
            };
            bpd.stencil_write_mask = if self.rand_percentage() > 70 {
                0xFF
            } else {
                self.rng.get_int(0, 0xFF) as u32
            };
            bpd.stencil_reference = self.rng.get_int(0, 0xFF) as u32;
        }

        // blend 15%
        bpd.blend = self.rand_percentage() < 15;

        // partial color mask 3%
        bpd.color_write_mask = vk::ColorComponentFlags::R
            | vk::ColorComponentFlags::G
            | vk::ColorComponentFlags::B
            | vk::ColorComponentFlags::A;
        if self.rand_percentage() < 3 {
            let channels = [
                vk::ColorComponentFlags::R,
                vk::ColorComponentFlags::G,
                vk::ColorComponentFlags::B,
                vk::ColorComponentFlags::A,
            ];
            let mut mask = vk::ColorComponentFlags::empty();
            for channel in channels {
                if self.rand_percentage() < 50 {
                    mask |= channel;
                }
            }
            if !mask.is_empty() {
                bpd.color_write_mask = mask;
            }
        }

        // alpha to coverage 5%
        bpd.alpha_to_coverage = self.rand_percentage() < 5;

        bpd
    }

    fn fuzz_draw(&mut self, pipeline_data: &BindPipelineData) -> DrawData {
        const COLOR_VALUE: [f32; 5] = [0.0, 0.25, 0.5, 0.75, 1.0];
        let mut color = [1.0f32; 4];

        for channel in color.iter_mut().take(3) {
            *channel = COLOR_VALUE[self.rng.get_int(0, COLOR_VALUE.len() as i32 - 1) as usize];
        }

        if pipeline_data.alpha_to_coverage {
            color[3] = if self.rand_percentage() < 50 { 1.0 } else { 0.0 };
        } else if pipeline_data.frag != Fs::Discard {
            color[3] = if self.rand_percentage() < 20 {
                1.0
            } else {
                COLOR_VALUE[self.rng.get_int(0, 3) as usize]
            };
        }

        DrawData {
            color,
            depth: self.rand_depth(false),
            height: 1.0,
            mode: DrawMode::FullQuad,
        }
    }
}

/// `createFuzzGroup`
fn create_fuzz_group(count: u32, seed: u32, group_params: GroupParams) -> TestCaseGroup {
    let rendering_type = match group_params.rendering_type {
        RenderingType::Legacy => 0,
        RenderingType::RenderPass2 => 1,
        RenderingType::DynamicRendering => 2,
    };
    let mut test_builder = FuzzTestBuilder::new(
        seed + rendering_type
            + u32::from(group_params.use_secondary_cmd_buffer)
            + u32::from(group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass),
    );

    let mut fuzz_group = TestCaseGroup::new("fuzz");
    for case_index in 0..count {
        let mut test_params = TestParams {
            name: case_index.to_string(),
            steps: Vec::new(),
        };
        test_builder.build(&mut test_params.steps);

        fuzz_group.add_child(Box::new(LrzTestCase {
            params: test_params,
            group_params,
        }) as Box<dyn TestCase>);
    }
    fuzz_group
}

fn case(name: &str, steps: Vec<TestStep>) -> TestParams {
    TestParams {
        name: name.to_string(),
        steps,
    }
}

fn all_color_components() -> vk::ColorComponentFlags {
    vk::ColorComponentFlags::R | vk::ColorComponentFlags::G | vk::ColorComponentFlags::B | vk::ColorComponentFlags::A
}

/// `createChildren`
fn create_children(lrz_tests: &mut TestCaseGroup, group_params: GroupParams) {
    // Each test is constructed from a series of steps that are used to build test command buffer.
    // To simplify test configuration, some steps are removed/inserted in the preprocess_steps method.

    use vk::{AttachmentLoadOp as Load, CompareOp as Op, StencilOp as SOp};

    let fsb = Fs::Basic;
    let all = all_color_components();

    let direction_change = vec![
        // Direction change with depth write -> invalidates LRZ.
        // Uses checkerboard rows so both GREATER and LESS draws write
        // fragments into the same LRZ block. Draw 2 (full screen,
        // GREATER 0.3) gets rejected by corrupted LRZ values.
        case(
            "greater_to_less_write",
            vec![
                begin_render_pass(Load::CLEAR, 0.5),
                bind_pipeline(Op::GREATER),
                draw_mode([1.0, 0.0, 0.0, 1.0], 0.8, DrawMode::OddRows),
                bind_pipeline(Op::LESS),
                draw_mode([0.0, 1.0, 0.0, 1.0], 0.2, DrawMode::EvenRows),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // LESS -> GREATER direction change on checkerboard.
        // Clear=1.0. Draw 0 (even, LESS 0.2) lowers LRZ to 0.2.
        // Draw 1 (odd, GREATER 0.8) raises shared-block LRZ to 0.8.
        // Draw 2 (full, GREATER 0.7): on even rows real depth=0.2,
        // 0.7>0.2=true -> should draw, but LRZ=0.8 rejects (0.7 <= 0.8).
        case(
            "less_to_greater_write",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw_mode([1.0, 0.0, 0.0, 1.0], 0.2, DrawMode::EvenRows),
                bind_pipeline(Op::GREATER),
                draw_mode([0.0, 1.0, 0.0, 1.0], 0.8, DrawMode::OddRows),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // Same as greater_to_less_write but with LESS_OR_EQUAL / GREATER_OR_EQUAL
        case(
            "ge_to_le_write",
            vec![
                begin_render_pass(Load::CLEAR, 0.5),
                bind_pipeline(Op::GREATER_OR_EQUAL),
                draw_mode([1.0, 0.0, 0.0, 1.0], 0.8, DrawMode::OddRows),
                bind_pipeline(Op::LESS_OR_EQUAL),
                draw_mode([0.0, 1.0, 0.0, 1.0], 0.2, DrawMode::EvenRows),
                bind_pipeline(Op::GREATER_OR_EQUAL),
                draw([0.0, 1.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // Double direction change -> GREATER -> LESS -> GREATER.
        // 4 draws with checkerboard. After two direction flips the LRZ
        // buffer is thoroughly corrupted.
        case(
            "double_flip",
            vec![
                begin_render_pass(Load::CLEAR, 0.5),
                bind_pipeline(Op::GREATER),
                draw_mode([1.0, 0.0, 0.0, 1.0], 0.8, DrawMode::OddRows),
                bind_pipeline(Op::LESS),
                draw_mode([0.0, 1.0, 0.0, 1.0], 0.2, DrawMode::EvenRows),
                bind_pipeline(Op::GREATER),
                draw_mode([0.0, 0.0, 1.0, 1.0], 0.6, DrawMode::OddRows),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // Full-screen draws only.
        // LESS with blend, then LESS with write, then GREATER overwrites
        case(
            "fuzz_less_blend_to_greater",
            vec![
                begin_render_pass_default(),
                bind_blend_pipeline(Op::LESS, false, true, vk::ColorComponentFlags::B, false),
                draw([0.0, 0.5, 0.0, 1.0], 0.5),
                bind_blend_pipeline(Op::LESS, true, true, vk::ColorComponentFlags::empty(), false),
                draw([0.25, 0.5, 1.0, 0.75], 0.2),
                bind_pipeline(Op::GREATER),
                draw([0.25, 1.0, 1.0, 0.25], 0.75),
                end_render_pass(),
            ],
        ),
        // LESS -> GREATER without depth write -> no invalidation
        case(
            "less_to_greater_no_write",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline_with(Op::GREATER, fsb, true, false),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.4),
                end_render_pass(),
            ],
        ),
    ];

    let direction_preserve = vec![
        // GREATER -> EQUAL -> GREATER preserves direction
        case(
            "greater_equal_greater",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::EQUAL),
                draw([0.0, 1.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.8),
                end_render_pass(),
            ],
        ),
        // GREATER -> EQUAL -> LESS invalidates
        case(
            "greater_equal_less",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::EQUAL),
                draw([0.0, 1.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // LESS -> ALWAYS with depth write -> invalidates
        case(
            "less_to_always_write",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::ALWAYS),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // LESS -> ALWAYS without depth write -> no invalidation
        case(
            "less_to_always_no_write",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline_with(Op::ALWAYS, fsb, true, false),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.4),
                end_render_pass(),
            ],
        ),
        // LESS -> NOT_EQUAL with depth write -> invalidates
        case(
            "less_to_not_equal_write",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::NOT_EQUAL),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // LESS -> NEVER -> LESS re-enables LRZ
        case(
            "less_never_less",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::NEVER),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.4),
                end_render_pass(),
            ],
        ),
        // No depth test enabled at all
        case(
            "no_depth_test",
            vec![
                begin_render_pass_default(),
                bind_pipeline_with(Op::NEVER, fsb, false, false),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
    ];

    let blend = vec![
        // The blending + depth write corruption scenario
        case(
            "depth_corruption_scenario",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_blend_pipeline(Op::GREATER, true, true, all, false),
                draw([0.0, 1.0, 0.0, 0.5], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        // Partial color mask + depth write -> disables LRZ write
        case(
            "partial_color_mask_depth_write",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_blend_pipeline(
                    Op::LESS,
                    true,
                    false,
                    vk::ColorComponentFlags::R | vk::ColorComponentFlags::G,
                    false,
                ),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // Draw 1 writes color+depth, draw 2 writes depth only (all color writes disabled).
        // LRZ write must be disabled for the RP because draw 1's depth-only write could
        // corrupt the LRZ buffer. If LRZ write is not disabled, draw 2 writes LRZ=0.4 and
        // draw 1 at depth 0.1 is rejected by LRZ in the rendering pass.
        case(
            "color_masked_after_color_depth",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_blend_pipeline(Op::GREATER, true, false, vk::ColorComponentFlags::empty(), false),
                draw([0.0, 1.0, 0.0, 1.0], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
    ];

    let edge = vec![
        // vkCmdClearAttachments on depth mid-RP -> invalidates LRZ
        case(
            "mid_rp_depth_clear",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                clear_depth_attachment(0.8),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // Depth bounds test coexists with LRZ
        case(
            "depth_bounds_test",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // No depth attachment - LRZ should be fully disabled
        case(
            "no_depth_attachment",
            vec![
                begin_render_pass_default(),
                bind_pipeline_with(Op::LESS, Fs::Basic, false, true),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // Alpha to coverage + depth write -> LRZ write disabled.
        case(
            "alpha_to_coverage",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_blend_pipeline(Op::GREATER, true, false, all, true),
                draw([0.0, 1.0, 0.0, 0.0], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
    ];

    let stencil = vec![
        // Stencil compare != ALWAYS disables LRZ write
        // Draw 1's stencil EQUAL ref = 1 fails(stencil buffer is 0), so the fragment is killed and
        // depth stays at 0.5. If LRZ write were not *disabled, LRZ would record 0.3,
        // and draw 2 at depth 0.4(which should pass against real depth 0.5) would be incorrectly rejected.
        case(
            "compare_neq_always",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                // Draw 1: establish depth = 0.5, stencil stays 0 (clear value)
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_stencil_pipeline(Op::LESS, Op::EQUAL, SOp::KEEP, SOp::KEEP, SOp::KEEP, 0xFF, 0xFF, 0x1),
                // Draw 2: stencil EQUAL ref = 1 fails(buf = 0), fragment killed, depth stays 0.5. LRZ write must be disabled.
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                bind_pipeline(Op::LESS),
                // Draw 3: depth 0.4 < 0.5 -> should pass. If LRZ was wrongly written to 0.3 above, LRZ rejects(0.4 >= 0.3).
                draw([0.0, 0.0, 1.0, 1.0], 0.4),
                end_render_pass(),
            ],
        ),
        // Stencil depthFailOp writes stencil on depth fail
        // Draw 2 fails depth(0.8 not< 0.5) but depthFailOp = REPLACE must still write stencil = 0x42.
        // If LRZ incorrectly rejects draw 2, the stencil write is skipped and draw 3(which requires
        // stencil == 0x42) will fail, producing wrong color.
        case(
            "stencil_depth_fail_op_writes",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                // depth fails(0.8 not< 0.5), depthFailOp writes stencil = 0x42. LRZ must be disabled so this draw executes.
                bind_stencil_pipeline(
                    Op::LESS,
                    Op::ALWAYS,
                    SOp::KEEP,
                    SOp::KEEP,
                    SOp::REPLACE,
                    0xFF,
                    0xFF,
                    0x42,
                ),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                // Draw 3: stencil EQUAL ref = 0x42 gates a depth - passing draw.
                // If draw 1's stencil write was skipped, stencil is 0 -> fails.
                bind_stencil_pipeline(Op::LESS, Op::EQUAL, SOp::KEEP, SOp::KEEP, SOp::KEEP, 0xFF, 0x0, 0x42),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // The blending + depth write corruption scenario
        case(
            "always_both_faces",
            vec![
                begin_render_pass_default(),
                // Draw 1: establish depth=0.1
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                // Draw 2: stencil ALWAYS passOp=REPLACE triggers stencil_written_based_on_depth_test.
                // LRZ write must be disabled.
                bind_stencil_pipeline(
                    Op::GREATER,
                    Op::GREATER,
                    SOp::REPLACE,
                    SOp::KEEP,
                    SOp::KEEP,
                    0xFF,
                    0xFF,
                    0x1,
                ),
                draw([0.0, 1.0, 0.0, 0.5], 0.4),
                // Draw 3: fails depth (0.2 < 0.4)
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
    ];

    let fragment_shader = vec![
        // layout(depth_greater) + LESS compare
        case(
            "depth_greater_with_less_compare",
            vec![
                begin_render_pass_default(),
                bind_pipeline_with(Op::LESS, Fs::DepthGreater, true, true),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // layout(depth_less) + LESS compare -> LRZ disabled for draw
        case(
            "depth_less_with_less_compare",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline_with(Op::LESS, Fs::DepthLess, true, true),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // layout(depth_unchanged) + any compare
        case(
            "depth_unchanged",
            vec![
                begin_render_pass_default(),
                bind_pipeline_with(Op::LESS, Fs::DepthUnchanged, true, true),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // layout(depth_greater) + GREATER compare -> incompatible.
        // FS with depth_greater hint writes 1.0 - pc.depth(increases depth).
        // Draw 2: vertex depth = 0.3, FS depth = 0.7. LRZ sees 0.3 > 0.5 = false -> rejects.
        // Real test: 0.7 > 0.5 = true -> should draw.
        case(
            "depth_greater_with_greater_compare",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline_with(Op::GREATER, Fs::DepthGreaterOverride, true, true),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // layout(depth_less) + LESS compare -> incompatible.
        // FS with depth_less hint writes 1.0 - pc.depth(decreases depth).
        // Draw 2: vertex depth = 0.7, FS depth = 0.3. LRZ sees 0.7 < 0.5 = false -> rejects.
        // Real test: 0.3 < 0.5 = true -> should draw.
        case(
            "depth_less_override_with_less_compare",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline_with(Op::LESS, Fs::DepthLessOverride, true, true),
                draw([0.0, 1.0, 0.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // FS writes gl_FragDepth with no layout hint -> LRZ must be disabled.
        // Draw 2 uses WRITE_DEPTH_OVERRIDE which writes gl_FragDepth = 1.0 - 0.8 = 0.2.
        // Vertex depth 0.8 would fail * LRZ(0.8 > 0.5), but post - FS depth 0.2 passes LESS(0.2 < 0.5).
        // If LRZ isn't disabled, the fragment is incorrectly rejected.
        case(
            "frag_depth_no_hint",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline_with(Op::LESS, Fs::WriteDepthOverride, true, true),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                end_render_pass(),
            ],
        ),
        // layout(early_fragment_tests) -> normal LRZ.
        case(
            "early_frag_tests",
            vec![
                begin_render_pass_default(),
                bind_pipeline_with(Op::LESS, Fs::EarlyFragTests, true, true),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // FS with discard + depth write -> LRZ write disabled.
        // Draw 2 discards(alpha = 0) so depth stays at 0.1. If LRZ write were not disabled,
        // LRZ would record 0.4(written before late - Z evaluates discard).
        // Draw 3 at 0.2 GREATER would then be incorrectly rejected by LRZ(0.2 not> 0.4).
        case(
            "discard_with_depth_write",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_pipeline_with(Op::GREATER, Fs::Discard, true, true),
                draw([0.0, 1.0, 0.0, 0.0], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "atomics",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_pipeline_with(Op::GREATER, Fs::Atomic, true, true),
                draw([0.0, 1.0, 0.0, 0.0], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "image_store",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_pipeline_with(Op::GREATER, Fs::ImageStore, true, true),
                draw([0.0, 1.0, 0.0, 0.0], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
    ];

    let suspend_resume = vec![
        // S/R with LESS draws across boundary
        case(
            "less_across_boundary",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.1),
                end_render_pass(),
            ],
        ),
        // Direction change invalidates -> propagates across S/R
        case(
            "invalidation_propagates",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                suspend_resume_rendering(),
                // Direction change invalidates LRZ
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                // After resume: LRZ should still be invalidated
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.4),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // Stencil disables LRZ write -> propagates across S/R
        case(
            "write_disable_propagates",
            vec![
                begin_render_pass_default(),
                suspend_resume_rendering(),
                bind_stencil_pipeline(Op::LESS, Op::EQUAL, SOp::KEEP, SOp::KEEP, SOp::KEEP, 0xFF, 0xFF, 0),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                // after resume: LRZ write should still be disabled
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "write_disable_before_boundary",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_blend_pipeline(Op::GREATER, true, true, all, false),
                draw_mode([0.0, 1.0, 0.0, 0.5], 0.4, DrawMode::EvenRows),
                suspend_resume_rendering(),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        // Once disabled, LRZ writes must remain disabled.
        case(
            "write_disable_across_two_boundaries",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                bind_blend_pipeline(Op::GREATER, true, true, all, false),
                draw_mode([0.0, 1.0, 0.0, 0.5], 0.4, DrawMode::EvenRows),
                suspend_resume_rendering(),
                bind_pipeline(Op::GREATER),
                draw_mode([1.0, 1.0, 0.0, 1.0], 0.3, DrawMode::OddRows),
                suspend_resume_rendering(),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "always_invalidation_before_boundary",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::ALWAYS),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // Invalidate LRZ in a segment that is both resumed and suspended.
        case(
            "invalidation_in_middle_segment",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                suspend_resume_rendering(),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
    ];

    let secondary = vec![
        // Primary sets LESS direction -> secondary draws LESS
        case(
            "inherits_direction",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                begin_secondary(),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_secondary(),
                end_render_pass(),
            ],
        ),
        // Primary invalidates LRZ -> secondary should see it disabled
        case(
            "inherits_invalidation",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                begin_secondary(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.4),
                end_secondary(),
                end_render_pass(),
            ],
        ),
        case(
            "secondary_less_greater_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                begin_secondary(),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                end_secondary(),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // Primary disables LRZ write -> secondary inherits
        case(
            "inherits_write_disable",
            vec![
                begin_render_pass_default(),
                // Stencil compare != ALWAYS -> disables LRZ write
                bind_stencil_pipeline(Op::LESS, Op::EQUAL, SOp::KEEP, SOp::KEEP, SOp::KEEP, 0xFF, 0xFF, 0),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                begin_secondary(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_secondary(),
                end_render_pass(),
            ],
        ),
        // Multiple sequential draws in secondary
        case(
            "multiple_sequential_draws",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                begin_secondary(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.9),
                draw([0.0, 1.0, 0.0, 1.0], 0.7),
                draw([0.0, 0.0, 1.0, 1.0], 0.5),
                draw([1.0, 1.0, 0.0, 1.0], 0.3),
                draw([0.0, 1.0, 1.0, 1.0], 0.1),
                end_secondary(),
                end_render_pass(),
            ],
        ),
        case(
            "secondary_write_disable_before_primary",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                begin_secondary(),
                bind_blend_pipeline(Op::GREATER, true, true, all, false),
                draw_mode([0.0, 1.0, 0.0, 0.5], 0.4, DrawMode::EvenRows),
                end_secondary(),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "depth_only_secondary_after_primary_color",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                begin_secondary(),
                bind_blend_pipeline(Op::GREATER, true, false, vk::ColorComponentFlags::empty(), false),
                draw_mode([0.0, 1.0, 0.0, 1.0], 0.4, DrawMode::EvenRows),
                end_secondary(),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "primary_invalidation_before_secondary",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                begin_secondary(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_secondary(),
                end_render_pass(),
            ],
        ),
        case(
            "invalidation_across_two_secondaries",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                begin_secondary(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 1.0, 1.0], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                end_secondary(),
                begin_secondary(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_secondary(),
                end_render_pass(),
            ],
        ),
        case(
            "write_disable_across_two_secondaries",
            vec![
                begin_render_pass(Load::CLEAR, 0.0),
                bind_pipeline(Op::GREATER),
                draw([1.0, 0.0, 0.0, 1.0], 0.1),
                begin_secondary(),
                bind_blend_pipeline(Op::GREATER, true, true, all, false),
                draw_mode([0.0, 1.0, 0.0, 0.5], 0.4, DrawMode::EvenRows),
                end_secondary(),
                begin_secondary(),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_secondary(),
                end_render_pass(),
            ],
        ),
    ];

    let cross_renderpass = vec![
        case(
            "reuse_same_direction",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        case(
            "invalidated_persists_on_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.4),
                end_render_pass(),
            ],
        ),
        case(
            "mid_rp_clear_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                clear_depth_attachment(0.8),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        case(
            "direction_change_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        case(
            "always_write_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::ALWAYS),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        case(
            "clear_recovers_after_invalidation",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                end_render_pass(),
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        // Blit overwrites depth to 0.8 (was 0.3 from first draw), making LRZ stale.
        case(
            "blit_invalidates",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.3),
                end_render_pass(),
                blit_depth(0.8),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.5),
                end_render_pass(),
            ],
        ),
        case(
            "clear_invalidates",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                clear_depth_image(0.2),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        case(
            "copy_buffer_invalidates",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.3),
                end_render_pass(),
                copy_buffer(0.8),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.5),
                end_render_pass(),
            ],
        ),
        case(
            "copy_image_invalidates",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.3),
                end_render_pass(),
                copy_image(0.8),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.5),
                end_render_pass(),
            ],
        ),
        case(
            "different_images_ab_a",
            vec![
                begin_render_pass_full(Load::CLEAR, 1.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass_full(Load::CLEAR, 0.0, vk::AttachmentStoreOp::STORE, 0, 1, 0),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass_full(Load::LOAD, 0.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        case(
            "direction_change",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 0.0),
                bind_pipeline(Op::GREATER),
                draw([0.0, 0.0, 1.0, 1.0], 0.8),
                end_render_pass(),
            ],
        ),
        case(
            "write_disable_resets_across_rp",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_blend_pipeline(Op::LESS, true, true, all, false),
                draw([0.0, 1.0, 0.0, 0.5], 0.3),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 0.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "concurrent_binning_chain",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 0.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 0.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "store_dont_care_then_load",
            vec![
                begin_render_pass_full(Load::CLEAR, 1.0, vk::AttachmentStoreOp::DONT_CARE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                // depth loaded is undefined (storeOp was DONT_CARE), use ALWAYS
                // so draw passes regardless. Tests driver handles edge case.
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::ALWAYS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        case(
            "three_images_rotation",
            vec![
                begin_render_pass_full(Load::CLEAR, 1.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass_full(Load::CLEAR, 0.0, vk::AttachmentStoreOp::STORE, 0, 1, 0),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass_full(Load::CLEAR, 1.0, vk::AttachmentStoreOp::STORE, 0, 2, 0),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.7),
                end_render_pass(),
                begin_render_pass_full(Load::LOAD, 0.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        case(
            "three_layers_rotation",
            vec![
                begin_render_pass_full(Load::CLEAR, 1.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass_full(Load::CLEAR, 0.0, vk::AttachmentStoreOp::STORE, 0, 0, 1),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass_full(Load::CLEAR, 1.0, vk::AttachmentStoreOp::STORE, 0, 0, 2),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.7),
                end_render_pass(),
                begin_render_pass_full(Load::LOAD, 0.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
    ];

    let cross_renderpass_suspend_resume = vec![
        case(
            "sr_storeop_from_last_segment",
            vec![
                begin_render_pass_default(),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 0.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "dont_care_load_no_reuse",
            vec![
                begin_render_pass_default(),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                // depth is undefined (loadOp=DONT_CARE), use ALWAYS so draw passes regardless
                begin_render_pass(Load::DONT_CARE, 0.0),
                bind_pipeline(Op::ALWAYS),
                draw([0.0, 0.0, 1.0, 1.0], 0.3),
                end_render_pass(),
            ],
        ),
        case(
            "rp_before_sr_chain_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 1.0, 1.0], 0.4),
                bind_pipeline(Op::GREATER),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.79),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.74),
                end_render_pass(),
            ],
        ),
        case(
            "sr_chain_blend_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                bind_blend_pipeline(Op::GREATER, true, true, all, false),
                draw([0.0, 1.0, 0.0, 0.5], 0.8),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.75),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.7),
                end_render_pass(),
            ],
        ),
        // S/R chain (Phase 1 suspend -> Phase 2 resume) then Phase 3 loads.
        // Tests that storeOp is taken from the resuming phase (Phase 2), not the
        // suspending phase (Phase 1). This is the concurrent binning storeOp bug
        // scenario: the merged S/R chain must correctly store depth for Phase 3.
        case(
            "sr_chain_then_load",
            vec![
                begin_render_pass_full(Load::CLEAR, 1.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                end_render_pass(),
                begin_render_pass_full(Load::LOAD, 0.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
                // Phase 3: separate RP that loads depth stored by the S/R chain
                begin_render_pass_full(Load::LOAD, 0.0, vk::AttachmentStoreOp::STORE, 0, 0, 0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        // 3-way S/R chain (Phase 1 -> Phase 2 -> Phase 3) then Phase 4 loads.
        // Exercises longer S/R chains where only the final phase's storeOp matters.
        case(
            "sr_chain_3way_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                suspend_resume_rendering(),
                draw([0.0, 1.0, 0.0, 1.0], 0.4),
                suspend_resume_rendering(),
                draw([1.0, 1.0, 0.0, 1.0], 0.3),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        // Two separate S/R chains back-to-back, both loading / storing depth.
        // Chain 1: Phase 1(suspend) -> Phase 2(resume, stores).
        // Chain 2: Phase 3(suspend, loads) -> Phase 4(resume, stores).
        // Tests concurrent binning WAR tracking between two merged chains.
        case(
            "two_sr_chains",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.5),
                suspend_resume_rendering(),
                draw([0.0, 1.0, 0.0, 1.0], 0.4),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.3),
                suspend_resume_rendering(),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        // Plain CLEAR RP, then two S/R chains both loading depth.
        // Phase 1: normal RP with CLEAR(establishes depth + LRZ).
        // Chain 1: Phase 2(suspend, LOAD) -> Phase 3(resume, STORE).
        // Chain 2: Phase 4(suspend, LOAD) -> Phase 5(resume, STORE).
        // Tests concurrent binning WAR tracking when initial depth comes
        // from a non - S/R renderpass followed by two merged S/R chains.
        case(
            "clear_then_two_sr_chains",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.6),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.5),
                suspend_resume_rendering(),
                draw([1.0, 1.0, 0.0, 1.0], 0.4),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 1.0, 1.0], 0.3),
                suspend_resume_rendering(),
                draw([0.0, 0.0, 1.0, 1.0], 0.2),
                end_render_pass(),
            ],
        ),
        case(
            "always_invalidation_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.25),
                bind_pipeline(Op::ALWAYS),
                draw([0.0, 1.0, 0.0, 1.0], 0.8),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([1.0, 1.0, 0.0, 1.0], 0.7),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.6),
                end_render_pass(),
            ],
        ),
        case(
            "middle_clear_invalidation_then_load",
            vec![
                begin_render_pass_default(),
                bind_pipeline(Op::LESS),
                draw([1.0, 0.0, 0.0, 1.0], 0.25),
                suspend_resume_rendering(),
                clear_depth_attachment(0.8),
                suspend_resume_rendering(),
                bind_pipeline(Op::LESS),
                draw([0.0, 1.0, 0.0, 1.0], 0.7),
                end_render_pass(),
                begin_render_pass(Load::LOAD, 1.0),
                bind_pipeline(Op::LESS),
                draw([0.0, 0.0, 1.0, 1.0], 0.6),
                end_render_pass(),
            ],
        ),
    ];

    let mut create_case_group = |group_name: &str, test_params: Vec<TestParams>| {
        let mut test_group = TestCaseGroup::new(group_name);
        for params in test_params {
            test_group.add_child(Box::new(LrzTestCase { params, group_params }) as Box<dyn TestCase>);
        }
        lrz_tests.add_child(test_group);
    };

    create_case_group("direction_change", direction_change);
    create_case_group("direction_preserve", direction_preserve);
    create_case_group("blend", blend);
    create_case_group("edge", edge);
    create_case_group("stencil", stencil);
    create_case_group("fragment_shader", fragment_shader);
    create_case_group("cross_renderpass", cross_renderpass);

    if group_params.use_secondary_cmd_buffer
        && !group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass
    {
        create_case_group("secondary", secondary);
    }

    if (group_params.rendering_type == RenderingType::DynamicRendering && !group_params.use_secondary_cmd_buffer)
        || (group_params.use_secondary_cmd_buffer
            && group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass)
    {
        create_case_group("suspend_resume", suspend_resume);
        create_case_group("cross_renderpass_suspend_resume", cross_renderpass_suspend_resume);
    }

    // note different fuzz tests are created for each flag combination in group_params
    lrz_tests.add_child(create_fuzz_group(16, 0xba5eba11, group_params));
}

/// `createRenderPassLowResolutionZTests`
pub fn create_render_pass_low_resolution_z_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut lrz_tests = TestCaseGroup::new("low_resolution_z");
    create_children(&mut lrz_tests, group_params);
    lrz_tests
}
