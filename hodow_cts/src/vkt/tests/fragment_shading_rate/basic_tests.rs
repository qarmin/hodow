// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_rate/vktFragmentShadingRateBasic.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/fragment_shading_rate_basic.toml, one entry per
// combination of the case flags each program depends on (`scripts/gen_fsr_basic_manifest.py`), found by `vertex_key`, `mesh_key`,
// `fragment_key` and `compute_key` below. `GraphicsPipelineWrapper` is `DrawPipelineState` with a pipeline construction type, and
// `RenderPassWrapper` is a render pass created with `vkCreateRenderPass2`, its framebuffer and the begin and end commands written out
// here. Not ported: `garbageAttachment`, which only the attachment rate tests set. The three `multipass` groups draw a quad in a second
// subpass without a shading rate (`vert_simple`/`frag_simple`) into a second colour image, which is read back by a copy.
//
// A frame of 81 triangles is drawn with a pipeline, primitive and attachment shading rate each, the fragment shader records the rate
// it ran with, and the host checks every recorded rate against the set the combiner operations allow (`simulate`).

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtMeshShaderExtensionDeviceCommands, InstanceV1_1, KhrCreateRenderpass2ExtensionDeviceCommands,
    KhrFragmentShadingRateExtensionDeviceCommands,
};

use super::{
    GroupParams, fragment_shading_rate_features, fragment_shading_rate_properties, supported_fragment_shading_rates,
};
use crate::generated::shaders::fragment_shading_rate_basic::ALL_SHARED_PROGRAM;
use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::mesh_shader::util::mesh_shader_features;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NUM_TRIANGLES: usize = 9 * 9;
const CB_FORMAT: vk::Format = vk::Format::R32G32B32A32_UINT;

/// Error codes written by the fragment shader
const ERROR_FRAGCOORD_CENTER: u32 = 1;
const ERROR_VTG_READBACK: u32 = 2;
const ERROR_FRAGCOORD_DERIV: u32 = 3;
const ERROR_FRAGCOORD_IMPLICIT_DERIV: u32 = 4;

const SR_FILL_FORMATS: [vk::Format; 16] = [
    vk::Format::R8_UINT,
    vk::Format::R8G8_UINT,
    vk::Format::R8G8B8_UINT,
    vk::Format::R8G8B8A8_UINT,
    vk::Format::R16_UINT,
    vk::Format::R16G16_UINT,
    vk::Format::R16G16B16_UINT,
    vk::Format::R16G16B16A16_UINT,
    vk::Format::R32_UINT,
    vk::Format::R32G32_UINT,
    vk::Format::R32G32B32_UINT,
    vk::Format::R32G32B32A32_UINT,
    vk::Format::R64_UINT,
    vk::Format::R64G64_UINT,
    vk::Format::R64G64B64_UINT,
    vk::Format::R64G64B64A64_UINT,
];

fn cb_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::SAMPLED
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::TRANSFER_SRC
}

fn ds_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        | vk::ImageUsageFlags::SAMPLED
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
}

/// The size of a texel of one of `SR_FILL_FORMATS` (`tcu::getPixelSize(mapVkFormat(format))`).
pub(super) fn sr_fill_pixel_size(format: vk::Format) -> u32 {
    let components = match format {
        vk::Format::R8_UINT | vk::Format::R16_UINT | vk::Format::R32_UINT | vk::Format::R64_UINT => 1,
        vk::Format::R8G8_UINT | vk::Format::R16G16_UINT | vk::Format::R32G32_UINT | vk::Format::R64G64_UINT => 2,
        vk::Format::R8G8B8_UINT
        | vk::Format::R16G16B16_UINT
        | vk::Format::R32G32B32_UINT
        | vk::Format::R64G64B64_UINT => 3,
        _ => 4,
    };
    let component_size = match format {
        vk::Format::R8_UINT | vk::Format::R8G8_UINT | vk::Format::R8G8B8_UINT | vk::Format::R8G8B8A8_UINT => 1,
        vk::Format::R16_UINT | vk::Format::R16G16_UINT | vk::Format::R16G16B16_UINT | vk::Format::R16G16B16A16_UINT => {
            2
        }
        vk::Format::R32_UINT | vk::Format::R32G32_UINT | vk::Format::R32G32B32_UINT | vk::Format::R32G32B32A32_UINT => {
            4
        }
        _ => 8,
    };
    components * component_size
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AttachmentUsage {
    NoAttachment,
    NoAttachmentPtr,
    WithAttachment,
    /// No imageview at VkRenderingFragmentShadingRateAttachmentInfoKHR.
    WithAttachmentWithoutImageView,
}

#[derive(Clone, Copy)]
pub struct CaseDef {
    pub group_params: GroupParams,
    pub seed: i32,
    pub framebuffer_dim: vk::Extent2D,
    pub samples: vk::SampleCountFlags,
    pub combiner_op: [vk::FragmentShadingRateCombinerOpKHR; 2],
    pub attachment_usage: AttachmentUsage,
    pub shader_writes_rate: bool,
    pub geometry_shader: bool,
    pub mesh_shader: bool,
    pub use_dynamic_state: bool,
    pub use_api_sample_mask: bool,
    pub use_sample_mask_in: bool,
    pub use_sample_mask_out: bool,
    pub conservative_enable: bool,
    pub conservative_mode: vk::ConservativeRasterizationModeEXT,
    pub use_depth_stencil: bool,
    pub frag_depth: bool,
    pub frag_stencil: bool,
    pub multi_viewport: bool,
    pub color_layered: bool,
    /// colorLayered must also be true
    pub sr_layered: bool,
    pub num_color_layers: u32,
    pub multi_view: bool,
    pub correlation_mask: bool,
    pub interlock: bool,
    pub sample_locations: bool,
    pub sample_shading_enable: bool,
    pub sample_shading_input: bool,
    pub sample_mask_test: bool,
    pub early_and_late_test: bool,
    pub ds_clear_op: bool,
    pub ds_base_mip_level: u32,
    pub ds_base_layer: u32,
    pub maintenance6: bool,
    pub helper_invocation: bool,
    pub multi_subpasses: bool,
}

impl CaseDef {
    fn use_attachment(&self) -> bool {
        self.attachment_usage == AttachmentUsage::WithAttachment
    }

    fn use_attachment_without_image_view(&self) -> bool {
        self.attachment_usage == AttachmentUsage::WithAttachmentWithoutImageView
    }

    fn sample_count(&self) -> u32 {
        self.samples.bits()
    }

    /// Whether the vertex stage's depth is the constant 0.4 rather than 0.
    fn vertex_depth_is_constant(&self) -> bool {
        !self.frag_depth && self.use_depth_stencil
    }
}

fn flag(value: bool) -> u32 {
    u32::from(value)
}

/// The key of the `vs_*` manifest entry (vert, vert_1_2 and geom).
fn vertex_key(data: &CaseDef) -> String {
    format!(
        "vs_w{}_g{}_p{}_l{}_d{}",
        flag(data.shader_writes_rate),
        flag(data.geometry_shader),
        flag(data.multi_viewport),
        flag(data.color_layered),
        flag(data.vertex_depth_is_constant())
    )
}

/// The key of the `ms_*` manifest entry.
fn mesh_key(data: &CaseDef) -> String {
    format!(
        "ms_w{}_p{}_l{}_d{}",
        flag(data.shader_writes_rate),
        flag(data.multi_viewport),
        flag(data.color_layered),
        flag(data.vertex_depth_is_constant())
    )
}

/// The key of the `fs_*` manifest entry.
fn fragment_key(data: &CaseDef) -> String {
    format!(
        "fs_w{}_e{}_fd{}_fs{}_il{}_hi{}_si{}_se{}_so{}_sm{}",
        flag(data.shader_writes_rate),
        flag(data.early_and_late_test),
        flag(data.frag_depth),
        flag(data.frag_stencil),
        flag(data.interlock),
        flag(data.helper_invocation),
        flag(data.sample_shading_input),
        flag(data.sample_shading_enable),
        flag(data.use_sample_mask_out),
        flag(data.use_sample_mask_in)
    )
}

/// The key of the `simple_*` manifest entry (vert_simple and frag_simple).
fn simple_key(data: &CaseDef) -> String {
    format!(
        "simple_fd{}_fs{}_vd{}",
        flag(data.frag_depth),
        flag(data.frag_stencil),
        flag(data.vertex_depth_is_constant())
    )
}

/// The key of the `cs_*` manifest entry.
fn compute_key(data: &CaseDef) -> String {
    format!(
        "cs_s{}_w{}_h{}_d{}",
        data.sample_count(),
        data.framebuffer_dim.width,
        data.framebuffer_dim.height,
        flag(data.use_depth_stencil)
    )
}

fn find_programs(key: &str) -> Result<BinaryCollection, TestError> {
    ALL_SHARED_PROGRAM
        .iter()
        .find(|program| program.name == key)
        .map(|program| program.programs)
        .ok_or_else(|| TestError::NotPorted(format!("no shader set {key} in the manifest")))
}

macro_rules! query_features {
    ($context:expr, $ty:ty) => {{
        let mut features = <$ty>::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                $context
                    .get_instance()
                    .get_physical_device_features2($context.get_physical_device(), &mut features2)
            };
        }
        features
    }};
}

macro_rules! query_properties {
    ($context:expr, $ty:ty) => {{
        let mut properties = <$ty>::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
            unsafe {
                $context
                    .get_instance()
                    .get_physical_device_properties2($context.get_physical_device(), &mut properties2)
            };
        }
        properties
    }};
}

struct FsrTestCase {
    name: String,
    data: CaseDef,
}

impl TestCase for FsrTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `FSRTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let data = &self.data;
        context.require_device_functionality("VK_KHR_fragment_shading_rate")?;

        if data.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        let fsr_features = fragment_shading_rate_features(context);
        if fsr_features.pipeline_fragment_shading_rate == vk::FALSE {
            return Err(TestError::NotSupported(
                "pipelineFragmentShadingRate not supported".to_string(),
            ));
        }

        if data.shader_writes_rate && fsr_features.primitive_fragment_shading_rate == vk::FALSE {
            return Err(TestError::NotSupported(
                "primitiveFragmentShadingRate not supported".to_string(),
            ));
        }

        if fsr_features.primitive_fragment_shading_rate == vk::FALSE
            && data.combiner_op[0] != vk::FragmentShadingRateCombinerOpKHR::KEEP
        {
            return Err(TestError::NotSupported(
                "primitiveFragmentShadingRate not supported".to_string(),
            ));
        }

        if fsr_features.attachment_fragment_shading_rate == vk::FALSE
            && data.combiner_op[1] != vk::FragmentShadingRateCombinerOpKHR::KEEP
        {
            return Err(TestError::NotSupported(
                "attachmentFragmentShadingRate not supported".to_string(),
            ));
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let image_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                CB_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                cb_usage(),
                vk::ImageCreateFlags::empty(),
            )
        };
        let image_properties = match image_properties {
            Ok(properties) => properties,
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(
                    "VK_FORMAT_R32G32B32A32_UINT not supported".to_string(),
                ));
            }
            Err(code) => {
                return Err(TestError::InternalError(format!(
                    "vkGetPhysicalDeviceImageFormatProperties returned {code:?}"
                )));
            }
        };

        if data.geometry_shader && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature geometryShader not supported".to_string(),
            ));
        }

        if !image_properties.sample_counts.intersects(data.samples) {
            return Err(TestError::NotSupported(
                "color buffer sample count not supported".to_string(),
            ));
        }

        let fsr_properties = fragment_shading_rate_properties(context);
        if data.sample_count() > fsr_properties.max_fragment_shading_rate_rasterization_samples.bits() {
            return Err(TestError::NotSupported(
                "fragment shading rate rasterization sample count not supported".to_string(),
            ));
        }
        if data.sample_count() > fsr_properties.max_fragment_shading_rate_coverage_samples {
            return Err(TestError::NotSupported(
                "fragment shading rate coverage sample count not supported".to_string(),
            ));
        }

        if data.num_color_layers > image_properties.max_array_layers {
            return Err(TestError::NotSupported("color buffer layers not supported".to_string()));
        }

        if data.use_attachment() && fsr_features.attachment_fragment_shading_rate == vk::FALSE {
            return Err(TestError::NotSupported(
                "attachmentFragmentShadingRate not supported".to_string(),
            ));
        }

        let trivial_op = |op: vk::FragmentShadingRateCombinerOpKHR| {
            op == vk::FragmentShadingRateCombinerOpKHR::KEEP || op == vk::FragmentShadingRateCombinerOpKHR::REPLACE
        };
        if fsr_properties.fragment_shading_rate_non_trivial_combiner_ops == vk::FALSE
            && (!trivial_op(data.combiner_op[0]) || !trivial_op(data.combiner_op[1]))
        {
            return Err(TestError::NotSupported(
                "fragmentShadingRateNonTrivialCombinerOps not supported".to_string(),
            ));
        }

        if data.conservative_enable {
            context.require_device_functionality("VK_EXT_conservative_rasterization")?;
            if data.conservative_mode == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE
                && query_properties!(context, vk::PhysicalDeviceConservativeRasterizationPropertiesEXT)
                    .primitive_underestimation
                    == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "primitiveUnderestimation not supported".to_string(),
                ));
            }
        }

        if data.frag_stencil {
            context.require_device_functionality("VK_EXT_shader_stencil_export")?;
        }

        if data.multi_viewport && fsr_properties.primitive_fragment_shading_rate_with_multiple_viewports == vk::FALSE {
            return Err(TestError::NotSupported(
                "primitiveFragmentShadingRateWithMultipleViewports not supported".to_string(),
            ));
        }

        if data.sr_layered && fsr_properties.layered_shading_rate_attachments == vk::FALSE {
            return Err(TestError::NotSupported(
                "layeredShadingRateAttachments not supported".to_string(),
            ));
        }

        if (data.multi_viewport || data.color_layered) && !data.geometry_shader {
            context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;
        }

        if data.multi_view
            && data.geometry_shader
            && query_features!(context, vk::PhysicalDeviceMultiviewFeatures).multiview_geometry_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "multiviewGeometryShader not supported".to_string(),
            ));
        }

        if data.interlock
            && query_features!(context, vk::PhysicalDeviceFragmentShaderInterlockFeaturesEXT)
                .fragment_shader_pixel_interlock
                == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentShaderPixelInterlock not supported".to_string(),
            ));
        }

        if data.sample_locations {
            context.require_device_functionality("VK_EXT_sample_locations")?;
            if !query_properties!(context, vk::PhysicalDeviceSampleLocationsPropertiesEXT)
                .sample_location_sample_counts
                .intersects(data.samples)
            {
                return Err(TestError::NotSupported(
                    "samples not supported in sampleLocationSampleCounts".to_string(),
                ));
            }
        }

        if data.sample_mask_test && fsr_properties.fragment_shading_rate_with_sample_mask == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentShadingRateWithSampleMask not supported".to_string(),
            ));
        }

        if data.mesh_shader {
            context.require_device_functionality("VK_EXT_mesh_shader")?;
            let mesh_features = mesh_shader_features(context);

            if data.shader_writes_rate && mesh_features.primitive_fragment_shading_rate_mesh_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "primitiveFragmentShadingRateMeshShader not supported".to_string(),
                ));
            }

            if data.multi_view && mesh_features.multiview_mesh_shader == vk::FALSE {
                return Err(TestError::NotSupported("multiviewMeshShader not supported".to_string()));
            }
        }

        check_pipeline_construction_requirements(context, data.group_params.construction)?;

        if data.early_and_late_test {
            context.require_device_functionality("VK_AMD_shader_early_and_late_fragment_tests")?;
            if query_features!(context, vk::PhysicalDeviceShaderEarlyAndLateFragmentTestsFeaturesAMD)
                .shader_early_and_late_fragment_tests
                == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "shaderEarlyAndLateFragmentTests is not supported".to_string(),
                ));
            }
        }

        if data.maintenance6 {
            context.require_device_functionality("VK_KHR_maintenance6")?;
        }

        if (data.sample_shading_enable || data.sample_shading_input)
            && context.get_device_features().sample_rate_shading == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Core feature sampleRateShading not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        find_programs(&fragment_key(&self.data)).unwrap_or_else(|_| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FsrInstance {
            context,
            data: self.data,
        })
    }
}

/// `ShadingRateExtentToEnum`
fn shading_rate_extent_to_enum(extent: vk::Extent2D) -> i32 {
    ((extent.width.trailing_zeros() << 2) | extent.height.trailing_zeros()) as i32
}

/// `ShadingRateEnumToExtent`
fn shading_rate_enum_to_extent(rate: i32) -> vk::Extent2D {
    vk::Extent2D {
        width: 1 << ((rate / 4) & 3),
        height: 1 << (rate & 3),
    }
}

/// `PrimIDToPrimitiveShadingRate` - primID % 9 as a shading rate.
fn prim_id_to_primitive_shading_rate(prim_id: i32) -> i32 {
    shading_rate_extent_to_enum(vk::Extent2D {
        width: 1 << (prim_id % 3),
        height: 1 << ((prim_id / 3) % 3),
    })
}

/// `PrimIDToPipelineShadingRate` - primID / 9 as a shading rate.
fn prim_id_to_pipeline_shading_rate(prim_id: i32) -> i32 {
    let prim_id = prim_id / 9;
    shading_rate_extent_to_enum(vk::Extent2D {
        width: 1 << (prim_id % 3),
        height: 1 << ((prim_id / 3) % 3),
    })
}

/// `SanitizeExtent` - clamps an extent to something valid (4x4 at most).
fn sanitize_extent(extent: vk::Extent2D) -> vk::Extent2D {
    debug_assert!(extent.width > 0 && extent.height > 0);
    vk::Extent2D {
        width: extent.width.min(4),
        height: extent.height.min(4),
    }
}

/// `SanitizeRate`
fn sanitize_rate(rate: i32) -> i32 {
    shading_rate_extent_to_enum(sanitize_extent(shading_rate_enum_to_extent(rate)))
}

/// What `FSRTestInstance` keeps for simulating the combiner operations: the supported rates, the properties that change the result
/// and the cache of every `simulate` answer.
struct Simulator {
    samples: vk::SampleCountFlags,
    combiner_op: [vk::FragmentShadingRateCombinerOpKHR; 2],
    supported_rates: Vec<vk::PhysicalDeviceFragmentShadingRateKHR>,
    strict_multiply_combiner: bool,
    force_1x1: bool,
    allow_unclamped_inputs: bool,
    value_count: usize,
    cache: Vec<i32>,
}

impl Simulator {
    fn new(context: &Context<'_>, data: &CaseDef) -> Result<Self, TestError> {
        let supported_rates = supported_fragment_shading_rates(context);
        if supported_rates.len() < 3 {
            return Err(TestError::InternalError(
                "*pFragmentShadingRateCount too small".to_string(),
            ));
        }

        let properties = fragment_shading_rate_properties(context);
        let mut allow_unclamped_inputs = true;
        if data.maintenance6 {
            allow_unclamped_inputs = query_properties!(context, vk::PhysicalDeviceMaintenance6Properties)
                .fragment_shading_rate_clamp_combiner_inputs
                == vk::FALSE;
        }

        // `Force1x1`
        let force_1x1 = (data.use_api_sample_mask && properties.fragment_shading_rate_with_sample_mask == vk::FALSE)
            || ((data.use_sample_mask_in || data.use_sample_mask_out)
                && properties.fragment_shading_rate_with_shader_sample_mask == vk::FALSE)
            || (data.conservative_enable
                && properties.fragment_shading_rate_with_conservative_rasterization == vk::FALSE)
            || ((data.frag_depth || data.frag_stencil)
                && properties.fragment_shading_rate_with_shader_depth_stencil_writes == vk::FALSE)
            || (data.interlock && properties.fragment_shading_rate_with_fragment_shader_interlock == vk::FALSE)
            || (data.sample_locations && properties.fragment_shading_rate_with_custom_sample_locations == vk::FALSE)
            || data.sample_shading_enable
            || data.sample_shading_input;

        let value_count = ((4 * 4) | 4) + 1;
        Ok(Self {
            samples: data.samples,
            combiner_op: data.combiner_op,
            supported_rates,
            strict_multiply_combiner: properties.fragment_shading_rate_strict_multiply_combiner != vk::FALSE,
            force_1x1,
            allow_unclamped_inputs,
            value_count,
            cache: vec![!0; value_count * value_count * value_count],
        })
    }

    /// `Combine`
    fn combine(
        &self,
        ext0: vk::Extent2D,
        ext1: vk::Extent2D,
        comb: vk::FragmentShadingRateCombinerOpKHR,
    ) -> vk::Extent2D {
        match comb {
            vk::FragmentShadingRateCombinerOpKHR::REPLACE => ext1,
            vk::FragmentShadingRateCombinerOpKHR::MIN => vk::Extent2D {
                width: ext0.width.min(ext1.width),
                height: ext0.height.min(ext1.height),
            },
            vk::FragmentShadingRateCombinerOpKHR::MAX => vk::Extent2D {
                width: ext0.width.max(ext1.width),
                height: ext0.height.max(ext1.height),
            },
            vk::FragmentShadingRateCombinerOpKHR::MUL => {
                let mut result = vk::Extent2D {
                    width: ext0.width * ext1.width,
                    height: ext0.height * ext1.height,
                };
                if !self.strict_multiply_combiner {
                    if ext0.width == 1 && ext1.width == 1 {
                        result.width = 2;
                    }
                    if ext0.height == 1 && ext1.height == 1 {
                        result.height = 2;
                    }
                }
                result
            }
            _ => ext0,
        }
    }

    /// `CombineMasks`
    fn combine_masks(
        &self,
        rate_mask0: i32,
        rate_mask1: i32,
        comb: vk::FragmentShadingRateCombinerOpKHR,
        allow_unclamped_result: bool,
    ) -> i32 {
        let mut combined_mask = 0;

        for i in 0..16 {
            if rate_mask0 & (1 << i) != 0 {
                let rate0 = shading_rate_enum_to_extent(i);

                for j in 0..16 {
                    if rate_mask1 & (1 << j) != 0 {
                        let combiner_result = self.combine(rate0, shading_rate_enum_to_extent(j), comb);
                        let clamped_result = self.shading_rate_extent_to_clamped_mask(combiner_result);

                        if allow_unclamped_result {
                            combined_mask |= 1 << shading_rate_extent_to_enum(combiner_result);
                        }

                        combined_mask |= clamped_result;
                    }
                }
            }
        }

        combined_mask
    }

    /// `Simulate`
    fn simulate(&mut self, rate0: i32, rate1: i32, rate2: i32) -> i32 {
        let index = (rate2 as usize * self.value_count + rate1 as usize) * self.value_count + rate0 as usize;
        if self.cache[index] != !0 {
            return self.cache[index];
        }

        let extent0 = shading_rate_enum_to_extent(rate0);
        let extent1 = shading_rate_enum_to_extent(rate1);
        let extent2 = shading_rate_enum_to_extent(rate2);

        let mut final_mask = 0;

        // Clamped and unclamped inputs.
        let extent_mask0 = self.shading_rate_extent_to_clamped_mask(extent0) | (1 << rate0);
        let extent_mask1 = self.shading_rate_extent_to_clamped_mask(extent1) | (1 << rate1);
        let extent_mask2 = self.shading_rate_extent_to_clamped_mask(extent2) | (1 << rate2);

        // Combine rate 0 and 1, get a mask of possible clamped rates
        let intermed_mask = self.combine_masks(
            extent_mask0,
            extent_mask1,
            self.combiner_op[0],
            self.allow_unclamped_inputs,
        );

        // For each clamped rate, combine that with rate 2 and accumulate the possible clamped rates
        for i in 0..16 {
            if intermed_mask & (1 << i) != 0 {
                final_mask |= self.combine_masks(intermed_mask, extent_mask2, self.combiner_op[1], false);
            }
        }

        if self.force_1x1 {
            final_mask = 0x1;
        }

        self.cache[index] = final_mask;
        final_mask
    }

    /// `ShadingRateExtentToClampedMask` - maps an extent to a mask of all modes smaller than or equal to it in either dimension.
    fn shading_rate_extent_to_clamped_mask(&self, ext: vk::Extent2D) -> i32 {
        let shading_rate_bit = 1i32 << shading_rate_extent_to_enum(ext);
        let mut desired_size = ext.width * ext.height;
        let mut mask = 0i32;
        let mut swapped_sizes_mask = 0i32;

        while desired_size > 0 {
            // First, find modes that maximize the area
            for supported_rate in &self.supported_rates {
                let size = supported_rate.fragment_size;
                if supported_rate.sample_counts.intersects(self.samples) && size.width * size.height == desired_size {
                    if size.width <= ext.width && size.height <= ext.height {
                        mask |= 1 << shading_rate_extent_to_enum(size);
                    } else if size.height <= ext.width && size.width <= ext.height {
                        swapped_sizes_mask |= 1 << shading_rate_extent_to_enum(size);
                    }
                }
            }
            if mask != 0 {
                // Amongst the modes that maximize the area, pick the ones that minimize the aspect ratio. Prefer ratio of 1, then 2, then 4.
                // 1x1 = 0, 2x2 = 5, 4x4 = 10
                const ASPECT_MASK_RATIO1: i32 = 0x421;
                // 2x1 = 4, 1x2 = 1, 4x2 = 9, 2x4 = 6
                const ASPECT_MASK_RATIO2: i32 = 0x252;
                // 4x1 = 8, 1x4 = 2,
                const ASPECT_MASK_RATIO4: i32 = 0x104;

                if mask & ASPECT_MASK_RATIO1 != 0 {
                    mask &= ASPECT_MASK_RATIO1;
                    break;
                }
                if mask & ASPECT_MASK_RATIO2 != 0 {
                    mask &= ASPECT_MASK_RATIO2;
                    break;
                }
                if mask & ASPECT_MASK_RATIO4 != 0 {
                    mask &= ASPECT_MASK_RATIO4;
                    break;
                }
                debug_assert!(false);
            }
            desired_size /= 2;
        }

        // Optionally include the sizes with swapped width and height.
        mask |= swapped_sizes_mask;

        if mask & shading_rate_bit != 0 {
            // The given shading rate is valid. Don't clamp it.
            return shading_rate_bit;
        }

        // Return alternative shading rates.
        mask
    }
}

/// `CreateCachedBuffer`
fn create_cached_buffer<'a>(
    context: &'a Context<'a>,
    info: vk::BufferCreateInfo,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    match BufferWithMemory::new(
        device,
        allocator,
        info,
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
    ) {
        Err(TestError::NotSupported(_)) => {
            BufferWithMemory::new(device, allocator, info, MemoryRequirement::HOST_VISIBLE)
        }
        result => result,
    }
}

fn host_slice_mut<T>(buffer: &BufferWithMemory<'_>, count: usize) -> &'static mut [T] {
    unsafe { std::slice::from_raw_parts_mut(buffer.get_allocation().get_host_ptr().cast::<T>(), count) }
}

fn host_slice<T>(buffer: &BufferWithMemory<'_>, count: usize) -> &'static [T] {
    unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast::<T>().cast_const(), count) }
}

fn make_clear_value_color_u32(r: u32, g: u32, b: u32, a: u32) -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { uint32: [r, g, b, a] },
    }
}

fn make_clear_value_depth_stencil(depth: f32, stencil: u32) -> vk::ClearValue {
    vk::ClearValue {
        depth_stencil: vk::ClearDepthStencilValue { depth, stencil },
    }
}

fn simple_image_info(
    format: vk::Format,
    extent: (u32, u32),
    mip_levels: u32,
    array_layers: u32,
    samples: vk::SampleCountFlags,
    tiling: vk::ImageTiling,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: extent.0,
            height: extent.1,
            depth: 1,
        })
        .mip_levels(mip_levels)
        .array_layers(array_layers)
        .samples(samples)
        .tiling(tiling)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

fn simple_view(
    device: &Device,
    image: vk::Image,
    view_type: vk::ImageViewType,
    format: vk::Format,
    aspect: vk::ImageAspectFlags,
    base_mip: u32,
    levels: u32,
    base_layer: u32,
    layers: u32,
) -> Result<Unique<'_, vk::ImageView>, TestError> {
    let info = vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(view_type)
        .format(format)
        .components(vk::ComponentMapping {
            r: vk::ComponentSwizzle::R,
            g: vk::ComponentSwizzle::G,
            b: vk::ComponentSwizzle::B,
            a: vk::ComponentSwizzle::A,
        })
        .subresource_range(vk::ImageSubresourceRange {
            aspect_mask: aspect,
            base_mip_level: base_mip,
            level_count: levels,
            base_array_layer: base_layer,
            layer_count: layers,
        });
    let view = unsafe { device.create_image_view(&info, None) }.vk_check("vkCreateImageView")?;
    Ok(Unique::new(device, view))
}

fn make_ds_view<'d>(
    device: &'d Device,
    image: Option<&ImageWithMemory<'_>>,
    ds_format: vk::Format,
    aspect: vk::ImageAspectFlags,
    data: &CaseDef,
) -> Result<Option<Unique<'d, vk::ImageView>>, TestError> {
    match image {
        Some(image) => Ok(Some(simple_view(
            device,
            image.get(),
            vk::ImageViewType::_2D_ARRAY,
            ds_format,
            aspect,
            data.ds_base_mip_level,
            1,
            data.ds_base_layer,
            data.num_color_layers,
        )?)),
        None => Ok(None),
    }
}

fn make_set_layout<'d>(
    device: &'d Device,
    bindings: &[vk::DescriptorSetLayoutBinding],
) -> Result<Unique<'d, vk::DescriptorSetLayout>, TestError> {
    let info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(bindings);
    Ok(Unique::new(
        device,
        unsafe { device.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?,
    ))
}

fn module_handle(module: Option<&Unique<'_, vk::ShaderModule>>) -> vk::ShaderModule {
    module.map_or_else(vk::ShaderModule::null, |module| **module)
}

fn set_layout_binding(
    binding: u32,
    descriptor_type: vk::DescriptorType,
    stages: vk::ShaderStageFlags,
) -> vk::DescriptorSetLayoutBinding {
    vk::DescriptorSetLayoutBinding {
        binding,
        descriptor_type,
        descriptor_count: 1,
        stage_flags: stages,
        immutable_samplers: std::ptr::null(),
    }
}

/// Everything `drawCommands` takes beyond the command buffer.
struct DrawArgs<'a> {
    viewports: &'a [vk::Viewport],
    scissors: &'a [vk::Rect2D],
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vert_shader: vk::ShaderModule,
    geom_shader: vk::ShaderModule,
    mesh_shader: vk::ShaderModule,
    frag_shader: vk::ShaderModule,
    descriptor_sets: &'a [vk::DescriptorSet],
    vertex_buffer: vk::Buffer,
    push_constant_size: u32,
    ds_format: vk::Format,
}

fn rasterization_state(next: *const c_void) -> vk::PipelineRasterizationStateCreateInfo {
    vk::PipelineRasterizationStateCreateInfo {
        next,
        depth_clamp_enable: vk::FALSE,
        rasterizer_discard_enable: vk::FALSE,
        polygon_mode: vk::PolygonMode::FILL,
        cull_mode: vk::CullModeFlags::NONE,
        front_face: vk::FrontFace::CLOCKWISE,
        depth_bias_enable: vk::FALSE,
        depth_bias_constant_factor: 0.0,
        depth_bias_clamp: 0.0,
        depth_bias_slope_factor: 0.0,
        line_width: 1.0,
        ..Default::default()
    }
}

/// Enable depth/stencil writes, always passing
fn depth_stencil_state(data: &CaseDef) -> vk::PipelineDepthStencilStateCreateInfo {
    let stencil_ref = if !data.frag_stencil && data.use_depth_stencil {
        2u32
    } else {
        0xFF
    };
    let stencil_op = vk::StencilOpState {
        fail_op: vk::StencilOp::REPLACE,
        pass_op: vk::StencilOp::REPLACE,
        depth_fail_op: vk::StencilOp::REPLACE,
        compare_op: vk::CompareOp::ALWAYS,
        compare_mask: 0,
        write_mask: 0xFF,
        reference: stencil_ref,
    };
    vk::PipelineDepthStencilStateCreateInfo {
        depth_test_enable: vk::TRUE,
        depth_write_enable: vk::TRUE,
        depth_compare_op: vk::CompareOp::ALWAYS,
        depth_bounds_test_enable: vk::FALSE,
        stencil_test_enable: vk::TRUE,
        front: stencil_op,
        back: stencil_op,
        min_depth_bounds: 0.0,
        max_depth_bounds: 0.0,
        ..Default::default()
    }
}

struct FsrInstance<'a> {
    context: &'a Context<'a>,
    data: CaseDef,
}

impl<'a> FsrInstance<'a> {
    /// `FSRTestInstance::drawCommands`
    fn draw_commands(
        &self,
        cmd: vk::CommandBuffer,
        pipelines: &mut Vec<Unique<'a, vk::Pipeline>>,
        args: &DrawArgs<'_>,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let data = &self.data;
        let use_mesh = data.mesh_shader;

        let mut all_shader_stages = vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE;
        if use_mesh {
            all_shader_stages |= vk::ShaderStageFlags::MESH_EXT;
        } else {
            all_shader_stages |= vk::ShaderStageFlags::VERTEX;
            if data.geometry_shader {
                all_shader_stages |= vk::ShaderStageFlags::GEOMETRY;
            }
        }

        let mut pipeline_create_flags = vk::PipelineCreateFlags::empty();
        if data.group_params.use_dynamic_rendering {
            pipeline_create_flags |= vk::PipelineCreateFlags::RENDERING_FRAGMENT_SHADING_RATE_ATTACHMENT_KHR;
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                args.pipeline_layout,
                0,
                args.descriptor_sets,
                &[] as &[u32],
            )
        };

        let stage_modules: Vec<(vk::ShaderStageFlags, vk::ShaderModule)> = if use_mesh {
            vec![
                (vk::ShaderStageFlags::MESH_EXT, args.mesh_shader),
                (vk::ShaderStageFlags::FRAGMENT, args.frag_shader),
            ]
        } else if data.geometry_shader {
            vec![
                (vk::ShaderStageFlags::VERTEX, args.vert_shader),
                (vk::ShaderStageFlags::GEOMETRY, args.geom_shader),
                (vk::ShaderStageFlags::FRAGMENT, args.frag_shader),
            ]
        } else {
            vec![
                (vk::ShaderStageFlags::VERTEX, args.vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, args.frag_shader),
            ]
        };

        // All samples at pixel center. We'll validate that pixels are fully covered or uncovered.
        let sample_locations = vec![vk::SampleLocationEXT { x: 0.5, y: 0.5 }; data.sample_count() as usize];

        let create_pipeline = |fragment_size: vk::Extent2D| -> Result<Unique<'a, vk::Pipeline>, TestError> {
            let cons_rast_state = vk::PipelineRasterizationConservativeStateCreateInfoEXT {
                conservative_rasterization_mode: data.conservative_mode,
                extra_primitive_overestimation_size: 0.0,
                ..Default::default()
            };

            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
            if !use_mesh {
                state.bindings = vec![vk::VertexInputBindingDescription {
                    binding: 0,
                    stride: (std::mem::size_of::<f32>() * 2) as u32,
                    input_rate: vk::VertexInputRate::VERTEX,
                }];
                state.attributes = vec![vk::VertexInputAttributeDescription {
                    location: 0,
                    binding: 0,
                    format: vk::Format::R32G32_SFLOAT,
                    offset: 0,
                }];
            }
            state.viewports = args.viewports.to_vec();
            state.scissors = args.scissors.to_vec();
            state.viewport_count = args.viewports.len() as u32;
            if data.use_dynamic_state {
                state.dynamic_states = vec![vk::DynamicState::FRAGMENT_SHADING_RATE_KHR];
            }
            state.rasterization = rasterization_state(if data.conservative_enable {
                (&cons_rast_state as *const vk::PipelineRasterizationConservativeStateCreateInfoEXT).cast::<c_void>()
            } else {
                std::ptr::null()
            });

            state.depth_stencil = depth_stencil_state(data);

            state.samples = data.samples;
            state.sample_shading = data.sample_shading_enable;
            state.min_sample_shading = 1.0;
            if data.use_api_sample_mask {
                // Kill some bits from each AA mode
                state.sample_mask = Some(if data.sample_mask_test { 0x9 } else { 0x7D56 });
            }
            if data.sample_locations {
                let info = vk::SampleLocationsInfoEXT {
                    sample_locations_per_pixel: data.samples,
                    sample_location_grid_size: vk::Extent2D { width: 1, height: 1 },
                    sample_locations_count: data.sample_count(),
                    sample_locations: sample_locations.as_ptr(),
                    ..Default::default()
                };
                state.sample_locations = Some((true, info));
            }

            state.fragment_shading_rate_state = Some(vk::PipelineFragmentShadingRateStateCreateInfoKHR {
                fragment_size,
                combiner_ops: data.combiner_op,
                ..Default::default()
            });
            if data.group_params.use_dynamic_rendering {
                state.rendering_format = Some(CB_FORMAT);
                state.depth_rendering_format = args.ds_format;
                state.stencil_rendering_format = args.ds_format;
                state.view_mask = if data.multi_view { 0x3 } else { 0 };
            }
            state.create_flags = pipeline_create_flags;
            state.construction = data.group_params.construction;

            create_draw_pipeline(device, args.pipeline_layout, args.render_pass, &stage_modules, &state)
        };

        // If using dynamic state, create a single graphics pipeline and bind it. Its static shading rate is 1x1 (2x2 for the sample mask test).
        let initial_size = if data.sample_mask_test { 2 } else { 1 };
        if data.use_dynamic_state {
            let pipeline = create_pipeline(vk::Extent2D {
                width: initial_size,
                height: initial_size,
            })?;
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline) };
            pipelines.push(pipeline);
        }

        for i in 0..NUM_TRIANGLES as i32 {
            if !use_mesh {
                // Bind vertex attributes pointing to the next triangle
                let vertex_buffer_offset = (i as usize * 3 * 2 * std::mem::size_of::<f32>()) as vk::DeviceSize;
                unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[args.vertex_buffer], &[vertex_buffer_offset]) };
            }

            // Put primitive shading rate and instance index (used in mesh shading cases) in push constants.
            let push_constant_block: [i32; 2] = [prim_id_to_primitive_shading_rate(i), i];
            let push_constant_bytes: Vec<u8> = push_constant_block
                .iter()
                .flat_map(|value| value.to_ne_bytes())
                .collect();
            unsafe {
                device.cmd_push_constants(
                    cmd,
                    args.pipeline_layout,
                    all_shader_stages,
                    0,
                    &push_constant_bytes[..args.push_constant_size as usize],
                )
            };

            if data.use_dynamic_state {
                let fragment_size = shading_rate_enum_to_extent(prim_id_to_pipeline_shading_rate(i));
                unsafe { device.cmd_set_fragment_shading_rate_khr(cmd, &fragment_size, data.combiner_op) };
            } else {
                // Create a new pipeline with the desired pipeline shading rate
                let pipeline = create_pipeline(shading_rate_enum_to_extent(prim_id_to_pipeline_shading_rate(i)))?;
                unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline) };
                pipelines.push(pipeline);
            }

            if use_mesh {
                // Create a single workgroup to draw one triangle. The "primitive id" will be in the push constants.
                unsafe { device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1) };
            } else {
                // Draw one triangle, with "primitive ID" in gl_InstanceIndex
                unsafe { device.cmd_draw(cmd, 3, 1, 0, i as u32) };
            }
        }

        Ok(())
    }

    /// `FSRTestInstance::drawCommandsOnNormalSubpass`
    #[allow(clippy::too_many_arguments)]
    fn draw_commands_on_normal_subpass(
        &self,
        cmd: vk::CommandBuffer,
        pipelines: &mut Vec<Unique<'a, vk::Pipeline>>,
        args: &DrawArgs<'_>,
        pipeline_layout: vk::PipelineLayout,
        vert_shader: vk::ShaderModule,
        frag_shader: vk::ShaderModule,
        subpass: u32,
        vertex_buffer: vk::Buffer,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let data = &self.data;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_position_input();
        state.viewports = args.viewports.to_vec();
        state.scissors = args.scissors.to_vec();
        state.viewport_count = args.viewports.len() as u32;
        state.rasterization = rasterization_state(std::ptr::null());
        state.depth_stencil = depth_stencil_state(data);
        state.samples = data.samples;
        state.sample_shading = data.sample_shading_enable;
        state.min_sample_shading = 1.0;
        state.subpass = subpass;
        state.construction = data.group_params.construction;

        let pipeline = create_draw_pipeline(
            device,
            pipeline_layout,
            args.render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, frag_shader),
            ],
            &state,
        )?;

        unsafe {
            device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
            device.cmd_draw(cmd, 4, 1, 0, 0);
        }
        pipelines.push(pipeline);
        Ok(())
    }

    /// `FSRTestInstance::copyImageToBufferOnNormalSubpass`
    fn copy_image_to_buffer_on_normal_subpass(
        &self,
        cmd: vk::CommandBuffer,
        image: vk::Image,
        output_buffer: vk::Buffer,
        buffer_size: vk::DeviceSize,
    ) {
        let device = self.context.get_device();
        let data = &self.data;

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let post_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image,
            subresource_range,
        );
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer,
            0,
            buffer_size,
        );

        let image_extent = vk::Extent3D {
            width: data.framebuffer_dim.width,
            height: data.framebuffer_dim.height,
            depth: 1,
        };
        let copy_region = make_buffer_image_copy(
            image_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );

        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_image_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer,
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `FSRTestInstance::beginSecondaryCmdBuffer`
    fn begin_secondary_cmd_buffer(
        &self,
        cmd: vk::CommandBuffer,
        ds_format: vk::Format,
        rendering_flags: vk::RenderingFlags,
    ) -> Result<(), TestError> {
        let data = &self.data;
        let cb_format = CB_FORMAT;
        let inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo {
            flags: rendering_flags,
            view_mask: if data.multi_view { 0x3 } else { 0 },
            color_attachment_count: 1,
            color_attachment_formats: &cb_format,
            depth_attachment_format: ds_format,
            stencil_attachment_format: ds_format,
            rasterization_samples: data.samples,
            ..Default::default()
        };
        let buffer_inheritance_info = vk::CommandBufferInheritanceInfo {
            next: (&inheritance_rendering_info as *const vk::CommandBufferInheritanceRenderingInfo).cast::<c_void>(),
            ..Default::default()
        };

        let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
        if !data
            .group_params
            .secondary_cmd_buffer_completely_contains_dynamic_renderpass
        {
            usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
        }

        let begin_info = vk::CommandBufferBeginInfo {
            flags: usage_flags,
            inheritance_info: &buffer_inheritance_info,
            ..Default::default()
        };
        unsafe { self.context.get_device().begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
    }

    /// `FSRTestInstance::beginDynamicRender`
    #[allow(clippy::too_many_arguments)]
    fn begin_dynamic_render(
        &self,
        cmd: vk::CommandBuffer,
        sr_image_view: vk::ImageView,
        sr_image_layout: vk::ImageLayout,
        sr_texel_size: vk::Extent2D,
        cb_image_view: vk::ImageView,
        ds_image_view: vk::ImageView,
        clear_color: vk::ClearValue,
        clear_depth_stencil: vk::ClearValue,
        rendering_flags: vk::RenderingFlags,
    ) {
        let data = &self.data;
        let render_area = rect_2d(data.framebuffer_dim.width, data.framebuffer_dim.height);

        let mut shading_rate_attachment_info = vk::RenderingFragmentShadingRateAttachmentInfoKHR {
            image_view: if data.use_attachment() {
                sr_image_view
            } else {
                vk::ImageView::null()
            },
            image_layout: sr_image_layout,
            shading_rate_attachment_texel_size: sr_texel_size,
            ..Default::default()
        };

        let color_attachment = vk::RenderingAttachmentInfo {
            image_view: cb_image_view,
            image_layout: vk::ImageLayout::GENERAL,
            resolve_mode: vk::ResolveModeFlags::NONE,
            resolve_image_view: vk::ImageView::null(),
            resolve_image_layout: vk::ImageLayout::UNDEFINED,
            load_op: vk::AttachmentLoadOp::LOAD,
            store_op: vk::AttachmentStoreOp::STORE,
            clear_value: clear_color,
            ..Default::default()
        };

        let depth_stencil_attachment = vk::RenderingAttachmentInfo {
            image_view: ds_image_view,
            image_layout: vk::ImageLayout::GENERAL,
            resolve_mode: vk::ResolveModeFlags::NONE,
            resolve_image_view: vk::ImageView::null(),
            resolve_image_layout: vk::ImageLayout::UNDEFINED,
            load_op: vk::AttachmentLoadOp::LOAD,
            store_op: vk::AttachmentStoreOp::STORE,
            clear_value: clear_depth_stencil,
            ..Default::default()
        };

        let use_sr_info = data.use_attachment() || data.use_attachment_without_image_view();
        let rendering_info = vk::RenderingInfo {
            next: if use_sr_info {
                (&mut shading_rate_attachment_info as *mut vk::RenderingFragmentShadingRateAttachmentInfoKHR)
                    .cast::<c_void>()
                    .cast_const()
            } else {
                std::ptr::null()
            },
            flags: rendering_flags,
            render_area,
            layer_count: if data.multi_view { 1 } else { data.num_color_layers },
            view_mask: if data.multi_view { 0x3 } else { 0 },
            color_attachment_count: 1,
            color_attachments: &color_attachment,
            depth_attachment: if data.use_depth_stencil {
                &depth_stencil_attachment
            } else {
                std::ptr::null()
            },
            stencil_attachment: if data.use_depth_stencil {
                &depth_stencil_attachment
            } else {
                std::ptr::null()
            },
            ..Default::default()
        };

        unsafe { self.context.get_device().cmd_begin_rendering(cmd, &rendering_info) };
    }

    /// `FSRTestInstance::preRenderCommands`
    #[allow(clippy::too_many_arguments)]
    fn pre_render_commands(
        &self,
        cmd: vk::CommandBuffer,
        cb_image: vk::Image,
        sec_cb_image: vk::Image,
        ds_image: vk::Image,
        deriv_image: vk::Image,
        deriv_num_levels: u32,
        sr_image: vk::Image,
        sr_layout: vk::ImageLayout,
        sr_fill_buffer: Option<&BufferWithMemory<'_>>,
        num_sr_layers: u32,
        sr_width: u32,
        sr_height: u32,
        sr_fill_bpp: u32,
        clear_color: vk::ClearValue,
        clear_depth_stencil: vk::ClearValue,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let data = &self.data;

        let mut all_pipeline_stages = vk::PipelineStageFlags::VERTEX_SHADER
            | vk::PipelineStageFlags::FRAGMENT_SHADER
            | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
            | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
            | vk::PipelineStageFlags::COMPUTE_SHADER;

        // VUID-vkCmdPipelineBarrier-dstStageMask-07318
        if data.use_attachment() {
            all_pipeline_stages |= vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR;
        }

        if data.geometry_shader {
            all_pipeline_stages |= vk::PipelineStageFlags::GEOMETRY_SHADER;
        }

        let full_range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: vk::REMAINING_MIP_LEVELS,
            base_array_layer: 0,
            layer_count: vk::REMAINING_ARRAY_LAYERS,
        };
        let mut image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            cb_image,
            full_range,
        );

        let barrier_to_transfer = |barrier: vk::ImageMemoryBarrier, src_stage: vk::PipelineStageFlags| unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                src_stage,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        };

        barrier_to_transfer(image_barrier, vk::PipelineStageFlags::TOP_OF_PIPE);

        image_barrier.image = deriv_image;
        image_barrier.new_layout = vk::ImageLayout::GENERAL;
        barrier_to_transfer(image_barrier, vk::PipelineStageFlags::TOP_OF_PIPE);

        // Clear level to 1<<level
        for i in 0..deriv_num_levels {
            let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, i, 1, 0, 1);
            let clear_level_color = vk::ClearColorValue {
                uint32: [1 << i, 0, 0, 0],
            };
            unsafe {
                device.cmd_clear_color_image(cmd, deriv_image, vk::ImageLayout::GENERAL, &clear_level_color, &[range])
            };
        }

        // Clear color buffer to transparent black
        {
            let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, vk::REMAINING_ARRAY_LAYERS);
            let color = unsafe { clear_color.color };
            unsafe { device.cmd_clear_color_image(cmd, cb_image, vk::ImageLayout::GENERAL, &color, &[range]) };
        }

        // Clear the second color buffer to transparent black
        if data.multi_subpasses {
            image_barrier.image = sec_cb_image;
            image_barrier.new_layout = vk::ImageLayout::GENERAL;
            image_barrier.subresource_range = full_range;
            barrier_to_transfer(image_barrier, vk::PipelineStageFlags::TOP_OF_PIPE);
            let color = unsafe { clear_color.color };
            unsafe { device.cmd_clear_color_image(cmd, sec_cb_image, vk::ImageLayout::GENERAL, &color, &[full_range]) };
        }

        // Clear depth and stencil
        if data.use_depth_stencil {
            let range = make_image_subresource_range(
                vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                data.ds_base_mip_level,
                1,
                data.ds_base_layer,
                vk::REMAINING_ARRAY_LAYERS,
            );
            let mut ds_barrier = image_barrier;
            ds_barrier.image = ds_image;
            ds_barrier.new_layout = vk::ImageLayout::GENERAL;
            ds_barrier.subresource_range = range;
            barrier_to_transfer(ds_barrier, vk::PipelineStageFlags::TOP_OF_PIPE);
            if !data.ds_clear_op {
                let depth_stencil = unsafe { clear_depth_stencil.depth_stencil };
                unsafe {
                    device.cmd_clear_depth_stencil_image(
                        cmd,
                        ds_image,
                        vk::ImageLayout::GENERAL,
                        &depth_stencil,
                        &[range],
                    )
                };
            }
        }

        // Initialize shading rate image with varying values
        if data.use_attachment() {
            image_barrier.image = sr_image;
            image_barrier.new_layout = vk::ImageLayout::GENERAL;
            barrier_to_transfer(image_barrier, vk::PipelineStageFlags::BOTTOM_OF_PIPE);

            let sr_fill_buffer =
                sr_fill_buffer.ok_or_else(|| TestError::InternalError("no shading rate fill buffer".to_string()))?;
            let fill_ptr = host_slice_mut::<u8>(
                sr_fill_buffer,
                (num_sr_layers * sr_width * sr_height * sr_fill_bpp) as usize,
            );
            for layer in 0..num_sr_layers {
                for x in 0..sr_width {
                    for y in 0..sr_height {
                        let idx = (layer * sr_height + y) * sr_width + x;
                        let val = sanitize_rate((idx & 0xF) as i32) as u8;
                        // actual shading rate is always in the LSBs of the first byte of a texel
                        fill_ptr[(sr_fill_bpp * idx) as usize] = val;
                    }
                }
            }
            flush_alloc(device, sr_fill_buffer.get_allocation())?;

            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: num_sr_layers,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: sr_width,
                    height: sr_height,
                    depth: 1,
                },
            };

            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd,
                    sr_fill_buffer.get(),
                    sr_image,
                    vk::ImageLayout::GENERAL,
                    &[copy_region],
                )
            };

            let mut pre_shading_rate_barrier = image_barrier;
            pre_shading_rate_barrier.old_layout = vk::ImageLayout::GENERAL;
            pre_shading_rate_barrier.new_layout = sr_layout;
            pre_shading_rate_barrier.src_access_mask = vk::AccessFlags::TRANSFER_WRITE;
            pre_shading_rate_barrier.dst_access_mask = vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR;

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_shading_rate_barrier],
                );
            }
        }

        let mut mem_barrier = vk::MemoryBarrier::default();
        mem_barrier.src_access_mask = vk::AccessFlags::TRANSFER_WRITE;
        mem_barrier.dst_access_mask = vk::AccessFlags::SHADER_READ
            | vk::AccessFlags::SHADER_WRITE
            | vk::AccessFlags::COLOR_ATTACHMENT_READ
            | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ;
        // VUID-vkCmdPipelineBarrier-dstAccessMask-02816
        if data.use_attachment() {
            mem_barrier.dst_access_mask |= vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR;
        }
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                all_pipeline_stages,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };

        Ok(())
    }
}

impl<'a> TestInstance for FsrInstance<'a> {
    /// `FSRTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let data = self.data;
        let mut simulator = Simulator::new(context, &data)?;

        let mut all_shader_stages = vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE;
        let mut all_pipeline_stages = vk::PipelineStageFlags::FRAGMENT_SHADER
            | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
            | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
            | vk::PipelineStageFlags::COMPUTE_SHADER;
        let vert_buffer_usage = if data.mesh_shader {
            vk::BufferUsageFlags::STORAGE_BUFFER
        } else {
            vk::BufferUsageFlags::VERTEX_BUFFER
        };

        if data.mesh_shader {
            all_shader_stages |= vk::ShaderStageFlags::MESH_EXT;
            all_pipeline_stages |= vk::PipelineStageFlags::MESH_SHADER_EXT;
        } else {
            all_shader_stages |= vk::ShaderStageFlags::VERTEX;
            all_pipeline_stages |= vk::PipelineStageFlags::VERTEX_SHADER;
            if data.geometry_shader {
                all_shader_stages |= vk::ShaderStageFlags::GEOMETRY;
                all_pipeline_stages |= vk::PipelineStageFlags::GEOMETRY_SHADER;
            }
        }

        let mut ds_format = vk::Format::UNDEFINED;
        if data.use_depth_stencil {
            let format_props = unsafe {
                context.get_instance().get_physical_device_format_properties(
                    context.get_physical_device(),
                    vk::Format::D32_SFLOAT_S8_UINT,
                )
            };
            ds_format = if format_props
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
            {
                vk::Format::D32_SFLOAT_S8_UINT
            } else {
                vk::Format::D24_UNORM_S8_UINT
            };
        }

        let mut rnd = Random::new(data.seed as u32);

        let mut res = TestResult::Pass;
        let mut num_unexpected_1x1_samples = 0u32;
        let mut num_total_samples = 0u32;

        const ATTACHMENT_MODE_DEFAULT: u32 = 0;
        const ATTACHMENT_MODE_LAYOUT_OPTIMAL: u32 = 1;
        const ATTACHMENT_MODE_IMAGELESS: u32 = 2;
        const ATTACHMENT_MODE_2DARRAY: u32 = 3;
        const ATTACHMENT_MODE_TILING_LINEAR: u32 = 4;
        const ATTACHMENT_MODE_COUNT: u32 = 5;

        let num_sr_layers = if data.sr_layered { 2u32 } else { 1 };

        let mut min_sr_texel_size = vk::Extent2D { width: 1, height: 1 };
        let mut max_sr_texel_size = vk::Extent2D { width: 1, height: 1 };
        let mut max_sr_texel_aspect_ratio = 1u32;
        let fsr_features = fragment_shading_rate_features(context);
        let fsr_properties = fragment_shading_rate_properties(context);
        if fsr_features.attachment_fragment_shading_rate != vk::FALSE {
            min_sr_texel_size = fsr_properties.min_fragment_shading_rate_attachment_texel_size;
            max_sr_texel_size = fsr_properties.max_fragment_shading_rate_attachment_texel_size;
            max_sr_texel_aspect_ratio = fsr_properties.max_fragment_shading_rate_attachment_texel_size_aspect_ratio;
        }

        let atomic_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let atomic_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                atomic_buffer_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;

        // NUM_TRIANGLES triangles, 3 vertices, 2 components of float position
        let vertex_buffer_size = (NUM_TRIANGLES * 3 * 2 * std::mem::size_of::<f32>()) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                vertex_buffer_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vert_buffer_usage,
            ),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;
        {
            let vbuf = host_slice_mut::<f32>(&vertex_buffer, vertex_buffer_size as usize / std::mem::size_of::<f32>());
            for value in vbuf.iter_mut() {
                *value = rnd.get_float() * 2.0 - 1.0;
            }
            flush_alloc(device, vertex_buffer.get_allocation())?;
        }

        let samples = data.sample_count() as vk::DeviceSize;
        let width = data.framebuffer_dim.width;
        let height = data.framebuffer_dim.height;
        let color_output_buffer_size = u64::from(width)
            * u64::from(height)
            * samples
            * 4
            * std::mem::size_of::<u32>() as vk::DeviceSize
            * vk::DeviceSize::from(data.num_color_layers);
        let color_output_buffer = create_cached_buffer(
            context,
            make_buffer_create_info(
                color_output_buffer_size,
                vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
        )?;

        let mut depth_output_buffer_size = 0;
        let mut stencil_output_buffer_size = 0;
        let mut depth_output_buffer = None;
        let mut stencil_output_buffer = None;
        if data.use_depth_stencil {
            depth_output_buffer_size = u64::from(width)
                * u64::from(height)
                * samples
                * std::mem::size_of::<f32>() as vk::DeviceSize
                * vk::DeviceSize::from(data.num_color_layers);
            depth_output_buffer = Some(create_cached_buffer(
                context,
                make_buffer_create_info(
                    depth_output_buffer_size,
                    vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::STORAGE_BUFFER,
                ),
            )?);
            stencil_output_buffer_size = u64::from(width)
                * u64::from(height)
                * samples
                * std::mem::size_of::<u32>() as vk::DeviceSize
                * vk::DeviceSize::from(data.num_color_layers);
            stencil_output_buffer = Some(create_cached_buffer(
                context,
                make_buffer_create_info(
                    stencil_output_buffer_size,
                    vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::STORAGE_BUFFER,
                ),
            )?);
        }

        let min_sr_texel_width = min_sr_texel_size.width;
        let min_sr_texel_height = min_sr_texel_size.height;
        let max_sr_width = width.div_ceil(min_sr_texel_width);
        let max_sr_height = height.div_ceil(min_sr_texel_height);
        // max size over all formats
        let sr_fill_buffer_size = vk::DeviceSize::from(
            num_sr_layers * max_sr_width * max_sr_height * 32, /*4 component 64-bit*/
        );
        let sr_fill_buffer = if data.use_attachment() {
            Some(create_cached_buffer(
                context,
                make_buffer_create_info(sr_fill_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
            )?)
        } else {
            None
        };

        let cb_image = ImageWithMemory::new(
            device,
            allocator,
            simple_image_info(
                CB_FORMAT,
                (width, height),
                1,
                data.num_color_layers,
                data.samples,
                vk::ImageTiling::OPTIMAL,
                cb_usage(),
            ),
            MemoryRequirement::ANY,
        )?;
        let cb_image_view = simple_view(
            device,
            cb_image.get(),
            vk::ImageViewType::_2D_ARRAY,
            CB_FORMAT,
            vk::ImageAspectFlags::COLOR,
            0,
            1,
            0,
            data.num_color_layers,
        )?;

        let sec_cb_image = if data.multi_subpasses {
            Some(ImageWithMemory::new(
                device,
                allocator,
                simple_image_info(
                    CB_FORMAT,
                    (width, height),
                    1,
                    1,
                    vk::SampleCountFlags::_1,
                    vk::ImageTiling::OPTIMAL,
                    cb_usage(),
                ),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let sec_cb_image_view = match sec_cb_image.as_ref() {
            Some(image) => Some(simple_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                CB_FORMAT,
                vk::ImageAspectFlags::COLOR,
                0,
                1,
                0,
                1,
            )?),
            None => None,
        };
        let sec_cb_image_handle = sec_cb_image.as_ref().map_or_else(vk::Image::null, |image| image.get());
        let sec_cb_image_view_handle = sec_cb_image_view
            .as_ref()
            .map_or_else(vk::ImageView::null, |view| **view);
        let sec_color_output_buffer = if data.multi_subpasses {
            Some(create_cached_buffer(
                context,
                make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            )?)
        } else {
            None
        };

        let ds_image = if data.use_depth_stencil {
            Some(ImageWithMemory::new(
                device,
                allocator,
                simple_image_info(
                    ds_format,
                    (
                        width * (1 << data.ds_base_mip_level),
                        height * (1 << data.ds_base_mip_level),
                    ),
                    data.ds_base_mip_level + 1,
                    data.ds_base_layer + data.num_color_layers,
                    data.samples,
                    vk::ImageTiling::OPTIMAL,
                    ds_usage(),
                ),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let ds_view = |aspect: vk::ImageAspectFlags| make_ds_view(device, ds_image.as_ref(), ds_format, aspect, &data);
        let ds_image_view = ds_view(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL)?;
        let d_image_view = ds_view(vk::ImageAspectFlags::DEPTH)?;
        let s_image_view = ds_view(vk::ImageAspectFlags::STENCIL)?;
        let ds_image_view_handle = ds_image_view.as_ref().map_or_else(vk::ImageView::null, |view| **view);
        let d_image_view_handle = d_image_view.as_ref().map_or_else(vk::ImageView::null, |view| **view);
        let s_image_view_handle = s_image_view.as_ref().map_or_else(vk::ImageView::null, |view| **view);

        // Image used to test implicit derivative calculations. Filled with a value of 1<<lod.
        let max_dim = fsr_properties
            .max_fragment_size
            .width
            .max(fsr_properties.max_fragment_size.height);
        let deriv_num_levels = 1 + max_dim.trailing_zeros();
        let deriv_image = ImageWithMemory::new(
            device,
            allocator,
            simple_image_info(
                vk::Format::R32_UINT,
                (
                    fsr_properties.max_fragment_size.width,
                    fsr_properties.max_fragment_size.height,
                ),
                deriv_num_levels,
                1,
                vk::SampleCountFlags::_1,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let deriv_image_view = simple_view(
            device,
            deriv_image.get(),
            vk::ImageViewType::_2D,
            vk::Format::R32_UINT,
            vk::ImageAspectFlags::COLOR,
            0,
            deriv_num_levels,
            0,
            1,
        )?;

        // sampler used with derivImage
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(deriv_num_levels as f32)
            .border_color(vk::BorderColor::INT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let bindings = [
            set_layout_binding(0, vk::DescriptorType::STORAGE_BUFFER, all_shader_stages),
            set_layout_binding(1, vk::DescriptorType::SAMPLED_IMAGE, all_shader_stages),
            set_layout_binding(2, vk::DescriptorType::STORAGE_BUFFER, all_shader_stages),
            set_layout_binding(3, vk::DescriptorType::COMBINED_IMAGE_SAMPLER, all_shader_stages),
            set_layout_binding(4, vk::DescriptorType::STORAGE_BUFFER, all_shader_stages),
            set_layout_binding(5, vk::DescriptorType::STORAGE_BUFFER, all_shader_stages),
            set_layout_binding(6, vk::DescriptorType::SAMPLED_IMAGE, all_shader_stages),
            set_layout_binding(7, vk::DescriptorType::SAMPLED_IMAGE, all_shader_stages),
        ];
        let mut descriptor_set_layouts = vec![make_set_layout(device, &bindings)?];
        // Mesh shaders use set 1 binding 0 as the vertex buffer.
        if data.mesh_shader {
            let extra_binding = [set_layout_binding(
                0,
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::MESH_EXT,
            )];
            descriptor_set_layouts.push(make_set_layout(device, &extra_binding)?);
        }

        let num_constants = if data.mesh_shader { 2u32 } else { 1 };
        let push_constant_size = std::mem::size_of::<i32>() as u32 * num_constants;
        let push_constant_range = vk::PushConstantRange {
            stage_flags: all_shader_stages,
            offset: 0,
            size: push_constant_size,
        };
        let descriptor_set_layouts_raw: Vec<vk::DescriptorSetLayout> =
            descriptor_set_layouts.iter().map(|layout| **layout).collect();
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&descriptor_set_layouts_raw)
            .push_constant_ranges(std::slice::from_ref(&push_constant_range));
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let fs_programs = context.get_binary_collection();
        let cs_programs = find_programs(&compute_key(&data))?;
        let cs = create_shader_module(device, cs_programs.get("comp")?)?;
        let compute_stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*cs)
            .name(b"main\0");
        let compute_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*compute_stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

        let frag_module = create_shader_module(device, fs_programs.get("frag")?)?;
        let (vert_module, geom_module, mesh_module) = if data.mesh_shader {
            let programs = find_programs(&mesh_key(&data))?;
            (None, None, Some(create_shader_module(device, programs.get("mesh")?)?))
        } else {
            let programs = find_programs(&vertex_key(&data))?;
            let (major, minor, _) = context.api_version();
            let vert = create_shader_module(
                device,
                programs.get(if (major, minor) >= (1, 2) { "vert_1_2" } else { "vert" })?,
            )?;
            let geom = if data.geometry_shader {
                Some(create_shader_module(device, programs.get("geom")?)?)
            } else {
                None
            };
            (Some(vert), geom, None)
        };

        for mode_idx in 0..ATTACHMENT_MODE_COUNT {
            // If we're not using an attachment, don't test all the different attachment modes
            if mode_idx != ATTACHMENT_MODE_DEFAULT && !data.use_attachment() {
                continue;
            }

            // Only test all formats in the default mode
            let num_fill_formats = if mode_idx == ATTACHMENT_MODE_DEFAULT {
                SR_FILL_FORMATS.len() as u32
            } else {
                1
            };

            // Iterate over all supported tile sizes and formats
            let mut sr_texel_width = min_sr_texel_size.width;
            while sr_texel_width <= max_sr_texel_size.width {
                let mut sr_texel_height = min_sr_texel_size.height;
                while sr_texel_height <= max_sr_texel_size.height {
                    for format_idx in 0..num_fill_formats {
                        let aspect_ratio = if sr_texel_height > sr_texel_width {
                            sr_texel_height / sr_texel_width
                        } else {
                            sr_texel_width / sr_texel_height
                        };
                        if aspect_ratio > max_sr_texel_aspect_ratio {
                            continue;
                        }

                        // Go through the loop only once when not using an attachment
                        if !data.use_attachment()
                            && (sr_texel_width != min_sr_texel_size.width
                                || sr_texel_height != min_sr_texel_size.height
                                || format_idx != 0)
                        {
                            continue;
                        }

                        let imageless_fb = mode_idx == ATTACHMENT_MODE_IMAGELESS;
                        let sr_width = width.div_ceil(sr_texel_width);
                        let sr_height = height.div_ceil(sr_texel_height);
                        let sr_format = SR_FILL_FORMATS[format_idx as usize];
                        let sr_fill_bpp = sr_fill_pixel_size(sr_format);
                        let sr_layout = if mode_idx == ATTACHMENT_MODE_LAYOUT_OPTIMAL {
                            vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR
                        } else {
                            vk::ImageLayout::GENERAL
                        };
                        let sr_view_type = if mode_idx == ATTACHMENT_MODE_2DARRAY {
                            vk::ImageViewType::_2D_ARRAY
                        } else {
                            vk::ImageViewType::_2D
                        };
                        let sr_tiling = if mode_idx == ATTACHMENT_MODE_TILING_LINEAR {
                            vk::ImageTiling::LINEAR
                        } else {
                            vk::ImageTiling::OPTIMAL
                        };

                        let sr_format_properties = unsafe {
                            context
                                .get_instance()
                                .get_physical_device_format_properties(context.get_physical_device(), sr_format)
                        };
                        let sr_format_features = if sr_tiling == vk::ImageTiling::LINEAR {
                            sr_format_properties.linear_tiling_features
                        } else {
                            sr_format_properties.optimal_tiling_features
                        };

                        if fsr_features.attachment_fragment_shading_rate != vk::FALSE
                            && !sr_format_features
                                .contains(vk::FormatFeatureFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR)
                        {
                            if sr_format == vk::Format::R8_UINT && sr_tiling == vk::ImageTiling::OPTIMAL {
                                log::info!(
                                    "VK_FORMAT_R8_UINT/VK_IMAGE_TILING_OPTIMAL don't support VK_FORMAT_FEATURE_FRAGMENT_SHADING_RATE_ATTACHMENT_BIT_KHR"
                                );
                                res = TestResult::Fail;
                            }
                            continue;
                        }

                        let mut pool_builder = DescriptorPoolBuilder::new();
                        for binding in &bindings {
                            pool_builder = pool_builder.add_type(binding.descriptor_type, binding.descriptor_count);
                        }
                        if data.mesh_shader {
                            pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_BUFFER, 1);
                        }
                        let descriptor_pool = pool_builder.build(
                            device,
                            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                            descriptor_set_layouts.len() as u32,
                        )?;
                        let mut descriptor_sets = Vec::new();
                        for set_layout in &descriptor_set_layouts {
                            descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, **set_layout)?);
                        }
                        let descriptor_sets_raw: Vec<vk::DescriptorSet> =
                            descriptor_sets.iter().map(|set| set.get()).collect();
                        let main_descriptor_set = descriptor_sets_raw[0];

                        let sr_usage = vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR
                            | vk::ImageUsageFlags::TRANSFER_DST
                            | vk::ImageUsageFlags::TRANSFER_SRC;
                        let (sr_image, sr_image_view) = if data.use_attachment() {
                            let image = ImageWithMemory::new(
                                device,
                                allocator,
                                simple_image_info(
                                    sr_format,
                                    (sr_width, sr_height),
                                    1,
                                    num_sr_layers,
                                    vk::SampleCountFlags::_1,
                                    sr_tiling,
                                    sr_usage,
                                ),
                                MemoryRequirement::ANY,
                            )?;
                            let layer_count = if sr_view_type == vk::ImageViewType::_2D {
                                1
                            } else {
                                num_sr_layers
                            };
                            let view = simple_view(
                                device,
                                image.get(),
                                sr_view_type,
                                sr_format,
                                vk::ImageAspectFlags::COLOR,
                                0,
                                1,
                                0,
                                layer_count,
                            )?;
                            (Some(image), Some(view))
                        } else {
                            (None, None)
                        };
                        let sr_image_handle = sr_image.as_ref().map_or_else(vk::Image::null, |image| image.get());
                        let sr_image_view_handle =
                            sr_image_view.as_ref().map_or_else(vk::ImageView::null, |view| **view);

                        host_slice_mut::<u32>(&atomic_buffer, 1)[0] = 0;
                        flush_alloc(device, atomic_buffer.get_allocation())?;

                        let write_buffer = |binding: u32, buffer: vk::Buffer, range: vk::DeviceSize| {
                            let buffer_info = [vk::DescriptorBufferInfo {
                                buffer,
                                offset: 0,
                                range,
                            }];
                            let write = vk::WriteDescriptorSet::builder()
                                .dst_set(main_descriptor_set)
                                .dst_binding(binding)
                                .dst_array_element(0)
                                .descriptor_type(bindings[binding as usize].descriptor_type)
                                .buffer_info(&buffer_info);
                            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
                        };
                        let write_image = |binding: u32, sampler: vk::Sampler, view: vk::ImageView| {
                            let image_info = [vk::DescriptorImageInfo {
                                sampler,
                                image_view: view,
                                image_layout: vk::ImageLayout::GENERAL,
                            }];
                            let write = vk::WriteDescriptorSet::builder()
                                .dst_set(main_descriptor_set)
                                .dst_binding(binding)
                                .dst_array_element(0)
                                .descriptor_type(bindings[binding as usize].descriptor_type)
                                .image_info(&image_info);
                            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
                        };
                        write_buffer(0, atomic_buffer.get(), atomic_buffer_size);
                        write_image(1, vk::Sampler::null(), *cb_image_view);
                        write_buffer(2, color_output_buffer.get(), color_output_buffer_size);
                        write_image(3, *sampler, *deriv_image_view);
                        if data.use_depth_stencil {
                            if let (Some(depth), Some(stencil)) = (&depth_output_buffer, &stencil_output_buffer) {
                                write_buffer(4, depth.get(), depth_output_buffer_size);
                                write_buffer(5, stencil.get(), stencil_output_buffer_size);
                            }
                            write_image(6, vk::Sampler::null(), d_image_view_handle);
                            write_image(7, vk::Sampler::null(), s_image_view_handle);
                        }

                        // Update vertex buffer descriptor.
                        if data.mesh_shader {
                            let extra_buffer_info = [vk::DescriptorBufferInfo {
                                buffer: vertex_buffer.get(),
                                offset: 0,
                                range: vertex_buffer_size,
                            }];
                            let extra_write = vk::WriteDescriptorSet::builder()
                                .dst_set(descriptor_sets_raw[1])
                                .dst_binding(0)
                                .dst_array_element(0)
                                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                                .buffer_info(&extra_buffer_info);
                            unsafe { device.update_descriptor_sets(&[extra_write], &[] as &[vk::CopyDescriptorSet]) };
                        }

                        // The render pass (and its framebuffer) of the render pass object variant
                        let mut attachments: Vec<vk::ImageView> = vec![*cb_image_view];
                        let mut sr_attachment_idx = 0u32;
                        let mut ds_attachment_idx = 0u32;
                        if data.use_attachment() {
                            sr_attachment_idx = attachments.len() as u32;
                            attachments.push(sr_image_view_handle);
                        }
                        if data.use_depth_stencil {
                            ds_attachment_idx = attachments.len() as u32;
                            attachments.push(ds_image_view_handle);
                        }
                        let mut sec_attachment_idx = 0u32;
                        if data.multi_subpasses {
                            sec_attachment_idx = attachments.len() as u32;
                            attachments.push(sec_cb_image_view_handle);
                        }

                        let mut render_pass: Option<Unique<'_, vk::RenderPass>> = None;
                        let mut framebuffer: Option<Unique<'_, vk::Framebuffer>> = None;
                        if !data.group_params.use_dynamic_rendering {
                            let color_attachment_reference = vk::AttachmentReference2 {
                                attachment: 0,
                                layout: vk::ImageLayout::GENERAL,
                                aspect_mask: vk::ImageAspectFlags::empty(),
                                ..Default::default()
                            };
                            let color_attachment_reference2 = vk::AttachmentReference2 {
                                attachment: sec_attachment_idx,
                                layout: vk::ImageLayout::GENERAL,
                                aspect_mask: vk::ImageAspectFlags::empty(),
                                ..Default::default()
                            };
                            let fragment_shading_rate_attachment = vk::AttachmentReference2 {
                                attachment: sr_attachment_idx,
                                layout: sr_layout,
                                aspect_mask: vk::ImageAspectFlags::empty(),
                                ..Default::default()
                            };
                            let depth_attachment_reference = vk::AttachmentReference2 {
                                attachment: ds_attachment_idx,
                                layout: vk::ImageLayout::GENERAL,
                                aspect_mask: vk::ImageAspectFlags::empty(),
                                ..Default::default()
                            };

                            let no_attachment_ptr = data.attachment_usage == AttachmentUsage::NoAttachmentPtr;
                            let shading_rate_attachment_info = vk::FragmentShadingRateAttachmentInfoKHR {
                                fragment_shading_rate_attachment: if no_attachment_ptr {
                                    std::ptr::null()
                                } else {
                                    &fragment_shading_rate_attachment
                                },
                                shading_rate_attachment_texel_size: vk::Extent2D {
                                    width: sr_texel_width,
                                    height: sr_texel_height,
                                },
                                ..Default::default()
                            };

                            let use_attachment_info = data.attachment_usage != AttachmentUsage::NoAttachment;
                            let subpass_desc = vk::SubpassDescription2 {
                                next: if use_attachment_info {
                                    (&shading_rate_attachment_info as *const vk::FragmentShadingRateAttachmentInfoKHR)
                                        .cast::<c_void>()
                                } else {
                                    std::ptr::null()
                                },
                                flags: vk::SubpassDescriptionFlags::empty(),
                                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                                view_mask: if data.multi_view { 0x3 } else { 0 },
                                input_attachment_count: 0,
                                input_attachments: std::ptr::null(),
                                color_attachment_count: 1,
                                color_attachments: &color_attachment_reference,
                                resolve_attachments: std::ptr::null(),
                                depth_stencil_attachment: if data.use_depth_stencil {
                                    &depth_attachment_reference
                                } else {
                                    std::ptr::null()
                                },
                                preserve_attachment_count: 0,
                                preserve_attachments: std::ptr::null(),
                                ..Default::default()
                            };

                            let sec_subpass_desc = vk::SubpassDescription2 {
                                next: std::ptr::null(),
                                flags: vk::SubpassDescriptionFlags::empty(),
                                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                                view_mask: 0,
                                input_attachment_count: 0,
                                input_attachments: std::ptr::null(),
                                color_attachment_count: 1,
                                color_attachments: &color_attachment_reference2,
                                resolve_attachments: std::ptr::null(),
                                depth_stencil_attachment: if data.use_depth_stencil {
                                    &depth_attachment_reference
                                } else {
                                    std::ptr::null()
                                },
                                preserve_attachment_count: 0,
                                preserve_attachments: std::ptr::null(),
                                ..Default::default()
                            };
                            let mut subpass_descriptions = vec![subpass_desc];
                            if data.multi_subpasses {
                                subpass_descriptions.push(sec_subpass_desc);
                            }

                            let attachment_description =
                                |format: vk::Format,
                                 samples: vk::SampleCountFlags,
                                 load_op: vk::AttachmentLoadOp,
                                 store_op: vk::AttachmentStoreOp,
                                 stencil_load_op: vk::AttachmentLoadOp,
                                 stencil_store_op: vk::AttachmentStoreOp,
                                 layout: vk::ImageLayout| {
                                    vk::AttachmentDescription2 {
                                        flags: vk::AttachmentDescriptionFlags::empty(),
                                        format,
                                        samples,
                                        load_op,
                                        store_op,
                                        stencil_load_op,
                                        stencil_store_op,
                                        initial_layout: layout,
                                        final_layout: layout,
                                        ..Default::default()
                                    }
                                };
                            let mut attachment_descriptions = vec![attachment_description(
                                CB_FORMAT,
                                data.samples,
                                vk::AttachmentLoadOp::LOAD,
                                vk::AttachmentStoreOp::STORE,
                                vk::AttachmentLoadOp::DONT_CARE,
                                vk::AttachmentStoreOp::DONT_CARE,
                                vk::ImageLayout::GENERAL,
                            )];

                            if data.use_attachment() {
                                attachment_descriptions.push(attachment_description(
                                    sr_format,
                                    vk::SampleCountFlags::_1,
                                    vk::AttachmentLoadOp::LOAD,
                                    vk::AttachmentStoreOp::STORE,
                                    vk::AttachmentLoadOp::DONT_CARE,
                                    vk::AttachmentStoreOp::DONT_CARE,
                                    sr_layout,
                                ));
                            }

                            if data.use_depth_stencil {
                                attachment_descriptions.push(attachment_description(
                                    ds_format,
                                    data.samples,
                                    if data.ds_clear_op {
                                        vk::AttachmentLoadOp::CLEAR
                                    } else {
                                        vk::AttachmentLoadOp::LOAD
                                    },
                                    vk::AttachmentStoreOp::STORE,
                                    vk::AttachmentLoadOp::LOAD,
                                    vk::AttachmentStoreOp::STORE,
                                    vk::ImageLayout::GENERAL,
                                ));
                            }

                            let mut subpass_dependencies: Vec<vk::SubpassDependency2> = Vec::new();
                            if data.multi_subpasses {
                                attachment_descriptions.push(attachment_description(
                                    CB_FORMAT,
                                    vk::SampleCountFlags::_1,
                                    vk::AttachmentLoadOp::LOAD,
                                    vk::AttachmentStoreOp::STORE,
                                    vk::AttachmentLoadOp::DONT_CARE,
                                    vk::AttachmentStoreOp::DONT_CARE,
                                    vk::ImageLayout::GENERAL,
                                ));

                                subpass_dependencies.push(vk::SubpassDependency2 {
                                    src_subpass: vk::SUBPASS_EXTERNAL,
                                    dst_subpass: 0,
                                    src_stage_mask: vk::PipelineStageFlags::empty(),
                                    dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                                        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                                        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                                    src_access_mask: vk::AccessFlags::empty(),
                                    dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
                                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                                    dependency_flags: vk::DependencyFlags::BY_REGION,
                                    view_offset: 0,
                                    ..Default::default()
                                });
                                subpass_dependencies.push(vk::SubpassDependency2 {
                                    src_subpass: 0,
                                    dst_subpass: 1,
                                    src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                                        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                                    dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                                        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                                    src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
                                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                                    dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                                    dependency_flags: vk::DependencyFlags::BY_REGION,
                                    view_offset: 0,
                                    ..Default::default()
                                });
                            }

                            let correlated_view_mask = 0x3u32;
                            let render_pass_params = vk::RenderPassCreateInfo2 {
                                flags: vk::RenderPassCreateFlags::empty(),
                                attachment_count: attachment_descriptions.len() as u32,
                                attachments: attachment_descriptions.as_ptr(),
                                subpass_count: subpass_descriptions.len() as u32,
                                subpasses: subpass_descriptions.as_ptr(),
                                dependency_count: subpass_dependencies.len() as u32,
                                dependencies: if data.multi_subpasses {
                                    subpass_dependencies.as_ptr()
                                } else {
                                    std::ptr::null()
                                },
                                correlated_view_mask_count: u32::from(data.correlation_mask),
                                correlated_view_masks: if data.correlation_mask {
                                    &correlated_view_mask
                                } else {
                                    std::ptr::null()
                                },
                                ..Default::default()
                            };
                            let handle = unsafe { device.create_render_pass2_khr(&render_pass_params, None) }
                                .vk_check("vkCreateRenderPass2KHR")?;
                            let render_pass_handle = Unique::new(device, handle);

                            let attachment_image_info =
                                |usage: vk::ImageUsageFlags, w: u32, h: u32, layers: u32, format: &vk::Format| {
                                    vk::FramebufferAttachmentImageInfo {
                                        flags: vk::ImageCreateFlags::empty(),
                                        usage,
                                        width: w,
                                        height: h,
                                        layer_count: layers,
                                        view_format_count: 1,
                                        view_formats: format,
                                        ..Default::default()
                                    }
                                };
                            let cb_format_value = CB_FORMAT;
                            let mut framebuffer_attachment_image_info = vec![attachment_image_info(
                                cb_usage(),
                                width,
                                height,
                                data.num_color_layers,
                                &cb_format_value,
                            )];
                            if data.use_attachment() {
                                framebuffer_attachment_image_info.push(attachment_image_info(
                                    sr_usage,
                                    sr_width,
                                    sr_height,
                                    if sr_view_type == vk::ImageViewType::_2D {
                                        1
                                    } else {
                                        num_sr_layers
                                    },
                                    &sr_format,
                                ));
                            }
                            if data.use_depth_stencil {
                                framebuffer_attachment_image_info.push(attachment_image_info(
                                    ds_usage(),
                                    width,
                                    height,
                                    data.num_color_layers,
                                    &ds_format,
                                ));
                            }
                            if data.multi_subpasses {
                                framebuffer_attachment_image_info.push(attachment_image_info(
                                    cb_usage(),
                                    width,
                                    height,
                                    1,
                                    &cb_format_value,
                                ));
                            }
                            let framebuffer_attachments_create_info = vk::FramebufferAttachmentsCreateInfo {
                                attachment_image_info_count: framebuffer_attachment_image_info.len() as u32,
                                attachment_image_infos: framebuffer_attachment_image_info.as_ptr(),
                                ..Default::default()
                            };

                            let framebuffer_params = vk::FramebufferCreateInfo {
                                next: if imageless_fb {
                                    (&framebuffer_attachments_create_info
                                        as *const vk::FramebufferAttachmentsCreateInfo)
                                        .cast::<c_void>()
                                } else {
                                    std::ptr::null()
                                },
                                flags: if imageless_fb {
                                    vk::FramebufferCreateFlags::IMAGELESS
                                } else {
                                    vk::FramebufferCreateFlags::empty()
                                },
                                render_pass: *render_pass_handle,
                                attachment_count: attachments.len() as u32,
                                attachments: if imageless_fb {
                                    std::ptr::null()
                                } else {
                                    attachments.as_ptr()
                                },
                                width,
                                height,
                                layers: if data.multi_view { 1 } else { data.num_color_layers },
                                ..Default::default()
                            };
                            let framebuffer_handle = unsafe { device.create_framebuffer(&framebuffer_params, None) }
                                .vk_check("vkCreateFramebuffer")?;
                            framebuffer = Some(Unique::new(device, framebuffer_handle));
                            render_pass = Some(render_pass_handle);
                        }
                        let render_pass_handle = render_pass
                            .as_ref()
                            .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);

                        let mut viewports = Vec::new();
                        let mut scissors = Vec::new();
                        if data.multi_viewport {
                            // Split the viewport into left and right halves
                            let x0 = 0i32;
                            let x1 = (width / 2) as i32;
                            let x2 = width as i32;

                            viewports.push(vk::Viewport {
                                x: x0 as f32,
                                y: 0.0,
                                width: ((x1 - x0) as f32).max(1.0),
                                height: height as f32,
                                min_depth: 0.0,
                                max_depth: 1.0,
                            });
                            scissors.push(vk::Rect2D {
                                offset: vk::Offset2D { x: x0, y: 0 },
                                extent: vk::Extent2D {
                                    width: (x1 - x0) as u32,
                                    height,
                                },
                            });

                            viewports.push(vk::Viewport {
                                x: x1 as f32,
                                y: 0.0,
                                width: ((x2 - x1) as f32).max(1.0),
                                height: height as f32,
                                min_depth: 0.0,
                                max_depth: 1.0,
                            });
                            scissors.push(vk::Rect2D {
                                offset: vk::Offset2D { x: x1, y: 0 },
                                extent: vk::Extent2D {
                                    width: (x2 - x1) as u32,
                                    height,
                                },
                            });
                        } else {
                            viewports.push(vk::Viewport {
                                x: 0.0,
                                y: 0.0,
                                width: width as f32,
                                height: height as f32,
                                min_depth: 0.0,
                                max_depth: 1.0,
                            });
                            scissors.push(rect_2d(width, height));
                        }

                        let draw_args = DrawArgs {
                            viewports: &viewports,
                            scissors: &scissors,
                            pipeline_layout: *pipeline_layout,
                            render_pass: render_pass_handle,
                            vert_shader: module_handle(vert_module.as_ref()),
                            geom_shader: module_handle(geom_module.as_ref()),
                            mesh_shader: module_handle(mesh_module.as_ref()),
                            frag_shader: *frag_module,
                            descriptor_sets: &descriptor_sets_raw,
                            vertex_buffer: vertex_buffer.get(),
                            push_constant_size,
                            ds_format,
                        };

                        let queue = context.get_universal_queue();
                        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
                        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                        let cmd = *cmd_buffer;
                        let clear_color = make_clear_value_color_u32(0, 0, 0, 0);
                        let clear_depth_stencil = make_clear_value_depth_stencil(0.0, 0);

                        let mut pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();

                        let simple_shaders = if data.multi_subpasses && !data.group_params.use_dynamic_rendering {
                            let simple_programs = find_programs(&simple_key(&data))?;
                            let simple_vert = create_shader_module(device, simple_programs.get("vert_simple")?)?;
                            let simple_frag = create_shader_module(device, simple_programs.get("frag_simple")?)?;
                            Some((simple_vert, simple_frag, make_pipeline_layout(device, &[])?))
                        } else {
                            None
                        };
                        let sec_vertex_buf = if simple_shaders.is_some() {
                            let buffer = BufferWithMemory::new(
                                device,
                                allocator,
                                make_buffer_create_info(
                                    vertex_buffer_size,
                                    vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::VERTEX_BUFFER,
                                ),
                                MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
                            )?;
                            let quad: [f32; 16] = [
                                -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
                            ];
                            host_slice_mut::<f32>(&buffer, quad.len()).copy_from_slice(&quad);
                            flush_alloc(device, buffer.get_allocation())?;
                            Some(buffer)
                        } else {
                            None
                        };

                        let sr_texel_size = vk::Extent2D {
                            width: sr_texel_width,
                            height: sr_texel_height,
                        };
                        let pre_render = |cmd: vk::CommandBuffer| {
                            self.pre_render_commands(
                                cmd,
                                cb_image.get(),
                                sec_cb_image_handle,
                                ds_image.as_ref().map_or_else(vk::Image::null, |image| image.get()),
                                deriv_image.get(),
                                deriv_num_levels,
                                sr_image_handle,
                                sr_layout,
                                sr_fill_buffer.as_ref(),
                                num_sr_layers,
                                sr_width,
                                sr_height,
                                sr_fill_bpp,
                                clear_color,
                                clear_depth_stencil,
                            )
                        };

                        let sec_cmd_buffer;
                        if data.group_params.use_secondary_cmd_buffer {
                            sec_cmd_buffer =
                                allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
                            let sec_cmd = *sec_cmd_buffer;
                            let completely_contains = data
                                .group_params
                                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

                            // record secondary command buffer
                            if completely_contains {
                                self.begin_secondary_cmd_buffer(
                                    sec_cmd,
                                    ds_format,
                                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS,
                                )?;
                                self.begin_dynamic_render(
                                    sec_cmd,
                                    sr_image_view_handle,
                                    sr_layout,
                                    sr_texel_size,
                                    *cb_image_view,
                                    ds_image_view_handle,
                                    clear_color,
                                    clear_depth_stencil,
                                    vk::RenderingFlags::empty(),
                                );
                            } else {
                                self.begin_secondary_cmd_buffer(sec_cmd, ds_format, vk::RenderingFlags::empty())?;
                            }

                            self.draw_commands(sec_cmd, &mut pipelines, &draw_args)?;

                            if completely_contains {
                                unsafe { device.cmd_end_rendering(sec_cmd) };
                            }

                            end_command_buffer(device, sec_cmd)?;

                            // record primary command buffer
                            let begin_info = vk::CommandBufferBeginInfo::builder();
                            unsafe { device.begin_command_buffer(cmd, &begin_info) }
                                .vk_check("vkBeginCommandBuffer")?;

                            pre_render(cmd)?;
                            if !completely_contains {
                                self.begin_dynamic_render(
                                    cmd,
                                    sr_image_view_handle,
                                    sr_layout,
                                    sr_texel_size,
                                    *cb_image_view,
                                    ds_image_view_handle,
                                    clear_color,
                                    clear_depth_stencil,
                                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS,
                                );
                            }

                            unsafe { device.cmd_execute_commands(cmd, &[sec_cmd]) };

                            if !completely_contains {
                                unsafe { device.cmd_end_rendering(cmd) };
                            }
                        } else if data.group_params.use_dynamic_rendering {
                            begin_command_buffer(device, cmd)?;
                            pre_render(cmd)?;
                            self.begin_dynamic_render(
                                cmd,
                                sr_image_view_handle,
                                sr_layout,
                                sr_texel_size,
                                *cb_image_view,
                                ds_image_view_handle,
                                clear_color,
                                clear_depth_stencil,
                                vk::RenderingFlags::empty(),
                            );
                            self.draw_commands(cmd, &mut pipelines, &draw_args)?;
                            unsafe { device.cmd_end_rendering(cmd) };
                        }

                        if !data.group_params.use_dynamic_rendering {
                            begin_command_buffer(device, cmd)?;
                            pre_render(cmd)?;

                            // `beginLegacyRender`
                            let mut render_pass_attachments: Vec<vk::ImageView> = vec![*cb_image_view];
                            if data.use_attachment() {
                                render_pass_attachments.push(sr_image_view_handle);
                            }
                            if data.use_depth_stencil {
                                render_pass_attachments.push(ds_image_view_handle);
                            }
                            if data.multi_subpasses {
                                render_pass_attachments.push(sec_cb_image_view_handle);
                            }

                            // VUID-vkCmdBindPipeline-variableSampleLocations-01525
                            let sample_locations =
                                vec![vk::SampleLocationEXT { x: 0.5, y: 0.5 }; data.sample_count() as usize];
                            let subpass_sample_locations = vk::SubpassSampleLocationsEXT {
                                subpass_index: 0,
                                sample_locations_info: vk::SampleLocationsInfoEXT {
                                    sample_locations_per_pixel: data.samples,
                                    sample_location_grid_size: vk::Extent2D { width: 1, height: 1 },
                                    sample_locations_count: data.sample_count(),
                                    sample_locations: sample_locations.as_ptr(),
                                    ..Default::default()
                                },
                            };
                            let sample_locations_begin_info = vk::RenderPassSampleLocationsBeginInfoEXT {
                                attachment_initial_sample_locations_count: 0,
                                attachment_initial_sample_locations: std::ptr::null(),
                                post_subpass_sample_locations_count: 1,
                                post_subpass_sample_locations: &subpass_sample_locations,
                                ..Default::default()
                            };
                            let p_next: *const c_void = if data.sample_locations {
                                (&sample_locations_begin_info as *const vk::RenderPassSampleLocationsBeginInfoEXT)
                                    .cast::<c_void>()
                            } else {
                                std::ptr::null()
                            };

                            let render_pass_attachment_begin_info = vk::RenderPassAttachmentBeginInfo {
                                next: p_next,
                                attachment_count: render_pass_attachments.len() as u32,
                                attachments: render_pass_attachments.as_ptr(),
                                ..Default::default()
                            };

                            let mut clear_vals: Vec<vk::ClearValue> = Vec::new();
                            if data.ds_clear_op {
                                clear_vals.push(vk::ClearValue {
                                    color: vk::ClearColorValue { float32: [0.0; 4] },
                                });
                                if data.use_attachment() {
                                    clear_vals.push(vk::ClearValue {
                                        color: vk::ClearColorValue { float32: [0.0; 4] },
                                    });
                                }
                                if data.use_depth_stencil {
                                    clear_vals.push(make_clear_value_depth_stencil(0.0, 0));
                                }
                                if data.multi_subpasses {
                                    clear_vals.push(vk::ClearValue {
                                        color: vk::ClearColorValue { float32: [0.0; 4] },
                                    });
                                }
                            }

                            let begin_info = vk::RenderPassBeginInfo {
                                next: if imageless_fb {
                                    (&render_pass_attachment_begin_info as *const vk::RenderPassAttachmentBeginInfo)
                                        .cast::<c_void>()
                                } else {
                                    p_next
                                },
                                render_pass: render_pass_handle,
                                framebuffer: framebuffer
                                    .as_ref()
                                    .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer),
                                render_area: rect_2d(width, height),
                                clear_value_count: if data.ds_clear_op { clear_vals.len() as u32 } else { 0 },
                                clear_values: if data.ds_clear_op {
                                    clear_vals.as_ptr()
                                } else {
                                    std::ptr::null()
                                },
                                ..Default::default()
                            };
                            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

                            self.draw_commands(cmd, &mut pipelines, &draw_args)?;

                            if let (Some((simple_vert, simple_frag, simple_layout)), Some(sec_vertex_buf)) =
                                (simple_shaders.as_ref(), sec_vertex_buf.as_ref())
                            {
                                self.draw_commands_on_normal_subpass(
                                    cmd,
                                    &mut pipelines,
                                    &draw_args,
                                    **simple_layout,
                                    **simple_vert,
                                    **simple_frag,
                                    1,
                                    sec_vertex_buf.get(),
                                )?;
                            }

                            unsafe { device.cmd_end_render_pass(cmd) };

                            if let Some(sec_color_output_buffer) = sec_color_output_buffer.as_ref() {
                                self.copy_image_to_buffer_on_normal_subpass(
                                    cmd,
                                    sec_cb_image_handle,
                                    sec_color_output_buffer.get(),
                                    color_output_buffer_size,
                                );
                            }
                        }

                        let mem_barrier = vk::MemoryBarrier::builder()
                            .src_access_mask(
                                vk::AccessFlags::SHADER_READ
                                    | vk::AccessFlags::SHADER_WRITE
                                    | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                                    | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                            )
                            .dst_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE)
                            .build();
                        unsafe {
                            device.cmd_pipeline_barrier(
                                cmd,
                                all_pipeline_stages,
                                all_pipeline_stages,
                                vk::DependencyFlags::empty(),
                                &[mem_barrier],
                                &[] as &[vk::BufferMemoryBarrier],
                                &[] as &[vk::ImageMemoryBarrier],
                            );

                            device.cmd_bind_descriptor_sets(
                                cmd,
                                vk::PipelineBindPoint::COMPUTE,
                                *pipeline_layout,
                                0,
                                &[main_descriptor_set],
                                &[] as &[u32],
                            );
                            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);

                            // Copy color/depth/stencil buffers to buffer memory
                            device.cmd_dispatch(cmd, width, height, data.num_color_layers);
                        }

                        let host_barrier = vk::MemoryBarrier::builder()
                            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                            .dst_access_mask(vk::AccessFlags::HOST_READ)
                            .build();
                        unsafe {
                            device.cmd_pipeline_barrier(
                                cmd,
                                vk::PipelineStageFlags::COMPUTE_SHADER,
                                vk::PipelineStageFlags::HOST,
                                vk::DependencyFlags::empty(),
                                &[host_barrier],
                                &[] as &[vk::BufferMemoryBarrier],
                                &[] as &[vk::ImageMemoryBarrier],
                            );
                        }

                        end_command_buffer(device, cmd)?;
                        submit_commands_and_wait(device, queue, cmd)?;

                        invalidate_alloc(device, color_output_buffer.get_allocation())?;
                        invalidate_alloc(device, atomic_buffer.get_allocation())?;
                        let sec_color_ptr: &[u32] = match &sec_color_output_buffer {
                            Some(buffer) if data.multi_subpasses => {
                                invalidate_alloc(device, buffer.get_allocation())?;
                                host_slice::<u32>(buffer, (color_output_buffer_size / 4) as usize)
                            }
                            _ => &[],
                        };
                        let colorptr = host_slice::<u32>(&color_output_buffer, (color_output_buffer_size / 4) as usize);
                        let fill_ptr: &[u8] = match &sr_fill_buffer {
                            Some(buffer) => host_slice::<u8>(buffer, sr_fill_buffer_size as usize),
                            None => &[],
                        };

                        let mut depthptr: &[f32] = &[];
                        let mut stencilptr: &[u32] = &[];
                        if data.use_depth_stencil
                            && let (Some(depth), Some(stencil)) = (&depth_output_buffer, &stencil_output_buffer)
                        {
                            depthptr = host_slice::<f32>(depth, (depth_output_buffer_size / 4) as usize);
                            invalidate_alloc(device, depth.get_allocation())?;
                            stencilptr = host_slice::<u32>(stencil, (stencil_output_buffer_size / 4) as usize);
                            invalidate_alloc(device, stencil.get_allocation())?;
                        }

                        let fragment_shading_rate_with_custom_sample_locations =
                            fsr_properties.fragment_shading_rate_with_custom_sample_locations != vk::FALSE;
                        let sample_mask: u32 = if data.sample_mask_test { 0x9 } else { 0x7D56 };
                        let sample_count = data.sample_count();
                        let sample_index = |layer: u32, y: u32, x: u32, s: u32| {
                            4 * ((((layer * height + y) * width + x) * sample_count + s) as usize)
                        };
                        let depth_index = |layer: u32, y: u32, x: u32, s: u32| {
                            (((layer * height + y) * width + x) * sample_count + s) as usize
                        };

                        // Loop over all samples and validate the output
                        'validate: for layer in 0..data.num_color_layers {
                            for y in 0..height {
                                for x in 0..width {
                                    for s in 0..sample_count {
                                        if res != TestResult::Pass {
                                            break 'validate;
                                        }

                                        let base = sample_index(layer, y, x, s);
                                        let sample: [u32; 4] = [
                                            colorptr[base],
                                            colorptr[base + 1],
                                            colorptr[base + 2],
                                            colorptr[base + 3],
                                        ];

                                        // If testing the rasterizer sample mask, if this sample is not set in the mask then it shouldn't have written anything.
                                        if data.use_api_sample_mask && sample_mask & (1 << s) == 0 && sample[2] != 0 {
                                            log::info!("sample written despite pSampleMask ({x:x},{y:x},sample {s:x})");
                                            res = TestResult::Fail;
                                            continue;
                                        }

                                        // The same isn't covered by any primitives, skip it
                                        if sample[2] == 0 {
                                            continue;
                                        }

                                        // skip samples that have the same value as sample zero - it would be redundant to check them.
                                        if s > 0 {
                                            let base0 = sample_index(layer, y, x, 0);
                                            let mut same = colorptr[base..base + 4] == colorptr[base0..base0 + 4];

                                            if (data.frag_depth && !data.multi_subpasses)
                                                || (!data.frag_depth && data.use_depth_stencil)
                                            {
                                                same = same
                                                    && depthptr[depth_index(layer, y, x, s)]
                                                        == depthptr[depth_index(layer, y, x, 0)];
                                            }

                                            if (data.frag_stencil && !data.multi_subpasses)
                                                || (!data.frag_stencil && data.use_depth_stencil)
                                            {
                                                same = same
                                                    && stencilptr[depth_index(layer, y, x, s)]
                                                        == stencilptr[depth_index(layer, y, x, 0)];
                                            }

                                            if same {
                                                continue;
                                            }
                                        }

                                        // Fragment shader writes error codes to .w component. All nonzero values are unconditionally failures
                                        if sample[3] != 0 {
                                            if sample[3] == ERROR_FRAGCOORD_CENTER {
                                                log::info!(
                                                    "fragcoord test failed pixel (0x{x:x},0x{y:x},sample 0x{s:x})"
                                                );
                                            } else if sample[3] == ERROR_VTG_READBACK {
                                                log::info!(
                                                    "vs/gs output readback test failed pixel (0x{x:x},0x{y:x},sample 0x{s:x})"
                                                );
                                            } else if sample[3] & 0xFF == ERROR_FRAGCOORD_DERIV {
                                                log::info!(
                                                    "fragcoord derivative test failed pixel (0x{x:x},0x{y:x},sample 0x{s:x})=(0x{:x},0x{:x}), expected=(0x{:x},0x{:x})",
                                                    (sample[3] >> 8) & 0x3F,
                                                    (sample[3] >> 14) & 0x3F,
                                                    (sample[3] >> 20) & 0x3F,
                                                    (sample[3] >> 26) & 0x3F
                                                );
                                            } else if sample[3] & 0xFF == ERROR_FRAGCOORD_IMPLICIT_DERIV {
                                                log::info!(
                                                    "implicit derivative test failed pixel (0x{x:x},0x{y:x},sample 0x{s:x})=(0x{:x},0x{:x}), expected=(0x{:x},0x{:x})",
                                                    (sample[3] >> 8) & 0x3F,
                                                    (sample[3] >> 14) & 0x3F,
                                                    (sample[3] >> 20) & 0x3F,
                                                    (sample[3] >> 26) & 0x3F
                                                );
                                            } else {
                                                log::info!(
                                                    "w coord unknown test failed pixel (0x{x:x},0x{y:x},sample 0x{s:x})"
                                                );
                                            }
                                            res = TestResult::Fail;
                                            continue;
                                        }

                                        // x component of sample
                                        let rate = sample[0];
                                        // fragment size
                                        let pixels_x = 1u32 << ((rate / 4) & 3);
                                        let pixels_y = 1u32 << (rate & 3);

                                        // Fragment region
                                        let frag_min_x = x & !(pixels_x - 1);
                                        let frag_min_y = y & !(pixels_y - 1);
                                        let mut frag_max_x = frag_min_x + pixels_x;
                                        let mut frag_max_y = frag_min_y + pixels_y;

                                        // Clamp to FB dimension for odd sizes
                                        if frag_max_x > width {
                                            frag_max_x = width;
                                        }
                                        if frag_max_y > height {
                                            frag_max_y = height;
                                        }

                                        // z component of sample
                                        let prim_id = sample[2] >> 24;
                                        let atom_val = sample[2] & 0xFFFFFF;

                                        // Compute pipeline and primitive rate from primitive ID, and attachment rate from the x/y coordinate
                                        let pipeline_rate = prim_id_to_pipeline_shading_rate(prim_id as i32);
                                        let primitive_rate = if data.shader_writes_rate {
                                            prim_id_to_primitive_shading_rate(prim_id as i32)
                                        } else {
                                            0
                                        };

                                        let attachment_layer = if data.sr_layered && mode_idx == ATTACHMENT_MODE_2DARRAY
                                        {
                                            layer
                                        } else {
                                            0
                                        };
                                        let attachment_rate = if data.use_attachment() {
                                            i32::from(
                                                fill_ptr[(sr_fill_bpp
                                                    * ((attachment_layer * sr_height + (y / sr_texel_height))
                                                        * sr_width
                                                        + (x / sr_texel_width)))
                                                    as usize],
                                            )
                                        } else {
                                            0
                                        };

                                        // Get mask of allowed shading rates
                                        let expected_masks =
                                            simulator.simulate(pipeline_rate, primitive_rate, attachment_rate);

                                        if expected_masks & (1 << rate) == 0 {
                                            log::info!(
                                                "unexpected shading rate. failed pixel (0x{x:x},0x{y:x},sample 0x{s:x}) result rate 0x{rate:x} mask of expected rates 0x{expected_masks:x} pipelineRate=0x{pipeline_rate:x} primitiveRate=0x{primitive_rate:x} attachmentRate =0x{attachment_rate:x}"
                                            );
                                            res = TestResult::Fail;
                                            continue;
                                        }
                                        // Check that not all fragments are downgraded to 1x1
                                        if rate == 0 && expected_masks != 1 {
                                            num_unexpected_1x1_samples += 1;
                                        }
                                        num_total_samples += 1;

                                        // Check that gl_FragDepth = primID / NUM_TRIANGLES
                                        if (data.frag_depth && !data.multi_subpasses)
                                            || (!data.frag_depth && data.use_depth_stencil)
                                        {
                                            let dsample = depthptr[depth_index(layer, y, x, s)];
                                            let expected = if data.frag_depth {
                                                prim_id as f32 / NUM_TRIANGLES as f32
                                            } else {
                                                0.4f32
                                            };
                                            if f64::from((dsample - expected).abs()) > 0.01 {
                                                log::info!(
                                                    "depth write failed pixel (0x{x:x},0x{y:x},sample 0x{s:x})={dsample} expected {expected}"
                                                );
                                                res = TestResult::Fail;
                                                continue;
                                            }
                                        }

                                        // Check that stencil value = primID
                                        if (data.frag_stencil && !data.multi_subpasses)
                                            || (!data.frag_stencil && data.use_depth_stencil)
                                        {
                                            let ssample = stencilptr[depth_index(layer, y, x, s)];
                                            let expected = if data.frag_stencil { prim_id } else { 2 };
                                            if ssample != expected {
                                                log::info!(
                                                    "stencil write failed pixel (0x{x:x},0x{y:x},sample 0x{s:x})={ssample} expected {expected}"
                                                );
                                                res = TestResult::Fail;
                                                continue;
                                            }
                                        }

                                        // Check that primitives are in the right viewport/scissor
                                        if data.multi_viewport {
                                            let scissor = &scissors[(prim_id & 1) as usize];
                                            if (x as i32) < scissor.offset.x
                                                || (x as i32) >= (scissor.offset.x + scissor.extent.width as i32)
                                                || (y as i32) < scissor.offset.y
                                                || (y as i32) >= (scissor.offset.y + scissor.extent.height as i32)
                                            {
                                                log::info!(
                                                    "primitive found outside of expected viewport (0x{x:x},0x{y:x},sample 0x{s:x}) primID={prim_id:x}"
                                                );
                                                res = TestResult::Fail;
                                                continue;
                                            }
                                        }

                                        // Check that primitives are in the right layer
                                        if data.color_layered && layer != ((prim_id & 2) >> 1) {
                                            log::info!(
                                                "primitive found in wrong layer (0x{x:x},0x{y:x},sample 0x{s:x}) primID={prim_id:x} layer={layer:x}"
                                            );
                                            res = TestResult::Fail;
                                            continue;
                                        }

                                        // Check that multiview broadcasts the same primitive to both layers
                                        if data.multi_view {
                                            let other_layer = layer ^ 1;
                                            let other_base = sample_index(other_layer, y, x, s);
                                            let other_prim_id = colorptr[other_base + 2] >> 24;
                                            if prim_id != other_prim_id {
                                                log::info!(
                                                    "multiview primitive mismatch (0x{x:x},0x{y:x},sample 0x{s:x}) primID={prim_id:x}  otherPrimID={other_prim_id:x}"
                                                );
                                                res = TestResult::Fail;
                                                continue;
                                            }
                                        }

                                        // Loop over all samples in the same fragment
                                        for fx in frag_min_x..frag_max_x {
                                            for fy in frag_min_y..frag_max_y {
                                                for fs in 0..sample_count {
                                                    let fbase = sample_index(layer, fy, fx, fs);
                                                    let fsample: [u32; 4] = [
                                                        colorptr[fbase],
                                                        colorptr[fbase + 1],
                                                        colorptr[fbase + 2],
                                                        colorptr[fbase + 3],
                                                    ];
                                                    let frate = fsample[0];
                                                    let fprim_id = fsample[2] >> 24;
                                                    let fatom_val = fsample[2] & 0xFFFFFF;

                                                    // If we write out the sample mask value, check that the samples in the mask must not be uncovered, and
                                                    // that samples not in the mask must not be covered by this primitive
                                                    if data.use_sample_mask_in {
                                                        let p = (pixels_x * pixels_y) as i32
                                                            - ((fx - frag_min_x) as i32
                                                                + pixels_x as i32 * (fy - frag_min_y) as i32)
                                                            - 1;
                                                        let sample_idx = (fs as i32 + sample_count as i32 * p) as u32;
                                                        let bit_set =
                                                            sample_idx < 32 && sample[1] & (1 << sample_idx) != 0;

                                                        if bit_set && fsample[2] == 0 {
                                                            log::info!(
                                                                "sample set in sampleMask but not written (0x{fx:x},0x{fy:x},sample 0x{fs:x})"
                                                            );
                                                            res = TestResult::Fail;
                                                            continue;
                                                        }
                                                        if !bit_set && fsample[2] != 0 && fprim_id == prim_id {
                                                            log::info!(
                                                                "sample not set in sampleMask but written with same primID (0x{fx:x},0x{fy:x},sample 0x{fs:x})"
                                                            );
                                                            res = TestResult::Fail;
                                                            continue;
                                                        }
                                                    }

                                                    // If conservative raster is enabled, or custom sample locations all at the center, check that samples in the
                                                    // same pixel must be covered.
                                                    if data.conservative_enable
                                                        || (data.sample_locations
                                                            && fragment_shading_rate_with_custom_sample_locations)
                                                    {
                                                        // If it's in the same pixel, expect it to be fully covered.
                                                        if fx == x && fy == y && fsample[2] == 0 {
                                                            log::info!(
                                                                "pixel not fully covered (0x{fx:x},0x{fy:x},sample 0x{fs:x})"
                                                            );
                                                            res = TestResult::Fail;
                                                            continue;
                                                        }
                                                    }

                                                    if fsample[2] == 0 {
                                                        continue;
                                                    }

                                                    // If the primitive matches this sample, then it must have the same rate and atomic value
                                                    if fprim_id == prim_id
                                                        && (rate != frate
                                                            || (atom_val != fatom_val
                                                                && !(data.sample_shading_enable
                                                                    || data.sample_shading_input)))
                                                    {
                                                        log::info!(
                                                            "failed pixel (0x{x:x},0x{y:x},sample {s})=0x{:x} compared to (0x{fx:x},0x{fy:x},sample {fs})=0x{:x} pipelineRate=0x{pipeline_rate:x} primitiveRate=0x{primitive_rate:x} attachmentRate =0x{attachment_rate:x}",
                                                            (prim_id << 24) | atom_val,
                                                            (fprim_id << 24) | fatom_val
                                                        );
                                                        res = TestResult::Fail;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        if res == TestResult::Fail {
                            break;
                        }

                        if data.multi_subpasses {
                            let expected_texel = [128u32, 128, 128, 1];
                            let pixel_count = (width * height) as usize;
                            let image_matches = sec_color_ptr[..pixel_count * 4].chunks_exact(4).all(|texel| {
                                texel
                                    .iter()
                                    .zip(expected_texel)
                                    .all(|(&value, expected)| value.abs_diff(expected) <= 1)
                            });
                            if !image_matches {
                                log::info!("Image Comparison of the second subpass failed");
                                return Ok(TestStatus::fail("Fail"));
                            }

                            for y in 0..height {
                                for x in 0..width {
                                    if data.use_depth_stencil {
                                        let dsample = depthptr[(y * width + x) as usize];
                                        if f64::from((dsample - 0.4f32).abs()) > 0.0001 {
                                            log::info!(
                                                "On another subpass, depth write failed pixel (0x{x:x},0x{y:x},sample 0x1)={dsample} expected 0.4f"
                                            );
                                            res = TestResult::Fail;
                                            break;
                                        }
                                        let ssample = stencilptr[(y * width + x) as usize];
                                        let reference = if data.frag_stencil { 1u32 } else { 2 };
                                        if ssample != reference {
                                            log::info!(
                                                "On another subpass, stencil write failed pixel (0x{x:x},0x{y:x},sample 0x1)={ssample} expected {reference}"
                                            );
                                            res = TestResult::Fail;
                                            break;
                                        }
                                    }
                                }
                                if res == TestResult::Fail {
                                    break;
                                }
                            }
                        }
                    }
                    if res == TestResult::Fail {
                        break;
                    }
                    sr_texel_height *= 2;
                }
                if res == TestResult::Fail {
                    break;
                }
                sr_texel_width *= 2;
            }
            if res == TestResult::Fail {
                break;
            }
        }

        // All samples were coerced to 1x1, unexpected
        if res == TestResult::Pass
            && num_total_samples != 0
            && num_unexpected_1x1_samples == num_total_samples
            && num_total_samples > 16
        {
            log::info!("Quality warning - all fragments used 1x1");
            res = TestResult::QualityWarning;
        }

        Ok(TestStatus::new(res, res.as_str()))
    }
}

/// The `shdCases` axis of `createBasicTests`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    Vertex,
    Geometry,
    Mesh,
}

/// `TestGroupCaseId`
#[derive(Clone, Copy, PartialEq, Eq)]
enum GroupCase {
    Basic,
    ApiSampleMask,
    SampleMaskIn,
    ConservativeUnder,
    ConservativeOver,
    FragDepth,
    FragStencil,
    MultiViewport,
    ColorLayered,
    SrLayered,
    MultiView,
    MultiViewSrLayered,
    MultiViewCorrelation,
    Interlock,
    SampleLocations,
    SampleShadingEnable,
    SampleShadingInput,
    FragDepthEarlyLate,
    FragStencilEarlyLate,
    FragDepthClear,
    FragStencilClear,
    FragDepthBaseLevel,
    FragStencilBaseLevel,
    Multipass,
    MultipassFragDepth,
    MultipassFragStencil,
    Maintenance6,
    SampleMaskOut,
    DsBaseLevel,
    DsBaseLayer,
    DsBaseLevelBaseLayer,
}

const GROUP_CASES: [(GroupCase, &str); 31] = [
    // basic tests
    (GroupCase::Basic, "basic"),
    // use pSampleMask
    (GroupCase::ApiSampleMask, "apisamplemask"),
    // use gl_SampleMaskIn
    (GroupCase::SampleMaskIn, "samplemaskin"),
    // conservative underestimation
    (GroupCase::ConservativeUnder, "conservativeunder"),
    // conservative overestimation
    (GroupCase::ConservativeOver, "conservativeover"),
    // depth shader output
    (GroupCase::FragDepth, "fragdepth"),
    // stencil shader output
    (GroupCase::FragStencil, "fragstencil"),
    // multiple viewports and gl_ViewportIndex
    (GroupCase::MultiViewport, "multiviewport"),
    // multiple layer color, single layer shading rate
    (GroupCase::ColorLayered, "colorlayered"),
    // multiple layer color, multiple layers shading rate
    (GroupCase::SrLayered, "srlayered"),
    // multiview
    (GroupCase::MultiView, "multiview"),
    // multiview and multilayer shading rate
    (GroupCase::MultiViewSrLayered, "multiviewsrlayered"),
    // multiview with correlation mask
    (GroupCase::MultiViewCorrelation, "multiviewcorrelation"),
    // fragment shader interlock
    (GroupCase::Interlock, "interlock"),
    // custom sample locations
    (GroupCase::SampleLocations, "samplelocations"),
    // enable sample shading in createinfo
    (GroupCase::SampleShadingEnable, "sampleshadingenable"),
    // enable sample shading by using gl_SampleID
    (GroupCase::SampleShadingInput, "sampleshadinginput"),
    // depth shader output
    (GroupCase::FragDepthEarlyLate, "fragdepth_early_late"),
    // stencil shader output
    (GroupCase::FragStencilEarlyLate, "fragstencil_early_late"),
    (GroupCase::FragDepthClear, "fragdepth_clear"),
    (GroupCase::FragStencilClear, "fragstencil_clear"),
    (GroupCase::FragDepthBaseLevel, "fragdepth_baselevel"),
    (GroupCase::FragStencilBaseLevel, "fragstencil_baselevel"),
    (GroupCase::Multipass, "multipass"),
    (GroupCase::MultipassFragDepth, "multipass_fragdepth"),
    (GroupCase::MultipassFragStencil, "multipass_fragstencil"),
    (GroupCase::Maintenance6, "maintenance6"),
    (GroupCase::SampleMaskOut, "samplemaskout"),
    (GroupCase::DsBaseLevel, "ds_baselevel"),
    (GroupCase::DsBaseLayer, "ds_baselayer"),
    (GroupCase::DsBaseLevelBaseLayer, "ds_baselevel_baselayer"),
];

/// `createBasicTests`
pub fn create_basic_tests(parent_group: &mut TestCaseGroup, group_params: GroupParams) {
    let group_cases = GROUP_CASES;
    let dyn_cases = [(true, "dynamic"), (false, "static")];
    let att_cases = [
        (AttachmentUsage::NoAttachment, "noattachment"),
        (AttachmentUsage::WithAttachment, "attachment"),
        (AttachmentUsage::NoAttachmentPtr, "noattachmentptr"),
        (
            AttachmentUsage::WithAttachmentWithoutImageView,
            "attachment_noimageview",
        ),
    ];
    let shd_cases = [(false, "noshaderrate"), (true, "shaderrate")];
    let comb_cases = [
        (vk::FragmentShadingRateCombinerOpKHR::KEEP, "keep"),
        (vk::FragmentShadingRateCombinerOpKHR::REPLACE, "replace"),
        (vk::FragmentShadingRateCombinerOpKHR::MIN, "min"),
        (vk::FragmentShadingRateCombinerOpKHR::MAX, "max"),
        (vk::FragmentShadingRateCombinerOpKHR::MUL, "mul"),
    ];
    let extent_cases = [
        (vk::Extent2D { width: 1, height: 1 }, "1x1"),
        (vk::Extent2D { width: 4, height: 4 }, "4x4"),
        (vk::Extent2D { width: 33, height: 35 }, "33x35"),
        (
            vk::Extent2D {
                width: 151,
                height: 431,
            },
            "151x431",
        ),
        (
            vk::Extent2D {
                width: 256,
                height: 256,
            },
            "256x256",
        ),
    ];
    let samp_cases = [
        (vk::SampleCountFlags::_1, "samples1"),
        (vk::SampleCountFlags::_2, "samples2"),
        (vk::SampleCountFlags::_4, "samples4"),
        (vk::SampleCountFlags::_8, "samples8"),
        (vk::SampleCountFlags::_16, "samples16"),
    ];
    let shader_cases = [
        (ShaderType::Vertex, "vs"),
        (ShaderType::Geometry, "gs"),
        (ShaderType::Mesh, "ms"),
    ];

    let mut seed = 0i32;

    // for graphics pipeline library we need to repeat only selected groups
    let gpl_group_set = [
        GroupCase::SampleMaskIn,
        GroupCase::ConservativeUnder,
        GroupCase::ConservativeOver,
        GroupCase::MultiView,
        GroupCase::MultiViewSrLayered,
        GroupCase::MultiViewCorrelation,
        GroupCase::Interlock,
        GroupCase::SampleLocations,
        GroupCase::SampleShadingEnable,
    ];

    for (group_case_id, group_name) in group_cases {
        if group_params.use_dynamic_rendering
            && (group_case_id == GroupCase::MultiViewCorrelation || group_case_id == GroupCase::Maintenance6)
        {
            continue;
        }

        if group_params.construction != PipelineConstructionType::Monolithic && !gpl_group_set.contains(&group_case_id)
        {
            continue;
        }

        let mut group = TestCaseGroup::new(group_name);

        for (use_dynamic_state, dyn_name) in dyn_cases {
            // reduce number of tests for dynamic rendering cases where secondary command buffer is used
            if group_params.use_secondary_cmd_buffer && !use_dynamic_state {
                continue;
            }

            let mut dyn_group = TestCaseGroup::new(dyn_name);

            for (attachment_usage, att_name) in att_cases {
                if group_params.use_dynamic_rendering && attachment_usage == AttachmentUsage::NoAttachmentPtr {
                    continue;
                }

                // WITH_ATTACHMENT_WITHOUT_IMAGEVIEW is only for VkRenderingFragmentShadingRateAttachmentInfoKHR.
                if !group_params.use_dynamic_rendering
                    && attachment_usage == AttachmentUsage::WithAttachmentWithoutImageView
                {
                    continue;
                }

                let mut att_group = TestCaseGroup::new(att_name);

                for (shader_writes_rate, shd_name) in shd_cases {
                    let mut shd_group = TestCaseGroup::new(shd_name);

                    for (cmb0_op, cmb0_name) in comb_cases {
                        let mut cmb0_group = TestCaseGroup::new(cmb0_name);

                        for (cmb1_op, cmb1_name) in comb_cases {
                            let mut cmb1_group = TestCaseGroup::new(cmb1_name);

                            for (ext_ndx, (extent, ext_name)) in extent_cases.iter().enumerate() {
                                // reduce number of cases repeat every other extent case for graphics pipeline library
                                if group_params.construction != PipelineConstructionType::Monolithic && ext_ndx % 2 == 1
                                {
                                    continue;
                                }

                                // reduce number of tests for dynamic rendering cases where secondary command buffer is used
                                if group_params.use_secondary_cmd_buffer && ext_ndx != 1 {
                                    continue;
                                }

                                let mut ext_group = TestCaseGroup::new(*ext_name);

                                for (samp_ndx, (samples, samp_name)) in samp_cases.iter().enumerate() {
                                    // reduce number of tests for dynamic rendering cases where secondary command buffer is used
                                    if group_params.use_secondary_cmd_buffer && samp_ndx != 1 {
                                        continue;
                                    }

                                    let mut samp_group = TestCaseGroup::new(*samp_name);

                                    for (shader_type, shader_name) in shader_cases {
                                        // reduce number of tests for dynamic rendering cases where secondary command buffer is used
                                        if group_params.use_secondary_cmd_buffer && shader_type != ShaderType::Vertex {
                                            continue;
                                        }

                                        let use_api_sample_mask = group_case_id == GroupCase::ApiSampleMask;
                                        let use_sample_mask_in = group_case_id == GroupCase::SampleMaskIn;
                                        let use_sample_mask_out = group_case_id == GroupCase::SampleMaskOut;
                                        let cons_rast = group_case_id == GroupCase::ConservativeUnder
                                            || group_case_id == GroupCase::ConservativeOver;
                                        let frag_depth = matches!(
                                            group_case_id,
                                            GroupCase::FragDepth
                                                | GroupCase::FragDepthEarlyLate
                                                | GroupCase::FragDepthClear
                                                | GroupCase::FragDepthBaseLevel
                                                | GroupCase::MultipassFragDepth
                                        );
                                        let frag_stencil = matches!(
                                            group_case_id,
                                            GroupCase::FragStencil
                                                | GroupCase::FragStencilEarlyLate
                                                | GroupCase::FragStencilClear
                                                | GroupCase::FragStencilBaseLevel
                                                | GroupCase::MultipassFragStencil
                                        );
                                        let multi_viewport = group_case_id == GroupCase::MultiViewport;
                                        let color_layered = group_case_id == GroupCase::ColorLayered
                                            || group_case_id == GroupCase::SrLayered;
                                        let sr_layered = group_case_id == GroupCase::SrLayered
                                            || group_case_id == GroupCase::MultiViewSrLayered;
                                        let multi_view = matches!(
                                            group_case_id,
                                            GroupCase::MultiView
                                                | GroupCase::MultiViewSrLayered
                                                | GroupCase::MultiViewCorrelation
                                        );
                                        let correlation_mask = group_case_id == GroupCase::MultiViewCorrelation;
                                        let interlock = group_case_id == GroupCase::Interlock;
                                        let sample_locations = group_case_id == GroupCase::SampleLocations;
                                        let sample_shading_enable = group_case_id == GroupCase::SampleShadingEnable;
                                        let sample_shading_input = group_case_id == GroupCase::SampleShadingInput;
                                        let use_geometry_shader = shader_type == ShaderType::Geometry;
                                        let use_mesh_shader = shader_type == ShaderType::Mesh;
                                        let early_and_late_test = matches!(
                                            group_case_id,
                                            GroupCase::FragDepthEarlyLate | GroupCase::FragStencilEarlyLate
                                        );
                                        let op_clear = matches!(
                                            group_case_id,
                                            GroupCase::FragDepthClear | GroupCase::FragStencilClear
                                        );
                                        let ds_base_mip_level = u32::from(matches!(
                                            group_case_id,
                                            GroupCase::FragDepthBaseLevel
                                                | GroupCase::FragStencilBaseLevel
                                                | GroupCase::DsBaseLevel
                                                | GroupCase::DsBaseLevelBaseLayer
                                        ));
                                        let ds_base_layer = u32::from(matches!(
                                            group_case_id,
                                            GroupCase::DsBaseLayer | GroupCase::DsBaseLevelBaseLayer
                                        ));
                                        let multi_pass = matches!(
                                            group_case_id,
                                            GroupCase::Multipass
                                                | GroupCase::MultipassFragDepth
                                                | GroupCase::MultipassFragStencil
                                        );
                                        let maintenance6 = group_case_id == GroupCase::Maintenance6;
                                        let use_depth_stencil = frag_depth
                                            || frag_stencil
                                            || matches!(
                                                group_case_id,
                                                GroupCase::DsBaseLevel
                                                    | GroupCase::DsBaseLayer
                                                    | GroupCase::DsBaseLevelBaseLayer
                                            );
                                        let conservative_mode = if group_case_id == GroupCase::ConservativeUnder {
                                            vk::ConservativeRasterizationModeEXT::UNDERESTIMATE
                                        } else {
                                            vk::ConservativeRasterizationModeEXT::OVERESTIMATE
                                        };
                                        let num_color_layers = if color_layered || multi_view { 2u32 } else { 1 };

                                        // Don't bother with geometry shader if we're not testing shader writes
                                        if use_geometry_shader && !shader_writes_rate {
                                            continue;
                                        }

                                        // reduce number of tests
                                        let keep_or_replace = |op: vk::FragmentShadingRateCombinerOpKHR| {
                                            op == vk::FragmentShadingRateCombinerOpKHR::KEEP
                                                || op == vk::FragmentShadingRateCombinerOpKHR::REPLACE
                                        };
                                        if group_case_id != GroupCase::Basic
                                            && (!use_dynamic_state
                                                || !keep_or_replace(cmb0_op)
                                                || !keep_or_replace(cmb1_op))
                                        {
                                            continue;
                                        }

                                        // Don't bother with geometry shader if we're testing conservative raster, sample mask, depth/stencil
                                        if use_geometry_shader
                                            && (use_api_sample_mask
                                                || use_sample_mask_in
                                                || cons_rast
                                                || use_depth_stencil
                                                || maintenance6
                                                || use_sample_mask_out)
                                        {
                                            continue;
                                        }

                                        // Don't bother with geometry shader if we're testing non-dynamic state
                                        if use_geometry_shader && !use_dynamic_state {
                                            continue;
                                        }

                                        // Only test multiViewport/layered with shaderWritesRate
                                        if (multi_viewport || color_layered) && !shader_writes_rate {
                                            continue;
                                        }

                                        // Can't test layered shading rate attachment without an attachment
                                        if sr_layered && attachment_usage != AttachmentUsage::WithAttachment {
                                            continue;
                                        }

                                        // Test opClear for DS cases with only attachment and renderpass.
                                        if op_clear
                                            && (attachment_usage != AttachmentUsage::WithAttachment
                                                || group_params.use_dynamic_rendering)
                                        {
                                            continue;
                                        }

                                        // Test baseLevel and baseLayer for DS cases with only attachment, single sample, and renderpass.
                                        if (ds_base_mip_level > 0 || ds_base_layer > 0)
                                            && (attachment_usage != AttachmentUsage::WithAttachment
                                                || group_params.use_dynamic_rendering
                                                || *samples != vk::SampleCountFlags::_1)
                                        {
                                            continue;
                                        }

                                        // Test multipass for DS cases with only attachment, single sample, and renderpass.
                                        if multi_pass
                                            && (attachment_usage != AttachmentUsage::WithAttachment
                                                || group_params.use_dynamic_rendering
                                                || *samples != vk::SampleCountFlags::_1)
                                        {
                                            continue;
                                        }

                                        // Skip maintenance6 tests if there is no FSR attachment
                                        if maintenance6 && attachment_usage != AttachmentUsage::WithAttachment {
                                            continue;
                                        }

                                        let data = CaseDef {
                                            group_params,
                                            seed,
                                            framebuffer_dim: *extent,
                                            samples: *samples,
                                            combiner_op: [cmb0_op, cmb1_op],
                                            attachment_usage,
                                            shader_writes_rate,
                                            geometry_shader: use_geometry_shader,
                                            mesh_shader: use_mesh_shader,
                                            use_dynamic_state,
                                            use_api_sample_mask,
                                            use_sample_mask_in,
                                            use_sample_mask_out,
                                            conservative_enable: cons_rast,
                                            conservative_mode,
                                            use_depth_stencil,
                                            frag_depth,
                                            frag_stencil,
                                            multi_viewport,
                                            color_layered,
                                            sr_layered,
                                            num_color_layers,
                                            multi_view,
                                            correlation_mask,
                                            interlock,
                                            sample_locations,
                                            sample_shading_enable,
                                            sample_shading_input,
                                            sample_mask_test: false,
                                            early_and_late_test,
                                            ds_clear_op: op_clear,
                                            ds_base_mip_level,
                                            ds_base_layer,
                                            maintenance6,
                                            helper_invocation: false,
                                            multi_subpasses: multi_pass,
                                        };
                                        seed += 1;
                                        samp_group.add_child(Box::new(FsrTestCase {
                                            name: shader_name.to_string(),
                                            data,
                                        })
                                            as Box<dyn TestCase>);
                                    }
                                    ext_group.add_child(samp_group);
                                }
                                cmb1_group.add_child(ext_group);
                            }
                            cmb0_group.add_child(cmb1_group);
                        }
                        shd_group.add_child(cmb0_group);
                    }
                    att_group.add_child(shd_group);
                }
                dyn_group.add_child(att_group);
            }
            group.add_child(dyn_group);
        }
        parent_group.add_child(group);
    }

    // Single tests that don't need to be part of the matrix above
    let mut group = TestCaseGroup::new("misc_tests");
    if !group_params.use_secondary_cmd_buffer {
        for (name, sample_mask_test, helper_invocation) in
            [("sample_mask_test", true, false), ("helper_invocation", false, true)]
        {
            let data = CaseDef {
                group_params,
                seed: 123,
                framebuffer_dim: vk::Extent2D { width: 32, height: 33 },
                samples: vk::SampleCountFlags::_4,
                combiner_op: [
                    vk::FragmentShadingRateCombinerOpKHR::KEEP,
                    vk::FragmentShadingRateCombinerOpKHR::KEEP,
                ],
                attachment_usage: AttachmentUsage::NoAttachment,
                shader_writes_rate: true,
                geometry_shader: false,
                mesh_shader: false,
                use_dynamic_state: false,
                use_api_sample_mask: true,
                use_sample_mask_in: false,
                use_sample_mask_out: false,
                conservative_enable: false,
                conservative_mode: vk::ConservativeRasterizationModeEXT::UNDERESTIMATE,
                use_depth_stencil: false,
                frag_depth: false,
                frag_stencil: false,
                multi_viewport: false,
                color_layered: false,
                sr_layered: false,
                num_color_layers: 1,
                multi_view: false,
                correlation_mask: false,
                interlock: false,
                sample_locations: false,
                sample_shading_enable: false,
                sample_shading_input: false,
                sample_mask_test,
                early_and_late_test: false,
                ds_clear_op: false,
                ds_base_mip_level: 0,
                ds_base_layer: 0,
                maintenance6: false,
                helper_invocation,
                multi_subpasses: false,
            };
            group.add_child(Box::new(FsrTestCase {
                name: name.to_string(),
                data,
            }) as Box<dyn TestCase>);
        }
    }
    parent_group.add_child(group);
}
