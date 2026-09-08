// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingShaderAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The test asks a shader which descriptor it actually reached. Four workgroups, one
// per "quadrant", each read one of the two colours in their descriptor and write it to
// a result buffer; the host knows which colour every descriptor was filled with, so a
// binding that resolved to the wrong resource shows up as the wrong colour rather than
// as a crash. The result buffer starts as -1 in every component, which distinguishes
// "wrote the wrong thing" from "never ran".
//
// Ported so far: the compute half of the buffer and storage image descriptor types.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::binding_model_shader_access::{ALL_BUFFER_ACCESS_PROGRAM, ALL_IMAGE_ACCESS_PROGRAM};
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{self, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the compute shader plus the three things
/// the generator built it for, so the host can assert it picked the right one.
pub struct BufferAccessProgram {
    pub name: &'static str,
    pub storage_type: &'static str,
    pub set_count: &'static str,
    pub shader_interface: &'static str,
    pub programs: BinaryCollection,
}

/// The manifest declares the storage image cases with this. Unlike the buffer types,
/// which share a shader across every view, an image case bakes its fetch coordinates
/// into the GLSL, so there is one program per case and `view_name` identifies it.
pub struct ImageAccessProgram {
    pub name: &'static str,
    /// Which of `storage_image` / `sampler` / `combined_image_sampler` the shader
    /// declares. The mutable and immutable sampler cases share a shader: immutability
    /// is a property of the layout, not of the GLSL.
    pub descriptor_type: &'static str,
    pub view_name: &'static str,
    pub set_count: &'static str,
    pub shader_interface: &'static str,
    pub programs: BinaryCollection,
}

/// `DescriptorSetCount`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DescriptorSetCount {
    Single,
    Multiple,
    MultipleDiscontiguous,
}

impl DescriptorSetCount {
    /// `getDescriptorSetCount`
    fn count(self) -> u32 {
        match self {
            Self::Single => 1,
            Self::Multiple | Self::MultipleDiscontiguous => 2,
        }
    }

    /// `getDescriptorSetNdx` - which set index each of them binds to. The
    /// discontiguous variant leaves a gap that an unused layout fills.
    fn set_ndx(self, ndx: u32) -> u32 {
        match self {
            Self::Single => 0,
            Self::Multiple => ndx,
            Self::MultipleDiscontiguous => [0, 2][ndx as usize],
        }
    }

    fn manifest_name(self) -> &'static str {
        match self {
            Self::Single => "single",
            Self::Multiple => "multiple",
            Self::MultipleDiscontiguous => "multiple_discontiguous",
        }
    }
}

/// `DescriptorUpdateMethod`.
/// /// absent rather than present-and-skipped.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DescriptorUpdateMethod {
    Normal,
    WithTemplate,
    /// The descriptors are written into the command buffer at bind time rather than
    /// into a set, so no set is ever allocated.
    WithPush,
    WithPushTemplate,
}

impl DescriptorUpdateMethod {
    /// The group upstream puts the method under. The normal method has none: its
    /// descriptor types sit directly under the bind command.
    fn group_name(self) -> Option<&'static str> {
        match self {
            Self::Normal => None,
            Self::WithTemplate => Some("with_template"),
            Self::WithPush => Some("with_push"),
            Self::WithPushTemplate => Some("with_push_template"),
        }
    }

    /// Whether the descriptors go into the command buffer instead of into a set.
    fn is_push(self) -> bool {
        matches!(self, Self::WithPush | Self::WithPushTemplate)
    }

    fn uses_template(self) -> bool {
        matches!(self, Self::WithTemplate | Self::WithPushTemplate)
    }
}

/// `ShaderInputInterface`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ShaderInputInterface {
    SingleDescriptor,
    MultipleContiguousDescriptors,
    MultipleDiscontiguousDescriptors,
    MultipleArbitraryDescriptors,
    DescriptorArray,
}

impl ShaderInputInterface {
    /// `getInterfaceNumResources`
    fn num_resources(self) -> u32 {
        if self == Self::SingleDescriptor { 1 } else { 2 }
    }

    fn manifest_name(self) -> &'static str {
        match self {
            Self::SingleDescriptor => "single_descriptor",
            Self::MultipleContiguousDescriptors => "multiple_contiguous",
            Self::MultipleDiscontiguousDescriptors => "multiple_discontiguous",
            Self::MultipleArbitraryDescriptors => "multiple_arbitrary",
            Self::DescriptorArray => "descriptor_array",
        }
    }

    fn case_name(self) -> &'static str {
        match self {
            Self::SingleDescriptor => "single_descriptor",
            Self::MultipleContiguousDescriptors => "multiple_contiguous_descriptors",
            Self::MultipleDiscontiguousDescriptors => "multiple_discontiguous_descriptors",
            Self::MultipleArbitraryDescriptors => "multiple_arbitrary_descriptors",
            Self::DescriptorArray => "descriptor_array",
        }
    }
}

/// `getArbitraryBindingIndex` - the largest binding values glslang accepts.
/// Where a descriptor write lands. A push case has no set to write into: the
/// descriptors go straight into the command buffer at bind time, which is why the
/// writes have to be built inside the recording rather than before it.
#[derive(Clone, Copy)]
enum DescriptorTarget {
    /// The layout travels with the set: a descriptor update template built against a
    /// different one walks the update data with the wrong strides, which reads off the
    /// end of the registry and writes garbage descriptors. That is a driver-side
    /// segfault or a GPU hang, not a test failure, so it must not be representable.
    Set { set: vk::DescriptorSet, layout: vk::DescriptorSetLayout },
    Push {
        cmd: vk::CommandBuffer,
        bind_point: vk::PipelineBindPoint,
        layout: vk::PipelineLayout,
        set_ndx: u32,
    },
}

impl DescriptorTarget {
    /// The `dstSet` a write names. A pushed write ignores it, and the spec requires it
    /// to be null there.
    fn set(self) -> vk::DescriptorSet {
        match self {
            Self::Set { set, .. } => set,
            Self::Push { .. } => vk::DescriptorSet::null(),
        }
    }

    fn apply(self, device: &Device, writes: &[vk::WriteDescriptorSet]) {
        match self {
            Self::Set { .. } => unsafe { device.update_descriptor_sets(writes, &[] as &[vk::CopyDescriptorSet]) },
            Self::Push { cmd, bind_point, layout, set_ndx } => {
                use vulkanalia::vk::KhrPushDescriptorExtensionDeviceCommands;
                unsafe { device.cmd_push_descriptor_set_khr(cmd, bind_point, layout, set_ndx, writes) };
            }
        }
    }
}

fn arbitrary_binding_index(ndx: u32) -> u32 {
    [0x7FFE, 0xFFFE][ndx as usize]
}

/// `verifyDriverSupport`'s update-method half.
fn verify_update_method_support(context: &Context, method: DescriptorUpdateMethod) -> Result<(), TestError> {
    if method.uses_template() {
        context.require_device_functionality("VK_KHR_descriptor_update_template")?;
    }
    if method.is_push() {
        context.require_device_functionality("VK_KHR_push_descriptor")?;
    }
    Ok(())
}

fn is_uniform_descriptor_type(t: vk::DescriptorType) -> bool {
    matches!(
        t,
        vk::DescriptorType::UNIFORM_BUFFER | vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC | vk::DescriptorType::UNIFORM_TEXEL_BUFFER
    )
}

fn is_dynamic_descriptor_type(t: vk::DescriptorType) -> bool {
    matches!(t, vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC | vk::DescriptorType::STORAGE_BUFFER_DYNAMIC)
}

/// `BufferComputeInstance`'s offsets.
const STATIC_OFFSET_VALUE_A: u32 = 256;
const DYNAMIC_OFFSET_VALUE_A: u32 = 512;
const STATIC_OFFSET_VALUE_B: u32 = 1024;
const DYNAMIC_OFFSET_VALUE_B: u32 = 768;
/// `ADDRESSABLE_SIZE` - deliberately far more than the two vec4s that are read.
const ADDRESSABLE_SIZE: u32 = 256;
/// `ComputeInstanceResultBuffer::DATA_SIZE`
const RESULT_DATA_SIZE: u64 = 4 * 4 * 4;

/// The four colours the buffers are filled with, in upstream's order.
/// `RENDER_SIZE` - the quadrant target is 128x128, so each quadrant is 64x64.
const RENDER_SIZE: u32 = 128;

const COLORS: [[f32; 4]; 4] = [
    [0.0, 1.0, 0.0, 1.0], // green
    [1.0, 1.0, 0.0, 1.0], // yellow
    [0.0, 0.0, 1.0, 1.0], // blue
    [1.0, 0.0, 0.0, 1.0], // red
];

/// Which resource the descriptors point at. Both go through the same instance: the
/// descriptor arrangement, the dispatch and the verification are identical, and only
/// what a descriptor refers to and how the reference value is computed differ.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ResourceKind {
    /// A buffer holding two colours.
    Buffer,
    /// A buffer view over a generated texel pattern.
    TexelBuffer,
}

/// `verifyDriverSupport` - the stage a case reads its descriptor in has to exist on the
/// device at all. Both tessellation configurations build both tessellation shaders, so
/// either one needs the feature.
fn check_stage_support(context: &Context, stage_flags: vk::ShaderStageFlags, bind2: bool) -> Result<(), TestError> {
    if bind2 {
        context.require_device_functionality("VK_KHR_maintenance6")?;
    }
    let features = context.get_device_features();
    let tessellation = stage_flags.intersects(vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION);
    if tessellation && features.tessellation_shader != vk::TRUE {
        return Err(TestError::NotSupported("tessellationShader not supported".into()));
    }
    if stage_flags.contains(vk::ShaderStageFlags::GEOMETRY) && features.geometry_shader != vk::TRUE {
        return Err(TestError::NotSupported("geometryShader not supported".into()));
    }
    // A descriptor read from a vertex, tessellation or geometry stage is a store-free
    // read, so `vertexPipelineStoresAndAtomics` is not what is at stake here; upstream
    // asks for nothing more than the stage itself.
    Ok(())
}

/// `SingleTargetRenderInstance` + `SingleCmdRenderInstance::renderToTarget` - the part
/// that is the same whatever the descriptors are: a 128x128 colour target, one draw of
/// 24 vertices covering it in four quadrants, and the result read back.
///
/// `is_primary` false is upstream's `secondary_cmd_buf`: the draw is recorded into a
/// secondary command buffer and executed from inside the render pass, which is the same
/// work reached through a different recording path.
#[allow(clippy::too_many_arguments)]
fn render_quadrants(
    device: &Device,
    allocator: &crate::vk::mem_util::SimpleAllocator,
    queue: vk::Queue,
    queue_index: u32,
    pipeline_layout: vk::PipelineLayout,
    stages: GraphicsPipelineStages,
    is_primary: bool,
    bind: &dyn Fn(&Device, vk::CommandBuffer),
) -> Result<Vec<u8>, TestError> {
    use crate::vk::obj_util::{make_framebuffer, make_render_pass};

    let format = vk::Format::R8G8B8A8_UNORM;
    let color_image = ImageWithMemory::new(
        device,
        allocator,
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build(),
        MemoryRequirement::ANY,
    )?;
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        format,
        vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        },
    )?;
    let render_pass = make_render_pass(device, format)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], RENDER_SIZE, RENDER_SIZE, 1)?;

    let pipeline = make_quadrant_pipeline(device, pipeline_layout, *render_pass, stages)?;

    let read_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(u64::from(RENDER_SIZE * RENDER_SIZE * 4), vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let command_pool = make_command_pool(device, queue_index)?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

    // The secondary buffer inherits the render pass it will be executed inside, so
    // it is recorded before the primary one opens that pass.
    let pass_cmd = if is_primary {
        None
    } else {
        let cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::SECONDARY)?;
        let inherit = vk::CommandBufferInheritanceInfo::builder()
            .render_pass(*render_pass)
            .subpass(0)
            .framebuffer(*framebuffer)
            .occlusion_query_enable(false)
            .build();
        let info = vk::CommandBufferBeginInfo::builder()
            .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
            .inheritance_info(&inherit);
        unsafe { device.begin_command_buffer(*cmd, &info) }.vk_check("vkBeginCommandBuffer")?;
        unsafe {
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            bind(device, *cmd);
            device.cmd_draw(*cmd, 6 * 4, 1, 0, 0);
        }
        end_command_buffer(device, *cmd)?;
        Some(cmd)
    };

    begin_command_buffer(device, *command_buffer)?;
    unsafe {
        let clear = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0, 0.0, 0.0, 0.0] },
        }];
        let begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            })
            .clear_values(&clear);
        device.cmd_begin_render_pass(
            *command_buffer,
            &begin,
            if is_primary {
                vk::SubpassContents::INLINE
            } else {
                vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
            },
        );
        if is_primary {
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            bind(device, *command_buffer);
            // Four quads, two triangles each.
            device.cmd_draw(*command_buffer, 6 * 4, 1, 0, 0);
        } else {
            device.cmd_execute_commands(*command_buffer, &[**pass_cmd.as_ref().expect("recorded above")]);
        }
        device.cmd_end_render_pass(*command_buffer);

        let to_src = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
            .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(color_image.get())
            .subresource_range(vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            })
            .build();
        device.cmd_pipeline_barrier(
            *command_buffer,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_src],
        );

        let region = vk::BufferImageCopy::builder()
            .buffer_offset(0)
            .buffer_row_length(0)
            .buffer_image_height(0)
            .image_subresource(vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            })
            .image_offset(vk::Offset3D { x: 0, y: 0, z: 0 })
            .image_extent(vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            })
            .build();
        device.cmd_copy_image_to_buffer(*command_buffer, color_image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, read_buffer.get(), &[region]);

        let to_host = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(read_buffer.get())
            .offset(0)
            .size(vk::WHOLE_SIZE)
            .build();
        device.cmd_pipeline_barrier(
            *command_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[to_host],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, *command_buffer)?;
    submit_commands_and_wait(device, queue, *command_buffer)?;
    invalidate_alloc(device, read_buffer.get_allocation())?;

    Ok(unsafe { std::slice::from_raw_parts(read_buffer.get_allocation().get_host_ptr(), (RENDER_SIZE * RENDER_SIZE * 4) as usize) }.to_vec())
}

/// `RenderInstanceShaders` - which of the generated programs each stage configuration
/// uses. The "contributing" pair is for the case where both stages read a descriptor
/// and each owns half the image.
#[allow(clippy::type_complexity)]
fn graphics_modules<'a>(
    device: &'a Device,
    programs: &BinaryCollection,
    stage_flags: vk::ShaderStageFlags,
) -> Result<(Vec<Unique<'a, vk::ShaderModule>>, GraphicsPipelineStages), TestError> {
    let vertex = stage_flags.contains(vk::ShaderStageFlags::VERTEX);
    let fragment = stage_flags.contains(vk::ShaderStageFlags::FRAGMENT);
    let tesc = stage_flags.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL);
    let tese = stage_flags.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION);
    let geom = stage_flags.contains(vk::ShaderStageFlags::GEOMETRY);

    // The vertex stage only forwards the quadrant id when a later stage is the reader,
    // and the name it forwards under depends on which stage that is.
    let (vert_name, frag_name) = if tesc || tese {
        ("vert_passthrough_tsc", "frag_passthrough")
    } else if geom {
        ("vert_passthrough_geo", "frag_passthrough")
    } else {
        match (vertex, fragment) {
            (true, true) => ("vert_contrib", "frag_contrib"),
            (true, false) => ("vert", "frag_passthrough"),
            (false, true) => ("vert_passthrough", "frag"),
            (false, false) => ("vert_passthrough", "frag_no_access"),
        }
    };

    let mut owned = Vec::new();
    let vert = create_shader_module(device, programs.get(vert_name)?)?;
    let frag = create_shader_module(device, programs.get(frag_name)?)?;
    let mut stages = GraphicsPipelineStages {
        vertex: *vert,
        fragment: *frag,
        tessellation_control: None,
        tessellation_evaluation: None,
        geometry: None,
    };
    owned.push(vert);
    owned.push(frag);

    if tesc || tese {
        // Both tessellation shaders always exist; the one that is not reading forwards.
        let c = create_shader_module(device, programs.get(if tesc { "tesc" } else { "tesc_passthrough" })?)?;
        let e = create_shader_module(device, programs.get(if tese { "tese" } else { "tese_passthrough" })?)?;
        stages.tessellation_control = Some(*c);
        stages.tessellation_evaluation = Some(*e);
        owned.push(c);
        owned.push(e);
    }
    if geom {
        let g = create_shader_module(device, programs.get("geom")?)?;
        stages.geometry = Some(*g);
        owned.push(g);
    }

    Ok((owned, stages))
}

/// `drawQuadrantReferenceResult` + `bilinearCompare` - build the reference from the
/// four expected colours and compare, tolerating the pixel of slack a rasteriser is
/// allowed at the quadrant boundaries.
fn compare_quadrant_image(pixels: &[u8], quadrants: [[f32; 4]; 4]) -> TestStatus {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let mut reference = vec![0u8; (RENDER_SIZE * RENDER_SIZE * 4) as usize];
    {
        let mut access = PixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], &mut reference);
        let half = RENDER_SIZE / 2;
        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                let colour = match (x < half, y < half) {
                    (true, true) => quadrants[0],
                    (false, true) => quadrants[1],
                    (true, false) => quadrants[2],
                    (false, false) => quadrants[3],
                };
                access.set_pixel(colour, x, y, 0);
            }
        }
    }
    let reference_access = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], &reference);
    let result_access = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], pixels);
    if bilinear_compare(&reference_access, &result_access, None, [1, 1, 1, 1]) {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Image verification failed")
    }
}

/// `SingleCmdRenderInstance::createPipeline` - no vertex input at all; the vertex
/// shader derives its position from `gl_VertexIndex`.
fn make_quadrant_pipeline(
    device: &Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: GraphicsPipelineStages,
) -> Result<Unique<'_, vk::Pipeline>, TestError> {
    // A tessellated pipeline takes patches; everything else takes triangles.
    let topology = if stages.tessellation_control.is_some() {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_LIST
    };
    crate::vk::obj_util::make_graphics_pipeline_staged(
        device,
        pipeline_layout,
        stages,
        render_pass,
        (RENDER_SIZE, RENDER_SIZE),
        topology,
        vk::SampleCountFlags::_1,
        None,
        1,
        None,
        None,
    )
}

pub struct BufferAccessCase {
    name: String,
    update_method: DescriptorUpdateMethod,
    resource_kind: ResourceKind,
    descriptor_type: vk::DescriptorType,
    descriptor_set_count: DescriptorSetCount,
    shader_interface: ShaderInputInterface,
    /// `viewOffset` - offset the descriptor's view into the buffer.
    set_view_offset: bool,
    /// `dynamicOffset` - a dynamic descriptor type takes an offset at bind time.
    set_dynamic_offset: bool,
    /// `dynamicOffsetNonZero` - and that offset is not zero.
    dynamic_offset_non_zero: bool,
    /// `m_stageFlags` - which shader stages read the descriptor. `COMPUTE` takes the
    /// dispatch path; anything else renders four quadrants and reads the image back.
    /// Empty is upstream's `no_access`: the descriptors are bound and never read.
    stage_flags: vk::ShaderStageFlags,
    /// `isPrimaryCmdBuf` - false records the draw into a secondary command buffer and
    /// executes it from inside the render pass. Graphics only; there is no secondary
    /// variant of the dispatch path.
    is_primary_cmd_buf: bool,
    /// `bind2` - bind through `vkCmdBindDescriptorSets2` instead.
    bind2: bool,
}

impl BufferAccessCase {
    /// The compute path writes its answers to a result buffer; the graphics path has
    /// none, which shifts every other binding down by one.
    fn is_compute(&self) -> bool {
        self.stage_flags == vk::ShaderStageFlags::COMPUTE
    }

    fn program(&self) -> &'static BufferAccessProgram {
        let storage_type = if is_uniform_descriptor_type(self.descriptor_type) { "uniform" } else { "buffer" };
        let prefix = match self.resource_kind {
            ResourceKind::Buffer => "buffer_",
            ResourceKind::TexelBuffer => "texel_",
        };
        ALL_BUFFER_ACCESS_PROGRAM
            .iter()
            .copied()
            .filter(|p| p.name.starts_with(prefix))
            .find(|p| p.storage_type == storage_type && p.set_count == self.descriptor_set_count.manifest_name() && p.shader_interface == self.shader_interface.manifest_name())
            .expect("the generator covers every combination")
    }
}

impl TestCase for BufferAccessCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        verify_update_method_support(context, self.update_method)?;
        check_stage_support(context, self.stage_flags, self.bind2)?;

        // Two sets plus the gap the discontiguous variant leaves.
        let required_sets = match self.descriptor_set_count {
            DescriptorSetCount::Single => 1,
            DescriptorSetCount::Multiple => 2,
            DescriptorSetCount::MultipleDiscontiguous => 3,
        };
        let limits = context.get_device_properties().limits;
        if limits.max_bound_descriptor_sets < required_sets {
            return Err(TestError::NotSupported(format!("maxBoundDescriptorSets is {}", limits.max_bound_descriptor_sets)));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferAccessInstance { context, params: self })
    }
}

struct BufferAccessInstance<'a> {
    context: &'a Context<'a>,
    params: &'a BufferAccessCase,
}

impl TestInstance for BufferAccessInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        if !self.params.is_compute() {
            return self.run_graphics();
        }
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        let is_dynamic = is_dynamic_descriptor_type(p.descriptor_type);
        let num_sets = p.descriptor_set_count.count();
        let num_resources = p.shader_interface.num_resources();
        let num_src_buffers = num_sets * num_resources;

        // One source buffer per descriptor. A texel buffer's is a generated pattern
        // read through a `VkBufferView`; a plain buffer's is two colours at an offset.
        let mut bind_time_offsets = Vec::new();
        let mut view_offsets = Vec::new();
        let mut buffers = Vec::new();
        let mut buffer_views = Vec::new();
        let mut texel_sources = Vec::new();
        let mut texel_view_offset_texels = 0u32;

        if p.resource_kind == ResourceKind::TexelBuffer {
            let view_offset = self.texel_view_offset()?;
            texel_view_offset_texels = view_offset / 4;

            for buffer_ndx in 0..num_src_buffers {
                let source = populate_texel_source(buffer_ndx);
                let usage = if is_uniform_descriptor_type(p.descriptor_type) {
                    vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
                } else {
                    vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
                };
                let buffer = BufferWithMemory::new(device, allocator, make_buffer_create_info(TEXEL_BUFFER_SIZE as u64, usage), MemoryRequirement::HOST_VISIBLE)?;
                unsafe { std::ptr::copy_nonoverlapping(source.as_ptr(), buffer.get_allocation().get_host_ptr(), source.len()) };
                flush_alloc(device, buffer.get_allocation())?;

                let info = vk::BufferViewCreateInfo::builder()
                    .buffer(buffer.get())
                    .format(vk::Format::R8G8B8A8_UNORM)
                    .offset(u64::from(view_offset))
                    .range(u64::from(TEXEL_VIEW_DATA_SIZE));
                let view = unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?;

                buffer_views.push(Unique::new(device, view));
                buffers.push(buffer);
                texel_sources.push(source);
            }
        }

        for buffer_ndx in 0..(if p.resource_kind == ResourceKind::Buffer { num_src_buffers } else { 0 }) {
            let parity = (buffer_ndx % 2) as usize;
            let bind_time_offset = if p.dynamic_offset_non_zero {
                [DYNAMIC_OFFSET_VALUE_A, DYNAMIC_OFFSET_VALUE_B][parity]
            } else {
                0
            };
            let static_offset = if p.set_view_offset { [STATIC_OFFSET_VALUE_A, STATIC_OFFSET_VALUE_B][parity] } else { 0 };
            let data_offset = if is_dynamic { bind_time_offset } else { 0 } + static_offset;
            let buffer_size = data_offset + ADDRESSABLE_SIZE;

            let buffer = self.create_color_data_buffer(
                data_offset,
                buffer_size,
                COLORS[((buffer_ndx * 2) % 4) as usize],
                COLORS[((buffer_ndx * 2 + 1) % 4) as usize],
            )?;

            bind_time_offsets.push(bind_time_offset);
            view_offsets.push(static_offset);
            buffers.push(buffer);
        }

        // `ComputeInstanceResultBuffer` - cleared to -1 so "never written" is
        // distinguishable from "written with the wrong value".
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(RESULT_DATA_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let ptr = result_buffer.get_allocation().get_host_ptr().cast::<f32>();
            for i in 0..(RESULT_DATA_SIZE as usize / 4) {
                ptr.add(i).write(-1.0);
            }
        }
        flush_alloc(device, result_buffer.get_allocation())?;

        // A push case allocates no sets: its layout carries the push flag, which makes
        // it invalid to allocate from.
        let is_push = p.update_method.is_push();
        let pool = (!is_push).then(|| self.create_descriptor_pool()).transpose()?;
        let mut set_layouts = Vec::new();
        let mut layout_handles = Vec::new();
        let mut sets = Vec::new();

        for set_ndx in 0..num_sets {
            let layout = self.create_descriptor_set_layout(set_ndx)?;

            // A push case has no set and writes from inside the command buffer, so
            // nothing is written here.
            if let Some(pool) = &pool {
                let set = make_descriptor_set(device, **pool, *layout)?;
                self.write_descriptors(
                    DescriptorTarget::Set { set: *set, layout: *layout },
                    *layout,
                    vk::PipelineLayout::null(),
                    set_ndx,
                    &buffers,
                    &buffer_views,
                    &view_offsets,
                    result_buffer.get(),
                )?;
                sets.push(set);
            }

            layout_handles.push(*layout);
            set_layouts.push(layout);

            // A filler layout occupies the gap between sets 0 and 2. Upstream picks
            // its contents from a hash of the descriptor type, so it is sometimes
            // empty and sometimes holds one unrelated binding; nothing reads it, and
            // what matters is only that set 1 exists so set 2 can be bound.
            if set_ndx == 0 && p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                let unused = create_unused_layout(device, crate::tcu::random::de_int32_hash(p.descriptor_type.as_raw()) ^ crate::tcu::random::de_int32_hash(0))?;
                layout_handles.push(*unused);
                set_layouts.push(unused);
            }
        }

        let pipeline_layout = make_pipeline_layout(device, &layout_handles)?;
        let module = create_shader_module(device, p.program().programs.get("compute")?)?;
        let pipeline = self.create_compute_pipeline(*pipeline_layout, *module)?;

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let set_handles: Vec<vk::DescriptorSet> = sets.iter().map(|s| **s).collect();
        let dynamic_offsets: Vec<u32> = if p.set_dynamic_offset { bind_time_offsets.clone() } else { Vec::new() };

        // Outlives the submit below, which is when the recorded pushes actually run.
        let mut pushed_templates = Vec::new();

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let barriers: Vec<vk::BufferMemoryBarrier> = buffers
                .iter()
                .map(|b| {
                    vk::BufferMemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::HOST_WRITE)
                        .dst_access_mask(if is_uniform_descriptor_type(p.descriptor_type) {
                            vk::AccessFlags::UNIFORM_READ
                        } else {
                            vk::AccessFlags::SHADER_READ
                        })
                        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .buffer(b.get())
                        .offset(0)
                        .size(vk::WHOLE_SIZE)
                        .build()
                })
                .collect();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &barriers,
                &[] as &[vk::ImageMemoryBarrier],
            );

            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);

            // A push case has no set to bind: the descriptors go into the command
            // buffer here instead, and the dynamic types are excluded from the push
            // methods entirely so there are never any offsets to hand over.
            if is_push {
                for set_ndx in 0..num_sets {
                    pushed_templates.extend(self.write_descriptors(
                        DescriptorTarget::Push {
                            cmd: *command_buffer,
                            bind_point: vk::PipelineBindPoint::COMPUTE,
                            layout: *pipeline_layout,
                            set_ndx: p.descriptor_set_count.set_ndx(set_ndx),
                        },
                        *set_layouts[set_ndx as usize],
                        *pipeline_layout,
                        set_ndx,
                        &buffers,
                        &buffer_views,
                        &view_offsets,
                        result_buffer.get(),
                    )?);
                }
            }

            // The contiguous arrangements bind every set in one call from index 0. The
            // discontiguous one cannot: its sets are 0 and 2, so each binds at its own
            // index, and the dynamic offsets have to be sliced to match rather than
            // handed over whole.
            if is_push {
                // Already pushed above; there is no set to bind.
            } else if p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                let mut dynamic_offset_ndx = 0usize;
                for set_ndx in 0..num_sets {
                    let offsets: &[u32] = if p.set_dynamic_offset {
                        &dynamic_offsets[dynamic_offset_ndx..dynamic_offset_ndx + num_resources as usize]
                    } else {
                        &[]
                    };
                    device.cmd_bind_descriptor_sets(
                        *command_buffer,
                        vk::PipelineBindPoint::COMPUTE,
                        *pipeline_layout,
                        p.descriptor_set_count.set_ndx(set_ndx),
                        &set_handles[set_ndx as usize..set_ndx as usize + 1],
                        offsets,
                    );
                    dynamic_offset_ndx += num_resources as usize;
                }
            } else {
                device.cmd_bind_descriptor_sets(*command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline_layout, 0, &set_handles, &dynamic_offsets);
            }

            device.cmd_dispatch(*command_buffer, 4, 1, 1);

            let post = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(result_buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[post],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let mut results = [[0.0f32; 4]; 4];
        unsafe {
            let ptr = result_buffer.get_allocation().get_host_ptr().cast::<f32>();
            for (i, quadrant) in results.iter_mut().enumerate() {
                for (c, value) in quadrant.iter_mut().enumerate() {
                    *value = ptr.add(i * 4 + c).read();
                }
            }
        }

        if p.resource_kind == ResourceKind::TexelBuffer {
            // Each quadrant fetches its own sample point, alternating between the two
            // descriptors, so all four references differ.
            let mut references = [[0.0f32; 4]; 4];
            for (quadrant, reference) in references.iter_mut().enumerate() {
                for set_ndx in 0..num_sets {
                    let value = fetch_texel_value(&texel_sources, num_resources, texel_view_offset_texels, quadrant, set_ndx);
                    for (r, v) in reference.iter_mut().zip(value) {
                        *r += v;
                    }
                }
                for r in reference.iter_mut() {
                    *r /= num_sets as f32;
                }
            }

            // Unlike the plain buffer case, the comparison is not exact: the value
            // went through a UNORM8 conversion in the driver, and a driver that
            // multiplies by 1/255 rather than dividing by 255 lands one ulp away.
            // Upstream allows a whole quantisation step.
            const CONVERSION_THRESHOLD: f32 = 1.0 / 255.0;
            let any_result_set = results.iter().any(|q| *q != [-1.0f32; 4]);
            let all_ok = results
                .iter()
                .zip(&references)
                .all(|(result, reference)| result.iter().zip(reference).all(|(r, e)| (r - e).abs() <= CONVERSION_THRESHOLD));

            if !any_result_set {
                return Ok(TestStatus::fail("Result buffer was not written to"));
            }
            if all_ok {
                return Ok(TestStatus::pass("Pass"));
            }
            return Ok(TestStatus::fail("Invalid result values"));
        }

        // Quadrants 1 and 2 read colorA, 0 and 3 read colorB; with two sets the shader
        // averages what it found in each.
        let mut ref_14 = [0.0f32; 4];
        let mut ref_23 = [0.0f32; 4];
        for set_ndx in 0..num_sets {
            let offset = if p.shader_interface == ShaderInputInterface::SingleDescriptor { 1 } else { 3 };
            let a = COLORS[((2 * set_ndx * num_resources + offset) % 4) as usize];
            let b = COLORS[((2 * set_ndx * num_resources) % 4) as usize];
            for c in 0..4 {
                ref_14[c] += a[c];
                ref_23[c] += b[c];
            }
        }
        for c in 0..4 {
            ref_14[c] /= num_sets as f32;
            ref_23[c] /= num_sets as f32;
        }
        let references = [ref_14, ref_23, ref_23, ref_14];

        if results == references {
            return Ok(TestStatus::pass("Pass"));
        }
        if results.iter().all(|q| q.iter().all(|&v| v == -1.0)) {
            return Ok(TestStatus::fail("Result buffer was not written to"));
        }
        Ok(TestStatus::fail("Invalid result values"))
    }
}

impl BufferAccessInstance<'_> {
    /// The source buffers every descriptor points at. Shared with the dispatch path,
    /// which builds the same set before it creates its result buffer.
    #[allow(clippy::type_complexity)]
    fn create_source_resources(
        &self,
        num_src_buffers: u32,
        num_resources: u32,
        is_dynamic: bool,
    ) -> Result<(Vec<BufferWithMemory<'_>>, Vec<Unique<'_, vk::BufferView>>, Vec<u32>, Vec<u32>, Vec<Vec<u8>>, u32), TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let mut buffers = Vec::new();
        let mut buffer_views = Vec::new();
        let mut view_offsets = Vec::new();
        let mut bind_time_offsets = Vec::new();
        let mut texel_sources: Vec<Vec<u8>> = Vec::new();

        if p.resource_kind == ResourceKind::TexelBuffer {
            let view_offset = self.texel_view_offset()?;
            for buffer_ndx in 0..num_src_buffers {
                let source = populate_texel_source(buffer_ndx);
                let usage = if is_uniform_descriptor_type(p.descriptor_type) {
                    vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
                } else {
                    vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
                };
                let buffer = BufferWithMemory::new(device, allocator, make_buffer_create_info(TEXEL_BUFFER_SIZE as u64, usage), MemoryRequirement::HOST_VISIBLE)?;
                unsafe { std::ptr::copy_nonoverlapping(source.as_ptr(), buffer.get_allocation().get_host_ptr(), source.len()) };
                flush_alloc(device, buffer.get_allocation())?;
                let info = vk::BufferViewCreateInfo::builder()
                    .buffer(buffer.get())
                    .format(vk::Format::R8G8B8A8_UNORM)
                    .offset(u64::from(view_offset))
                    .range(u64::from(TEXEL_VIEW_DATA_SIZE));
                let view = unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?;
                buffer_views.push(Unique::new(device, view));
                buffers.push(buffer);
                view_offsets.push(0);
                bind_time_offsets.push(0);
                texel_sources.push(source);
            }
            return Ok((buffers, buffer_views, view_offsets, bind_time_offsets, texel_sources, view_offset / 4));
        }

        for buffer_ndx in 0..num_src_buffers {
            let parity = (buffer_ndx % 2) as usize;
            let bind_time_offset = if p.dynamic_offset_non_zero {
                [DYNAMIC_OFFSET_VALUE_A, DYNAMIC_OFFSET_VALUE_B][parity]
            } else {
                0
            };
            let static_offset = if p.set_view_offset { [STATIC_OFFSET_VALUE_A, STATIC_OFFSET_VALUE_B][parity] } else { 0 };
            let data_offset = if is_dynamic { bind_time_offset } else { 0 } + static_offset;
            let buffer_size = data_offset + ADDRESSABLE_SIZE;
            // `BufferRenderInstance::createSourceBuffer` indexes the colours by the
            // *set*, not by the descriptor, so every buffer in a set holds the same
            // pair. That is what lets the reference be one colour per half whichever
            // descriptor within the set the shader reached.
            let set_ndx = (buffer_ndx / num_resources) as usize;
            let buffer = self.create_color_data_buffer(data_offset, buffer_size, COLORS[2 * (set_ndx % 2)], COLORS[2 * (set_ndx % 2) + 1])?;
            bind_time_offsets.push(bind_time_offset);
            view_offsets.push(static_offset);
            buffers.push(buffer);
        }
        Ok((buffers, buffer_views, view_offsets, bind_time_offsets, texel_sources, 0))
    }

    /// `BufferRenderInstance` / `SingleCmdRenderInstance` - the graphics counterpart of
    /// the dispatch path.
    ///
    /// Instead of four workgroups writing a result buffer, one draw of 24 vertices
    /// covers the target in four quadrants and each fragment ends up the colour of
    /// whichever descriptor its quadrant reached. The answer is therefore the image,
    /// and a wrong binding shows up as a quadrant of the wrong colour.
    fn run_graphics(&self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        let is_dynamic = is_dynamic_descriptor_type(p.descriptor_type);
        let num_sets = p.descriptor_set_count.count();
        let num_resources = p.shader_interface.num_resources();
        let num_src_buffers = num_sets * num_resources;

        let (buffers, buffer_views, view_offsets, bind_time_offsets, texel_sources, texel_view_offset_texels) =
            self.create_source_resources(num_src_buffers, num_resources, is_dynamic)?;

        // A push case allocates no sets at all: its layout is declared for push and the
        // descriptors go into the command buffer at bind time.
        let is_push = p.update_method.is_push();
        let pool = (!is_push).then(|| self.create_descriptor_pool()).transpose()?;
        let mut set_layouts = Vec::new();
        let mut layout_handles = Vec::new();
        let mut sets = Vec::new();
        for set_ndx in 0..num_sets {
            let layout = self.create_descriptor_set_layout(set_ndx)?;
            if let Some(pool) = &pool {
                sets.push(make_descriptor_set(device, **pool, *layout)?);
            }
            layout_handles.push(*layout);
            set_layouts.push(layout);
        }
        let set_handles: Vec<vk::DescriptorSet> = sets.iter().map(|s| **s).collect();

        // The discontiguous arrangement leaves a gap at set 1, and a pipeline layout
        // may not have a hole in it, so an empty layout fills the slot.
        let mut all_layouts = layout_handles.clone();
        let unused = if p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
            let unused = create_unused_layout(device, 0)?;
            all_layouts = vec![layout_handles[0], *unused, layout_handles[1]];
            Some(unused)
        } else {
            None
        };
        let pipeline_layout = make_pipeline_layout(device, &all_layouts)?;

        if !is_push {
            for set_ndx in 0..num_sets {
                self.write_descriptors(
                    DescriptorTarget::Set {
                        set: set_handles[set_ndx as usize],
                        layout: *set_layouts[set_ndx as usize],
                    },
                    *set_layouts[set_ndx as usize],
                    *pipeline_layout,
                    set_ndx,
                    &buffers,
                    &buffer_views,
                    &view_offsets,
                    vk::Buffer::null(),
                )?;
            }
        }

        let (_modules, stages) = graphics_modules(device, &p.program().programs, p.stage_flags)?;
        let dynamic_offsets: Vec<u32> = if p.set_dynamic_offset { bind_time_offsets.clone() } else { Vec::new() };
        // The pushes are recorded into the command buffer, so their templates have to
        // outlive the draw; the cell is only because `bind` is a `Fn`.
        let pushed_templates = std::cell::RefCell::new(Vec::new());
        let bind = |device: &Device, cmd: vk::CommandBuffer| {
            if is_push {
                for set_ndx in 0..num_sets {
                    match self.write_descriptors(
                        DescriptorTarget::Push {
                            cmd,
                            bind_point: vk::PipelineBindPoint::GRAPHICS,
                            layout: *pipeline_layout,
                            set_ndx: p.descriptor_set_count.set_ndx(set_ndx),
                        },
                        *set_layouts[set_ndx as usize],
                        *pipeline_layout,
                        set_ndx,
                        &buffers,
                        &buffer_views,
                        &view_offsets,
                        vk::Buffer::null(),
                    ) {
                        Ok(keep) => pushed_templates.borrow_mut().extend(keep),
                        Err(e) => log::error!("recording a pushed descriptor set failed: {e:?}"),
                    }
                }
                return;
            }
            // The discontiguous arrangement's sets are 0 and 2, so each binds at its
            // own index and its dynamic offsets have to be sliced to match.
            if p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                let mut ndx = 0usize;
                for set_ndx in 0..num_sets {
                    let offsets: &[u32] = if p.set_dynamic_offset {
                        &dynamic_offsets[ndx..ndx + num_resources as usize]
                    } else {
                        &[]
                    };
                    bind_descriptor_sets(
                        device,
                        cmd,
                        p.stage_flags,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout,
                        p.descriptor_set_count.set_ndx(set_ndx),
                        &set_handles[set_ndx as usize..set_ndx as usize + 1],
                        offsets,
                        p.bind2,
                    );
                    ndx += num_resources as usize;
                }
            } else {
                bind_descriptor_sets(
                    device,
                    cmd,
                    p.stage_flags,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &set_handles,
                    &dynamic_offsets,
                    p.bind2,
                );
            }
        };
        let pixels = render_quadrants(device, allocator, queue, queue_index, *pipeline_layout, stages, p.is_primary_cmd_buf, &bind)?;

        drop(unused);
        drop(set_layouts);

        self.verify_rendered_quadrants(&pixels, num_sets, num_resources, &texel_sources, texel_view_offset_texels)
    }

    /// `BufferRenderInstance::verifyResultImage` / `TexelBufferRenderInstance::verifyResultImage`
    fn verify_rendered_quadrants(
        &self,
        pixels: &[u8],
        num_sets: u32,
        num_resources: u32,
        texel_sources: &[Vec<u8>],
        texel_view_offset_texels: u32,
    ) -> Result<TestStatus, TestError> {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let do_fetch = !self.params.stage_flags.is_empty();

        // The two resource kinds disagree on both the colours and the order they land
        // in. A plain buffer holds one pair per set, so two of the four quadrants share
        // a colour; a texel buffer is fetched at a different point per quadrant, so all
        // four differ.
        let quadrants: [[f32; 4]; 4] = if self.params.resource_kind == ResourceKind::TexelBuffer {
            if do_fetch {
                let mut out = [[0.0f32; 4]; 4];
                for (quadrant, sample) in out.iter_mut().enumerate() {
                    for set_ndx in 0..num_sets {
                        let value = fetch_texel_value(texel_sources, num_resources, texel_view_offset_texels, quadrant, set_ndx);
                        for (r, v) in sample.iter_mut().zip(value) {
                            *r += v;
                        }
                    }
                    if num_sets > 1 {
                        for r in sample.iter_mut() {
                            *r /= num_sets as f32;
                        }
                    }
                }
                out
            } else {
                [COLORS[1], COLORS[0], COLORS[0], COLORS[1]]
            }
        } else {
            let (sample0, sample1) = if do_fetch {
                let mut s0 = [0.0f32; 4];
                let mut s1 = [0.0f32; 4];
                for set_ndx in 0..num_sets as usize {
                    for c in 0..4 {
                        s0[c] += COLORS[2 * (set_ndx % 2)][c];
                        s1[c] += COLORS[2 * (set_ndx % 2) + 1][c];
                    }
                }
                if num_sets > 1 {
                    for c in 0..4 {
                        s0[c] /= num_sets as f32;
                        s1[c] /= num_sets as f32;
                    }
                }
                (s0, s1)
            } else {
                (COLORS[0], COLORS[1])
            };
            // `drawQuadrantReferenceResult(dst, sample1, sample0, sample0, sample1)`
            [sample1, sample0, sample0, sample1]
        };

        let mut reference = vec![0u8; (RENDER_SIZE * RENDER_SIZE * 4) as usize];
        {
            let mut access = PixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], &mut reference);
            let half = RENDER_SIZE / 2;
            for y in 0..RENDER_SIZE {
                for x in 0..RENDER_SIZE {
                    let colour = match (x < half, y < half) {
                        (true, true) => quadrants[0],
                        (false, true) => quadrants[1],
                        (true, false) => quadrants[2],
                        (false, false) => quadrants[3],
                    };
                    access.set_pixel(colour, x, y, 0);
                }
            }
        }

        let reference_access = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], &reference);
        let result_access = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], pixels);
        if bilinear_compare(&reference_access, &result_access, None, [1, 1, 1, 1]) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
        }
    }

    /// The descriptor writes for one set, however this case delivers them. A push case
    /// calls this from inside the command buffer recording; every other case calls it
    /// once during setup.
    #[allow(clippy::too_many_arguments)]
    fn write_descriptors(
        &self,
        target: DescriptorTarget,
        layout: vk::DescriptorSetLayout,
        pipeline_layout: vk::PipelineLayout,
        set_ndx: u32,
        buffers: &[BufferWithMemory<'_>],
        buffer_views: &[Unique<'_, vk::BufferView>],
        view_offsets: &[u32],
        result: vk::Buffer,
    ) -> Result<Option<TemplateKeepAlive<'_>>, TestError> {
        let p = self.params;
        let num_resources = p.shader_interface.num_resources();
        let num_src_buffers = p.descriptor_set_count.count() * num_resources;
        let ndx0 = ((set_ndx * num_resources) % num_src_buffers) as usize;
        let ndx1 = ((set_ndx * num_resources + 1) % num_src_buffers) as usize;

        Ok(match (p.resource_kind, p.update_method.uses_template()) {
            (ResourceKind::Buffer, false) => {
                self.write_descriptor_set(target, set_ndx, buffers[ndx0].get(), view_offsets[ndx0], buffers[ndx1].get(), view_offsets[ndx1], result);
                None
            }
            (ResourceKind::Buffer, true) => self.write_descriptor_set_with_template(
                target,
                layout,
                pipeline_layout,
                set_ndx,
                buffers[ndx0].get(),
                view_offsets[ndx0],
                buffers[ndx1].get(),
                view_offsets[ndx1],
                result,
            )?,
            (ResourceKind::TexelBuffer, false) => {
                self.write_texel_descriptor_set(target, set_ndx, *buffer_views[ndx0], *buffer_views[ndx1], result);
                None
            }
            (ResourceKind::TexelBuffer, true) => {
                self.write_texel_descriptor_set_with_template(target, layout, pipeline_layout, set_ndx, *buffer_views[ndx0], *buffer_views[ndx1], result)?
            }
        })
    }

    /// `createColorDataBuffer` - two colours at `offset`, in a deliberately larger
    /// allocation so a wrong offset reads defined-but-wrong data rather than faulting.
    fn create_color_data_buffer(&self, offset: u32, buffer_size: u32, value1: [f32; 4], value2: [f32; 4]) -> Result<BufferWithMemory<'_>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let usage = if is_uniform_descriptor_type(self.params.descriptor_type) {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };

        let buffer = BufferWithMemory::new(device, allocator, make_buffer_create_info(u64::from(buffer_size), usage), MemoryRequirement::HOST_VISIBLE)?;
        unsafe {
            let base = buffer.get_allocation().get_host_ptr();
            std::ptr::write_bytes(base, 0x5A, buffer_size as usize);
            let at = base.add(offset as usize).cast::<f32>();
            for (i, v) in value1.iter().chain(value2.iter()).enumerate() {
                at.add(i).write(*v);
            }
        }
        flush_alloc(device, buffer.get_allocation())?;
        Ok(buffer)
    }

    /// `createDescriptorSetLayout`
    fn create_descriptor_set_layout(&self, set_ndx: u32) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        let p = self.params;
        let mut builder = DescriptorSetLayoutBuilder::new();
        let mut binding = 0;

        // The result buffer lives in set 0 only, and only on the compute path.
        if set_ndx == 0 && p.is_compute() {
            builder = builder.add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE, binding, 1);
            binding += 1;
        }

        // `m_stageFlags` - empty for the `no_access` cases, which is legal and is the
        // point: the descriptors are bound but no stage may read them.
        let stages = p.stage_flags;
        builder = match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => builder.add_indexed_binding(p.descriptor_type, stages, binding, 1),
            ShaderInputInterface::MultipleContiguousDescriptors => {
                builder
                    .add_indexed_binding(p.descriptor_type, stages, binding, 1)
                    .add_indexed_binding(p.descriptor_type, stages, binding + 1, 1)
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                builder
                    .add_indexed_binding(p.descriptor_type, stages, binding, 1)
                    .add_indexed_binding(p.descriptor_type, stages, binding + 2, 1)
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                builder
                    .add_indexed_binding(p.descriptor_type, stages, arbitrary_binding_index(0), 1)
                    .add_indexed_binding(p.descriptor_type, stages, arbitrary_binding_index(1), 1)
            }
            ShaderInputInterface::DescriptorArray => builder.add_indexed_binding(p.descriptor_type, stages, binding, 2),
        };

        // `VK_DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR` - a push layout is
        // never allocated from, so the flag is load-bearing rather than advisory.
        let flags = if p.update_method.is_push() {
            vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR
        } else {
            vk::DescriptorSetLayoutCreateFlags::empty()
        };
        builder.build_with_flags(self.context.get_device(), flags)
    }

    /// `createDescriptorPool`
    fn create_descriptor_pool(&self) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        let p = self.params;
        let num = p.descriptor_set_count.count() * p.shader_interface.num_resources();
        DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(p.descriptor_type, num)
            .build(
                self.context.get_device(),
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                p.descriptor_set_count.count(),
            )
    }

    /// `writeDescriptorSet`
    #[allow(clippy::too_many_arguments)]
    fn write_descriptor_set(&self, target: DescriptorTarget, set_ndx: u32, view_a: vk::Buffer, offset_a: u32, view_b: vk::Buffer, offset_b: u32, result: vk::Buffer) {
        let set = target.set();
        let p = self.params;
        let device = self.context.get_device();
        let range = std::mem::size_of::<[f32; 8]>() as u64;

        let result_info = [vk::DescriptorBufferInfo {
            buffer: result,
            offset: 0,
            range: RESULT_DATA_SIZE,
        }];
        let buffer_infos = [
            vk::DescriptorBufferInfo {
                buffer: view_a,
                offset: u64::from(offset_a),
                range,
            },
            vk::DescriptorBufferInfo {
                buffer: view_b,
                offset: u64::from(offset_b),
                range,
            },
        ];

        let mut writes = Vec::new();
        let mut binding = 0;

        if set_ndx == 0 && p.is_compute() {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(set)
                    .dst_binding(binding)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&result_info)
                    .build(),
            );
            binding += 1;
        }

        let single = |dst_binding: u32, info: &[vk::DescriptorBufferInfo]| {
            vk::WriteDescriptorSet::builder()
                .dst_set(set)
                .dst_binding(dst_binding)
                .descriptor_type(p.descriptor_type)
                .buffer_info(info)
                .build()
        };

        match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => writes.push(single(binding, &buffer_infos[0..1])),
            ShaderInputInterface::MultipleContiguousDescriptors => {
                writes.push(single(binding, &buffer_infos[0..1]));
                writes.push(single(binding + 1, &buffer_infos[1..2]));
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                writes.push(single(binding, &buffer_infos[0..1]));
                writes.push(single(binding + 2, &buffer_infos[1..2]));
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                writes.push(single(arbitrary_binding_index(0), &buffer_infos[0..1]));
                writes.push(single(arbitrary_binding_index(1), &buffer_infos[1..2]));
            }
            ShaderInputInterface::DescriptorArray => writes.push(single(binding, &buffer_infos)),
        }

        target.apply(device, &writes);
    }

    fn create_compute_pipeline(&self, layout: vk::PipelineLayout, module: vk::ShaderModule) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let entry = c"main";
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build();
        let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(layout);
        let pipeline = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0];
        Ok(Unique::new(device, pipeline))
    }
}

/// The descriptor set arrangements, and the group each gets. The single-set one has
/// no group of its own; its interfaces sit directly under the stage.
const SET_COUNTS: [(&str, DescriptorSetCount); 3] = [
    ("", DescriptorSetCount::Single),
    ("multiple_descriptor_sets", DescriptorSetCount::Multiple),
    ("multiple_discontiguous_descriptor_sets", DescriptorSetCount::MultipleDiscontiguous),
];

const INTERFACES: [ShaderInputInterface; 5] = [
    ShaderInputInterface::SingleDescriptor,
    ShaderInputInterface::MultipleContiguousDescriptors,
    ShaderInputInterface::MultipleDiscontiguousDescriptors,
    ShaderInputInterface::MultipleArbitraryDescriptors,
    ShaderInputInterface::DescriptorArray,
];

/// `createShaderAccessTests`.
///
/// The group tree upstream builds is `<cmd buffer>.<bind command>.[<update method>.]
/// <descriptor type>.<stage>.<descriptor arrangement>`. The `bind2` command and the
/// push-descriptor update methods are not registered here; the rest is.
///
/// `secondary_cmd_buf` mirrors the primary tree with the draw recorded into a secondary
/// command buffer, so it has no compute cases at all.
pub fn create_shader_access_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_access");

    for is_primary in [true, false] {
        let mut cmd_group = TestCaseGroup::new(if is_primary { "primary_cmd_buf" } else { "secondary_cmd_buf" });

        for bind2 in [false, true] {
            let mut bind = TestCaseGroup::new(if bind2 { "bind2" } else { "bind" });

            for update_method in [
                DescriptorUpdateMethod::Normal,
                DescriptorUpdateMethod::WithTemplate,
                DescriptorUpdateMethod::WithPush,
                DescriptorUpdateMethod::WithPushTemplate,
            ] {
                let mut method_group = update_method.group_name().map(TestCaseGroup::new);
                for type_group in create_descriptor_type_groups(update_method, is_primary, bind2) {
                    if let Some(g) = method_group.as_mut() {
                        g.add_child(type_group);
                    } else {
                        bind.add_child(type_group);
                    }
                }
                if let Some(g) = method_group {
                    bind.add_child(g);
                }
            }

            cmd_group.add_child(bind);
        }

        group.add_child(cmd_group);
    }

    group
}

/// One group per descriptor type, in upstream's order - which puts the image types
/// before the buffer ones.
fn create_descriptor_type_groups(update_method: DescriptorUpdateMethod, is_primary: bool, bind2: bool) -> Vec<TestCaseGroup> {
    let mut groups = vec![
        create_image_group(update_method, is_primary, bind2, "sampler_mutable", vk::DescriptorType::SAMPLER, false),
        create_image_group(update_method, is_primary, bind2, "sampler_immutable", vk::DescriptorType::SAMPLER, true),
        create_image_group(
            update_method,
            is_primary,
            bind2,
            "combined_image_sampler_mutable",
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            false,
        ),
        create_image_group(
            update_method,
            is_primary,
            bind2,
            "combined_image_sampler_immutable",
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            true,
        ),
        create_image_group(update_method, is_primary, bind2, "storage_image", vk::DescriptorType::STORAGE_IMAGE, false),
    ];

    let descriptor_types = [
        ("uniform_buffer", vk::DescriptorType::UNIFORM_BUFFER, ResourceKind::Buffer),
        ("storage_buffer", vk::DescriptorType::STORAGE_BUFFER, ResourceKind::Buffer),
        ("uniform_texel_buffer", vk::DescriptorType::UNIFORM_TEXEL_BUFFER, ResourceKind::TexelBuffer),
        ("storage_texel_buffer", vk::DescriptorType::STORAGE_TEXEL_BUFFER, ResourceKind::TexelBuffer),
        ("uniform_buffer_dynamic", vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, ResourceKind::Buffer),
        ("storage_buffer_dynamic", vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, ResourceKind::Buffer),
    ];

    for (type_name, descriptor_type, resource_kind) in descriptor_types {
        let is_dynamic = is_dynamic_descriptor_type(descriptor_type);
        let mut type_group = TestCaseGroup::new(type_name);

        // "Can't support push descriptor sets with dynamic UBOs or SSBOs" - upstream
        // drops the whole descriptor type rather than the individual cases.
        if is_dynamic && update_method.is_push() {
            continue;
        }

        for (stage_name, stage_flags) in SHADER_STAGES {
            // There is no secondary variant of the dispatch path.
            if !is_primary && stage_flags == vk::ShaderStageFlags::COMPUTE {
                continue;
            }
            let mut stage_group = TestCaseGroup::new(stage_name);

            for (set_group_name, descriptor_set_count) in SET_COUNTS {
                // Only one descriptor set layout may carry the push flag, so a push
                // case has no multiple-set arrangements at all.
                if update_method.is_push() && descriptor_set_count != DescriptorSetCount::Single {
                    continue;
                }
                // The single-set arrangement has no group of its own; its interfaces sit
                // directly under the stage.
                let mut set_group = (!set_group_name.is_empty()).then(|| TestCaseGroup::new(set_group_name));

                for shader_interface in INTERFACES {
                    let mut interface_group = TestCaseGroup::new(shader_interface.case_name());

                    for set_view_offset in [false, true] {
                        // The texel buffer cases drop the "view" from the name: their
                        // offset is on the buffer view rather than on the descriptor.
                        let offset_name = match (resource_kind, set_view_offset) {
                            (ResourceKind::TexelBuffer, false) => "offset_zero",
                            (ResourceKind::TexelBuffer, true) => "offset_nonzero",
                            (ResourceKind::Buffer, false) => "offset_view_zero",
                            (ResourceKind::Buffer, true) => "offset_view_nonzero",
                        };

                        if is_dynamic {
                            for dynamic_offset_non_zero in [false, true] {
                                let dynamic_name = if dynamic_offset_non_zero { "dynamic_nonzero" } else { "dynamic_zero" };
                                interface_group.add_child(Box::new(BufferAccessCase {
                                    name: format!("{offset_name}_{dynamic_name}"),
                                    update_method,
                                    resource_kind,
                                    descriptor_type,
                                    descriptor_set_count,
                                    shader_interface,
                                    set_view_offset,
                                    set_dynamic_offset: true,
                                    dynamic_offset_non_zero,
                                    stage_flags,
                                    is_primary_cmd_buf: is_primary,
                                    bind2,
                                }) as Box<dyn TestCase>);
                            }
                        } else {
                            interface_group.add_child(Box::new(BufferAccessCase {
                                name: offset_name.to_string(),
                                update_method,
                                resource_kind,
                                descriptor_type,
                                descriptor_set_count,
                                shader_interface,
                                set_view_offset,
                                set_dynamic_offset: false,
                                dynamic_offset_non_zero: false,
                                stage_flags,
                                is_primary_cmd_buf: is_primary,
                                bind2,
                            }) as Box<dyn TestCase>);
                        }
                    }

                    if let Some(g) = set_group.as_mut() {
                        g.add_child(interface_group);
                    } else {
                        stage_group.add_child(interface_group);
                    }
                }

                if let Some(g) = set_group {
                    stage_group.add_child(g);
                }
            }

            type_group.add_child(stage_group);
        }
        groups.push(type_group);
    }

    groups
}

/// The stage configurations upstream registers, in its order. `no_access` binds the
/// descriptors and reads none of them, which checks that merely binding a descriptor
/// does not disturb the pipeline.
const SHADER_STAGES: [(&str, vk::ShaderStageFlags); 8] = [
    ("no_access", vk::ShaderStageFlags::empty()),
    ("compute", vk::ShaderStageFlags::COMPUTE),
    ("vertex", vk::ShaderStageFlags::VERTEX),
    ("tess_ctrl", vk::ShaderStageFlags::TESSELLATION_CONTROL),
    ("tess_eval", vk::ShaderStageFlags::TESSELLATION_EVALUATION),
    ("geometry", vk::ShaderStageFlags::GEOMETRY),
    ("fragment", vk::ShaderStageFlags::FRAGMENT),
    (
        "vertex_fragment",
        vk::ShaderStageFlags::from_bits_truncate(vk::ShaderStageFlags::VERTEX.bits() | vk::ShaderStageFlags::FRAGMENT.bits()),
    ),
];

/// `existingStages` - the stages the pipeline has, as opposed to the ones that read a
/// descriptor. `vkCmdBindDescriptorSets2` names these rather than the active ones.
fn existing_stages(active: vk::ShaderStageFlags) -> vk::ShaderStageFlags {
    if active == vk::ShaderStageFlags::COMPUTE {
        return vk::ShaderStageFlags::COMPUTE;
    }
    let mut stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
    if active.intersects(vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
        stages |= vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION;
    }
    if active.contains(vk::ShaderStageFlags::GEOMETRY) {
        stages |= vk::ShaderStageFlags::GEOMETRY;
    }
    stages
}

/// `bindDescriptorSets` - `bind2` routes the same arguments through
/// `vkCmdBindDescriptorSets2`, which takes them in a struct and names the stages the
/// pipeline has rather than the ones that read.
#[allow(clippy::too_many_arguments)]
fn bind_descriptor_sets(
    device: &Device,
    cmd: vk::CommandBuffer,
    active_stages: vk::ShaderStageFlags,
    bind_point: vk::PipelineBindPoint,
    layout: vk::PipelineLayout,
    first: u32,
    sets: &[vk::DescriptorSet],
    dynamic_offsets: &[u32],
    bind2: bool,
) {
    if bind2 {
        use vulkanalia::vk::KhrMaintenance6ExtensionDeviceCommands;
        let info = vk::BindDescriptorSetsInfo {
            s_type: vk::StructureType::BIND_DESCRIPTOR_SETS_INFO,
            next: std::ptr::null(),
            stage_flags: existing_stages(active_stages),
            layout,
            first_set: first,
            descriptor_set_count: sets.len() as u32,
            descriptor_sets: sets.as_ptr(),
            dynamic_offset_count: dynamic_offsets.len() as u32,
            dynamic_offsets: dynamic_offsets.as_ptr(),
        };
        unsafe { device.cmd_bind_descriptor_sets2_khr(cmd, &info) };
    } else {
        unsafe { device.cmd_bind_descriptor_sets(cmd, bind_point, layout, first, sets, dynamic_offsets) };
    }
}

/// `createShaderAccessImageTests`, compute stage. The view type is the innermost
/// level of the tree here, where the buffer types put their offset variants.
fn create_image_group(
    update_method: DescriptorUpdateMethod,
    is_primary: bool,
    bind2: bool,
    group_name: &str,
    descriptor_type: vk::DescriptorType,
    is_immutable_sampler: bool,
) -> TestCaseGroup {
    let mut type_group = TestCaseGroup::new(group_name);

    for (stage_name, stage_flags) in SHADER_STAGES {
        if !is_primary && stage_flags == vk::ShaderStageFlags::COMPUTE {
            continue;
        }
        let mut stage_group = TestCaseGroup::new(stage_name);

        for (set_group_name, descriptor_set_count) in SET_COUNTS {
            // Only one descriptor set layout may carry the push flag.
            if update_method.is_push() && descriptor_set_count != DescriptorSetCount::Single {
                continue;
            }
            let mut set_group = (!set_group_name.is_empty()).then(|| TestCaseGroup::new(set_group_name));

            for shader_interface in INTERFACES {
                let mut interface_group = TestCaseGroup::new(shader_interface.case_name());

                for (name, view_type, base_mip_level, base_array_slice) in IMAGE_TYPES {
                    if !image_case_exists(
                        view_type,
                        descriptor_set_count,
                        shader_interface,
                        descriptor_type,
                        stage_flags == vk::ShaderStageFlags::COMPUTE,
                    ) {
                        continue;
                    }
                    interface_group.add_child(Box::new(ImageAccessCase {
                        name,
                        update_method,
                        descriptor_type,
                        descriptor_set_count,
                        shader_interface,
                        view_type,
                        base_mip_level,
                        base_array_slice,
                        is_immutable_sampler,
                        stage_flags,
                        is_primary_cmd_buf: is_primary,
                        bind2,
                    }) as Box<dyn TestCase>);
                }

                if let Some(g) = set_group.as_mut() {
                    g.add_child(interface_group);
                } else {
                    stage_group.add_child(interface_group);
                }
            }

            if let Some(g) = set_group {
                stage_group.add_child(g);
            }
        }

        type_group.add_child(stage_group);
    }
    type_group
}

/// `createUnusedLayout` - the filler that keeps the set indices apart. Its contents
/// come from a seeded draw, so it is empty most of the time and otherwise holds a
/// single binding of a type nothing in the shader refers to.
fn create_unused_layout(device: &Device, hash: u32) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
    let mut random = crate::tcu::random::Random::new(hash);
    let r = random.get_uint32() % 10;
    let mut builder = DescriptorSetLayoutBuilder::new();

    if r == 0 {
        builder = builder.add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, vk::ShaderStageFlags::COMPUTE, 0, 1);
    } else if r == 1 {
        builder = builder.add_indexed_binding(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, vk::ShaderStageFlags::COMPUTE, 0, 1);
    } else if r == 2 {
        builder = builder.add_indexed_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, vk::ShaderStageFlags::COMPUTE, 0, 1);
    }

    builder.build(device)
}

// ---------------------------------------------------------------------------------
// Texel buffers
// ---------------------------------------------------------------------------------

/// `TexelBufferInstanceBuffers` constants.
const TEXEL_BUFFER_SIZE: usize = 512;
/// `SAMPLE_POINT_0..3` - arbitrary fetch positions, one per quadrant.
const SAMPLE_POINTS: [u32; 4] = [6, 51, 42, 25];

/// `populateSourceBuffer` - a gradient, a three-level pattern and a triangle wave, so
/// a fetch that lands at the wrong offset reads a visibly different texel whether the
/// error is large or small. Each buffer inverts a different channel.
fn populate_texel_source(buffer_ndx: u32) -> Vec<u8> {
    let format_size = 4;
    let width = TEXEL_BUFFER_SIZE / format_size;
    let mut data = vec![0u8; TEXEL_BUFFER_SIZE];

    for x in 0..width {
        let mut red = 255 * x / width;
        let mut green = if x % 2 == 0 { 127 } else { 0 } + if x % 4 < 3 { 128 } else { 0 };
        let mut blue = 16 * (x % 16);

        if buffer_ndx.is_multiple_of(2) {
            red = 255 - red;
        }
        if buffer_ndx.is_multiple_of(3) {
            green = 255 - green;
        }
        if buffer_ndx.is_multiple_of(4) {
            blue = 255 - blue;
        }

        data[x * 4] = red as u8;
        data[x * 4 + 1] = green as u8;
        data[x * 4 + 2] = blue as u8;
        data[x * 4 + 3] = 255;
    }

    data
}

/// The value the shader should read at `fetch_pos_ndx` for set `set_ndx`, taken from
/// the same source bytes the buffer was filled with. `view_offset` is in texels.
fn fetch_texel_value(sources: &[Vec<u8>], num_resources: u32, view_offset_texels: u32, fetch_pos_ndx: usize, set_ndx: u32) -> [f32; 4] {
    // The two descriptors alternate ABAB across the quadrants.
    let ndx = (set_ndx * num_resources + u32::from(!fetch_pos_ndx.is_multiple_of(2))) as usize % sources.len();
    let at = ((view_offset_texels + SAMPLE_POINTS[fetch_pos_ndx]) * 4) as usize;
    std::array::from_fn(|c| f32::from(sources[ndx][at + c]) / 255.0)
}

/// `VIEW_DATA_SIZE`
const TEXEL_VIEW_DATA_SIZE: u32 = 256;

impl BufferAccessInstance<'_> {
    /// `TexelBufferInstanceBuffers::getViewOffset`. Without
    /// `VK_EXT_texel_buffer_alignment` the offset is just the device's
    /// `minTexelBufferOffsetAlignment`.
    fn texel_view_offset(&self) -> Result<u32, TestError> {
        if !self.params.set_view_offset {
            return Ok(0);
        }
        Ok(self.context.get_device_properties().limits.min_texel_buffer_offset_alignment as u32)
    }

    /// `writeDescriptorSet` for the texel buffer types, which bind a `VkBufferView`
    /// rather than a buffer range.
    fn write_texel_descriptor_set(&self, target: DescriptorTarget, set_ndx: u32, view_a: vk::BufferView, view_b: vk::BufferView, result: vk::Buffer) {
        let set = target.set();
        let p = self.params;
        let device = self.context.get_device();

        let result_info = [vk::DescriptorBufferInfo {
            buffer: result,
            offset: 0,
            range: RESULT_DATA_SIZE,
        }];
        let views = [view_a, view_b];

        let mut writes = Vec::new();
        let mut binding = 0;

        if set_ndx == 0 && p.is_compute() {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(set)
                    .dst_binding(binding)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&result_info)
                    .build(),
            );
            binding += 1;
        }

        let single = |dst_binding: u32, v: &[vk::BufferView]| {
            vk::WriteDescriptorSet::builder()
                .dst_set(set)
                .dst_binding(dst_binding)
                .descriptor_type(p.descriptor_type)
                .texel_buffer_view(v)
                .build()
        };

        match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => writes.push(single(binding, &views[0..1])),
            ShaderInputInterface::MultipleContiguousDescriptors => {
                writes.push(single(binding, &views[0..1]));
                writes.push(single(binding + 1, &views[1..2]));
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                writes.push(single(binding, &views[0..1]));
                writes.push(single(binding + 2, &views[1..2]));
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                writes.push(single(arbitrary_binding_index(0), &views[0..1]));
                writes.push(single(arbitrary_binding_index(1), &views[1..2]));
            }
            ShaderInputInterface::DescriptorArray => writes.push(single(binding, &views)),
        }

        target.apply(device, &writes);
    }
}

// ---------------------------------------------------------------------------------
// Images
// ---------------------------------------------------------------------------------

/// `ImageInstanceImages::IMAGE_SIZE` / `ARRAY_SIZE`
const IMAGE_SIZE: u32 = 64;
const ARRAY_SIZE: u32 = 2;

/// `ImageFetchInstanceImages::SAMPLE_POINT_*` - arbitrary points, one per quadrant.
const FETCH_POSITIONS: [[u32; 3]; 4] = [[6, 13, 49], [51, 40, 44], [42, 26, 19], [25, 25, 18]];

/// `isImageViewTypeArray`
fn is_image_view_type_array(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::_1D_ARRAY | vk::ImageViewType::_2D_ARRAY | vk::ImageViewType::CUBE_ARRAY)
}

fn is_image_view_type_1d(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY)
}

fn is_image_view_type_2d(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::_2D | vk::ImageViewType::_2D_ARRAY)
}

fn is_image_view_type_cube(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::CUBE | vk::ImageViewType::CUBE_ARRAY)
}

/// `viewTypeToImageType`
fn view_type_to_image_type(t: vk::ImageViewType) -> vk::ImageType {
    match t {
        vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => vk::ImageType::_1D,
        vk::ImageViewType::_3D => vk::ImageType::_3D,
        _ => vk::ImageType::_2D,
    }
}

/// The read usage `createImage` and `checkSupport` both derive from the descriptor
/// type: a storage image is loaded from, everything else is sampled.
fn read_usage(t: vk::DescriptorType) -> vk::ImageUsageFlags {
    if t == vk::DescriptorType::STORAGE_IMAGE {
        vk::ImageUsageFlags::STORAGE
    } else {
        vk::ImageUsageFlags::SAMPLED
    }
}

/// `getImageLayoutForDescriptorType`
fn image_layout_for_descriptor_type(t: vk::DescriptorType) -> vk::ImageLayout {
    if t == vk::DescriptorType::STORAGE_IMAGE {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
    }
}

/// `ImageFetchInstanceImages::getFetchPos` - the sample points wrapped into whatever
/// the view actually exposes, so a view that starts at mip 1 or slice 1 still reads
/// in range.
fn get_fetch_pos(view_type: vk::ImageViewType, base_mip_level: u32, base_array_slice: u32, fetch_pos_ndx: usize) -> [u32; 3] {
    let coord = FETCH_POSITIONS[fetch_pos_ndx];
    let image_size = IMAGE_SIZE >> base_mip_level;
    let array_size = if is_image_view_type_array(view_type) { ARRAY_SIZE - base_array_slice } else { 1 };

    if is_image_view_type_1d(view_type) {
        [coord[0] % image_size, coord[1] % array_size, 0]
    } else if is_image_view_type_2d(view_type) {
        [coord[0] % image_size, coord[1] % image_size, coord[2] % array_size]
    } else if is_image_view_type_cube(view_type) {
        [coord[0] % image_size, coord[1] % image_size, coord[2] % (array_size * 6)]
    } else {
        [coord[0] % image_size, coord[1] % image_size, coord[2] % image_size]
    }
}

/// `ImageInstanceImages::populateSourceImage` - a gradient, a three-level pattern and
/// a per-level/per-image constant, so a fetch that lands at the wrong texel, the wrong
/// mip level or the wrong image all read visibly different values. Each image inverts
/// a different subset of the channels.
fn populate_source_image(view_type: vk::ImageViewType, image_ndx: u32, num_levels: u32) -> Result<Vec<TextureLevel>, TestError> {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let mut levels = Vec::with_capacity(num_levels as usize);

    for level in 0..num_levels {
        let width = IMAGE_SIZE >> level;
        let height = if is_image_view_type_1d(view_type) { ARRAY_SIZE } else { IMAGE_SIZE >> level };
        let depth = if is_image_view_type_1d(view_type) {
            1
        } else if is_image_view_type_2d(view_type) {
            ARRAY_SIZE
        } else if is_image_view_type_cube(view_type) {
            6 * ARRAY_SIZE
        } else {
            IMAGE_SIZE >> level
        };

        let mut texture = TextureLevel::new(format, width, height, depth)?;
        {
            let mut access = texture.get_access();
            for z in 0..depth {
                for y in 0..height {
                    for x in 0..width {
                        let grad_pos = x + y + z;
                        let grad_max = width + height + depth - 3;

                        let mut red = (255 * grad_pos / grad_max) as i32;
                        let mut green = if grad_pos.is_multiple_of(2) { 127 } else { 0 } + if grad_pos % 4 < 3 { 128 } else { 0 };
                        let mut blue = (128 * level / num_levels) as i32 + if image_ndx.is_multiple_of(2) { 127 } else { 0 };

                        if image_ndx.is_multiple_of(3) {
                            red = 255 - red;
                        }
                        if image_ndx.is_multiple_of(4) {
                            green = 255 - green;
                        }
                        if image_ndx.is_multiple_of(5) {
                            blue = 255 - blue;
                        }

                        if !access.set_pixel_int([red, green, blue, 255], x, y, z) {
                            return Err(TestError::NotPorted(format!("integer write path for {:?}", access.format())));
                        }
                    }
                }
            }
        }
        levels.push(texture);
    }

    Ok(levels)
}

/// `ImageFetchInstanceImages::fetchImageValue` - what the shader should have read for
/// `fetch_pos_ndx` in set `set_ndx`, taken from the very texels the image was filled
/// with rather than from a second formula.
fn fetch_image_value(
    source_images: &[Vec<TextureLevel>],
    shader_interface: ShaderInputInterface,
    view_type: vk::ImageViewType,
    base_mip_level: u32,
    base_array_slice: u32,
    fetch_pos_ndx: usize,
    set_ndx: u32,
) -> [f32; 4] {
    let num_resources = shader_interface.num_resources();
    let src_a = (set_ndx * num_resources) as usize;
    let src_b = if shader_interface == ShaderInputInterface::SingleDescriptor { src_a } else { src_a + 1 };
    // Sampling order is ABAB.
    let src = if fetch_pos_ndx.is_multiple_of(2) { src_a } else { src_b };

    let mut pos = get_fetch_pos(view_type, base_mip_level, base_array_slice, fetch_pos_ndx);

    // The base array layer goes into whichever coordinate the view type puts it in.
    if is_image_view_type_cube(view_type) {
        pos[2] += 6 * base_array_slice;
    } else if is_image_view_type_1d(view_type) {
        pos[1] += base_array_slice;
    } else {
        pos[2] += base_array_slice;
    }

    source_images[src][base_mip_level as usize].get_const_access().get_pixel(pos[0], pos[1], pos[2])
}

pub struct ImageAccessCase {
    name: &'static str,
    update_method: DescriptorUpdateMethod,
    descriptor_type: vk::DescriptorType,
    descriptor_set_count: DescriptorSetCount,
    shader_interface: ShaderInputInterface,
    view_type: vk::ImageViewType,
    /// `FLAG_BASE_MIP` - the view starts one mip level in.
    base_mip_level: u32,
    /// `FLAG_BASE_SLICE` - and/or one array slice in.
    base_array_slice: u32,
    /// `RESOURCE_FLAG_IMMUTABLE_SAMPLER` - the sampler is baked into the descriptor
    /// set layout instead of being written into the descriptor.
    is_immutable_sampler: bool,
    /// `m_stageFlags` - see `BufferAccessCase::stage_flags`.
    stage_flags: vk::ShaderStageFlags,
    is_primary_cmd_buf: bool,
    bind2: bool,
}

impl ImageAccessCase {
    fn is_compute(&self) -> bool {
        self.stage_flags == vk::ShaderStageFlags::COMPUTE
    }

    fn manifest_descriptor_type(&self) -> &'static str {
        match self.descriptor_type {
            vk::DescriptorType::STORAGE_IMAGE => "storage_image",
            vk::DescriptorType::SAMPLER => "sampler",
            _ => "combined_image_sampler",
        }
    }

    fn program(&self) -> &'static ImageAccessProgram {
        let descriptor_type = self.manifest_descriptor_type();
        ALL_IMAGE_ACCESS_PROGRAM
            .iter()
            .copied()
            .find(|p| {
                p.descriptor_type == descriptor_type
                    && p.view_name == self.name
                    && p.set_count == self.descriptor_set_count.manifest_name()
                    && p.shader_interface == self.shader_interface.manifest_name()
            })
            .expect("the generator covers every combination")
    }

    /// `ImageSampleInstanceImages::getNumImages` and, for the fetch path, the plain
    /// one-image-per-descriptor count. A separate sampler shares one texture across
    /// the set, since what is being varied there is the sampler.
    fn num_images(&self) -> u32 {
        let sets = self.descriptor_set_count.count();
        if self.descriptor_type == vk::DescriptorType::SAMPLER {
            sets
        } else {
            sets * self.shader_interface.num_resources()
        }
    }

    fn is_sampling_case(&self) -> bool {
        self.descriptor_type != vk::DescriptorType::STORAGE_IMAGE
    }
}

impl TestCase for ImageAccessCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        verify_update_method_support(context, self.update_method)?;
        check_stage_support(context, self.stage_flags, self.bind2)?;

        // `verifyDriverSupport`, restricted to what the compute stage can reach.
        if self.view_type == vk::ImageViewType::CUBE_ARRAY && context.get_device_features().image_cube_array == vk::FALSE {
            return Err(TestError::NotSupported("imageCubeArray feature not supported".into()));
        }

        let required_sets = match self.descriptor_set_count {
            DescriptorSetCount::Single => 1,
            DescriptorSetCount::Multiple => 2,
            DescriptorSetCount::MultipleDiscontiguous => 3,
        };
        let limits = context.get_device_properties().limits;
        if limits.max_bound_descriptor_sets < required_sets {
            return Err(TestError::NotSupported(format!("maxBoundDescriptorSets is {}", limits.max_bound_descriptor_sets)));
        }

        if self.base_mip_level == 1 {
            let properties = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    vk::Format::R8G8B8A8_UNORM,
                    view_type_to_image_type(self.view_type),
                    vk::ImageTiling::OPTIMAL,
                    read_usage(self.descriptor_type) | vk::ImageUsageFlags::TRANSFER_DST,
                    vk::ImageCreateFlags::empty(),
                )
            };
            match properties {
                Err(_) => return Err(TestError::NotSupported("Required format not supported".into())),
                Ok(p) if p.max_mip_levels < 2 => return Err(TestError::NotSupported("Required mipmap count not supported".into())),
                Ok(_) => {}
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageAccessInstance { context, params: self })
    }
}

struct ImageAccessInstance<'a> {
    context: &'a Context<'a>,
    params: &'a ImageAccessCase,
}

impl TestInstance for ImageAccessInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        // `ImageFetchComputeInstance` builds a pyramid just deep enough to reach the
        // level the view starts at.
        let num_levels = p.base_mip_level + 1;
        let num_sets = p.descriptor_set_count.count();
        let num_resources = p.shader_interface.num_resources();
        let num_images = p.num_images();

        let mut source_images = Vec::with_capacity(num_images as usize);
        let mut images = Vec::with_capacity(num_images as usize);
        let mut image_views = Vec::with_capacity(num_images as usize);

        for image_ndx in 0..num_images {
            let source = populate_source_image(p.view_type, image_ndx, num_levels)?;
            let image = self.create_image(&source)?;
            self.upload_image(&source, image.get(), queue, queue_index)?;
            let view = self.create_image_view(&source, image.get())?;

            source_images.push(source);
            images.push(image);
            image_views.push(view);
        }

        // `ImageSampleInstanceImages::getRefSamplers` / `getSamplers` - one pair per
        // set, alternating linear-wrapping with nearest-clamping.
        let mut ref_samplers = Vec::new();
        let mut samplers = Vec::new();
        if p.is_sampling_case() {
            for sampler_ndx in 0..(num_sets * num_resources) {
                let reference = create_ref_sampler(sampler_ndx);
                samplers.push(create_sampler(device, &reference)?);
                ref_samplers.push(reference);
            }
        }
        let sampler_handles: Vec<vk::Sampler> = samplers.iter().map(|s| **s).collect();

        // `ComputeInstanceResultBuffer` - cleared to -1 so "never written" is
        // distinguishable from "written with the wrong value".
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(RESULT_DATA_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let ptr = result_buffer.get_allocation().get_host_ptr().cast::<f32>();
            for i in 0..(RESULT_DATA_SIZE as usize / 4) {
                ptr.add(i).write(-1.0);
            }
        }
        flush_alloc(device, result_buffer.get_allocation())?;

        // A push case allocates no sets: its layout is declared for push.
        let is_push = p.update_method.is_push();
        let pool = (!is_push).then(|| self.create_descriptor_pool()).transpose()?;
        let mut set_layouts = Vec::new();
        let mut layout_handles = Vec::new();
        let mut sets = Vec::new();

        // The discontiguous arrangement puts an unused layout between the two real
        // ones, so `set_layouts` is not indexable by set index - a descriptor update
        // template built against the unused layout would walk the update data with the
        // wrong strides.
        // Kept as a pair so the two cannot drift: a descriptor update template built
        // against a layout other than the one its target set was allocated from walks
        // the update data with the wrong strides, which reads off the end of the
        // registry and writes garbage descriptors.
        let mut targets: Vec<(vk::DescriptorSet, vk::DescriptorSetLayout)> = Vec::new();

        for set_ndx in 0..num_sets {
            let layout = self.create_descriptor_set_layout(set_ndx, &sampler_handles)?;
            let set = match &pool {
                Some(pool) => {
                    let set = make_descriptor_set(device, **pool, *layout)?;
                    let handle = *set;
                    sets.push(set);
                    handle
                }
                None => vk::DescriptorSet::null(),
            };
            targets.push((set, *layout));
            layout_handles.push(*layout);
            set_layouts.push(layout);

            if set_ndx == 0 && p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                let unused = create_unused_layout(
                    device,
                    crate::tcu::random::de_int32_hash(p.descriptor_type.as_raw()) ^ crate::tcu::random::de_int32_hash(num_levels as i32),
                )?;
                layout_handles.push(*unused);
                set_layouts.push(unused);
            }
        }

        let pipeline_layout = make_pipeline_layout(device, &layout_handles)?;
        let set_handles: Vec<vk::DescriptorSet> = sets.iter().map(|s| **s).collect();

        let write_image_descriptors = |target: DescriptorTarget, set_ndx: u32| -> Result<Option<TemplateKeepAlive<'_>>, TestError> {
            let stride = if p.descriptor_type == vk::DescriptorType::SAMPLER { 1 } else { num_resources };
            let ndx0 = (set_ndx * stride) as usize % image_views.len();
            let ndx1 = (set_ndx * stride + 1) as usize % image_views.len();
            let (_, set_layout) = targets[set_ndx as usize];
            if p.update_method.uses_template() {
                self.write_descriptor_set_with_template(
                    target,
                    set_layout,
                    *pipeline_layout,
                    set_ndx,
                    *image_views[ndx0],
                    *image_views[ndx1],
                    &sampler_handles,
                    result_buffer.get(),
                )
            } else {
                self.write_descriptor_set(target, set_ndx, *image_views[ndx0], *image_views[ndx1], &sampler_handles, result_buffer.get());
                Ok(None)
            }
        };

        if !is_push {
            for (set_ndx, &(set, layout)) in targets.iter().enumerate() {
                write_image_descriptors(DescriptorTarget::Set { set, layout }, set_ndx as u32)?;
            }
        }

        // The graphics path renders the answers instead of writing them, so it leaves
        // here with an image rather than a result buffer.
        let rendered = if p.is_compute() {
            None
        } else {
            let (_modules, stages) = graphics_modules(device, &p.program().programs, p.stage_flags)?;
            // Outlives the draw; the cell is only because `bind` is a `Fn`.
            let pushed_templates = std::cell::RefCell::new(Vec::new());
            let bind = |device: &Device, cmd: vk::CommandBuffer| {
                if is_push {
                    for set_ndx in 0..num_sets {
                        match write_image_descriptors(
                            DescriptorTarget::Push {
                                cmd,
                                bind_point: vk::PipelineBindPoint::GRAPHICS,
                                layout: *pipeline_layout,
                                set_ndx: p.descriptor_set_count.set_ndx(set_ndx),
                            },
                            set_ndx,
                        ) {
                            Ok(keep) => pushed_templates.borrow_mut().extend(keep),
                            Err(e) => log::error!("recording a pushed descriptor set failed: {e:?}"),
                        }
                    }
                    return;
                }
                if p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                    for set_ndx in 0..num_sets {
                        bind_descriptor_sets(
                            device,
                            cmd,
                            p.stage_flags,
                            vk::PipelineBindPoint::GRAPHICS,
                            *pipeline_layout,
                            p.descriptor_set_count.set_ndx(set_ndx),
                            &set_handles[set_ndx as usize..set_ndx as usize + 1],
                            &[],
                            p.bind2,
                        );
                    }
                } else {
                    bind_descriptor_sets(device, cmd, p.stage_flags, vk::PipelineBindPoint::GRAPHICS, *pipeline_layout, 0, &set_handles, &[], p.bind2);
                }
            };
            Some(render_quadrants(
                device,
                allocator,
                queue,
                queue_index,
                *pipeline_layout,
                stages,
                p.is_primary_cmd_buf,
                &bind,
            )?)
        };

        let module = if p.is_compute() {
            Some(create_shader_module(device, p.program().programs.get("compute")?)?)
        } else {
            None
        };
        let pipeline = match &module {
            Some(m) => Some(self.create_compute_pipeline(*pipeline_layout, **m)?),
            None => None,
        };

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Outlives the submit below.
        let mut pushed_templates = Vec::new();

        let mut results = [[0.0f32; 4]; 4];
        if let Some(pipeline) = &pipeline {
            begin_command_buffer(device, *command_buffer)?;
            unsafe {
                device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::COMPUTE, **pipeline);

                // A push case has no set to bind: the descriptors go into the command
                // buffer here instead.
                if is_push {
                    for set_ndx in 0..num_sets {
                        pushed_templates.extend(write_image_descriptors(
                            DescriptorTarget::Push {
                                cmd: *command_buffer,
                                bind_point: vk::PipelineBindPoint::COMPUTE,
                                layout: *pipeline_layout,
                                set_ndx: p.descriptor_set_count.set_ndx(set_ndx),
                            },
                            set_ndx,
                        )?);
                    }
                }

                // The discontiguous arrangement's sets are 0 and 2, so each binds at its
                // own index rather than all of them in one call from index 0.
                if is_push {
                    // Already pushed above.
                } else if p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                    for set_ndx in 0..num_sets {
                        device.cmd_bind_descriptor_sets(
                            *command_buffer,
                            vk::PipelineBindPoint::COMPUTE,
                            *pipeline_layout,
                            p.descriptor_set_count.set_ndx(set_ndx),
                            &set_handles[set_ndx as usize..set_ndx as usize + 1],
                            &[] as &[u32],
                        );
                    }
                } else {
                    device.cmd_bind_descriptor_sets(*command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline_layout, 0, &set_handles, &[] as &[u32]);
                }

                device.cmd_dispatch(*command_buffer, 4, 1, 1);

                let post = vk::BufferMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .buffer(result_buffer.get())
                    .offset(0)
                    .size(vk::WHOLE_SIZE)
                    .build();
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[post],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, *command_buffer)?;
            submit_commands_and_wait(device, queue, *command_buffer)?;

            invalidate_alloc(device, result_buffer.get_allocation())?;
            unsafe {
                let ptr = result_buffer.get_allocation().get_host_ptr().cast::<f32>();
                for (i, quadrant) in results.iter_mut().enumerate() {
                    for (c, value) in quadrant.iter_mut().enumerate() {
                        *value = ptr.add(i * 4 + c).read();
                    }
                }
            }
        }

        let mut references = [[0.0f32; 4]; 4];
        for (quadrant, reference) in references.iter_mut().enumerate() {
            for set_ndx in 0..num_sets {
                let value = if p.is_sampling_case() {
                    fetch_sample_value(
                        &source_images,
                        &ref_samplers,
                        p.descriptor_type,
                        p.shader_interface,
                        p.view_type,
                        p.base_mip_level,
                        p.base_array_slice,
                        quadrant,
                        set_ndx,
                    )
                } else {
                    fetch_image_value(&source_images, p.shader_interface, p.view_type, p.base_mip_level, p.base_array_slice, quadrant, set_ndx)
                };
                for (r, v) in reference.iter_mut().zip(value) {
                    *r += v;
                }
            }
            if p.is_sampling_case() || num_sets > 1 {
                for r in reference.iter_mut() {
                    *r /= num_sets as f32;
                }
            }
        }

        // `ImageFetchRenderInstance::verifyResultImage` - the same four references,
        // compared against the rendered image rather than a result buffer. `no_access`
        // reads nothing, so the shader writes the fixed pair instead.
        if let Some(pixels) = &rendered {
            let quadrants = if p.stage_flags.is_empty() {
                [COLORS[1], COLORS[0], COLORS[0], COLORS[1]]
            } else {
                references
            };
            return Ok(compare_quadrant_image(pixels, quadrants));
        }

        // A fetched value only went through a UNORM8 conversion, so a whole
        // quantisation step is enough slack. A sampled one went through a filter over
        // a deliberately high-frequency source, and upstream allows correspondingly
        // more for the sampling error that implies.
        let threshold = if p.is_sampling_case() { 8.0 / 255.0 } else { 1.0 / 255.0 };
        let any_result_set = results.iter().any(|q| *q != [-1.0f32; 4]);
        let all_ok = results
            .iter()
            .zip(&references)
            .all(|(result, reference)| result.iter().zip(reference).all(|(r, e)| (r - e).abs() <= threshold));

        if all_ok {
            Ok(TestStatus::pass("Pass"))
        } else if any_result_set {
            Ok(TestStatus::fail("Invalid result values"))
        } else {
            Ok(TestStatus::fail("Result buffer was not written to"))
        }
    }
}

impl ImageAccessInstance<'_> {
    /// `ImageInstanceImages::createImage`
    fn create_image(&self, source: &[TextureLevel]) -> Result<ImageWithMemory<'_>, TestError> {
        let read_usage = read_usage(self.params.descriptor_type);
        let p = self.params;
        let base_level = source[0].size();
        let is_cube = is_image_view_type_cube(p.view_type);

        let array_size = if is_image_view_type_1d(p.view_type) {
            base_level[1]
        } else if p.view_type == vk::ImageViewType::_3D {
            1
        } else {
            // 2D and cube alike; for a cube this is numFaces * numLayers.
            base_level[2]
        };
        let extent = vk::Extent3D {
            width: base_level[0],
            height: if is_image_view_type_1d(p.view_type) { 1 } else { base_level[1] },
            depth: if p.view_type == vk::ImageViewType::_3D { base_level[2] } else { 1 },
        };

        let info = vk::ImageCreateInfo::builder()
            .flags(if is_cube {
                vk::ImageCreateFlags::CUBE_COMPATIBLE
            } else {
                vk::ImageCreateFlags::empty()
            })
            .image_type(view_type_to_image_type(p.view_type))
            .format(vk::Format::R8G8B8A8_UNORM)
            .extent(extent)
            .mip_levels(source.len() as u32)
            .array_layers(array_size)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(read_usage | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        ImageWithMemory::new(self.context.get_device(), self.context.get_default_allocator(), info, MemoryRequirement::ANY)
    }

    /// `ImageInstanceImages::createImageView`
    fn create_image_view(&self, source: &[TextureLevel], image: vk::Image) -> Result<Unique<'_, vk::ImageView>, TestError> {
        let p = self.params;
        let base_level = source[0].size();
        // A cube view counts slices in faces, so the base slice is six layers in.
        let view_type_base_slice = if is_image_view_type_cube(p.view_type) {
            6 * p.base_array_slice
        } else {
            p.base_array_slice
        };
        let view_array_size = match p.view_type {
            vk::ImageViewType::_1D | vk::ImageViewType::_2D | vk::ImageViewType::_3D => 1,
            vk::ImageViewType::_1D_ARRAY => base_level[1] - view_type_base_slice,
            vk::ImageViewType::CUBE => 6,
            _ => base_level[2] - view_type_base_slice,
        };

        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: p.base_mip_level,
            level_count: source.len() as u32 - p.base_mip_level,
            base_array_layer: view_type_base_slice,
            layer_count: view_array_size,
        };
        make_image_view(self.context.get_device(), image, p.view_type, vk::Format::R8G8B8A8_UNORM, range)
    }

    /// `ImageInstanceImages::uploadImage` plus the `writeTextureLevelPyramidData` that
    /// lays the levels out for it. Every level is tightly packed and every array slice
    /// gets its own copy region, which is also how a cube's six faces are fed in.
    fn upload_image(&self, source: &[TextureLevel], image: vk::Image, queue: vk::Queue, queue_index: u32) -> Result<(), TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let base_level = source[0].size();
        let slice_count = if is_image_view_type_1d(p.view_type) {
            base_level[1]
        } else if p.view_type == vk::ImageViewType::_3D {
            1
        } else {
            base_level[2]
        };

        let data_size: usize = source.iter().map(|l| l.data().len()).sum();
        let staging = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(data_size as u64, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut copies = Vec::new();
        let mut level_offset = 0usize;
        for (level, texture) in source.iter().enumerate() {
            let size = texture.size();
            let level_data_size = texture.data().len();
            let slice_data_size = level_data_size / slice_count as usize;
            let slice_height = if is_image_view_type_1d(p.view_type) { 1 } else { size[1] };
            let slice_depth = if p.view_type == vk::ImageViewType::_3D { size[2] } else { 1 };

            for slice_ndx in 0..slice_count {
                copies.push(vk::BufferImageCopy {
                    buffer_offset: (level_offset + slice_ndx as usize * slice_data_size) as u64,
                    buffer_row_length: size[0],
                    buffer_image_height: slice_height,
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level: level as u32,
                        base_array_layer: slice_ndx,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width: size[0],
                        height: slice_height,
                        depth: slice_depth,
                    },
                });
            }

            unsafe {
                std::ptr::copy_nonoverlapping(texture.data().as_ptr(), staging.get_allocation().get_host_ptr().add(level_offset), level_data_size);
            }
            level_offset += level_data_size;
        }
        flush_alloc(device, staging.get_allocation())?;

        let layout = image_layout_for_descriptor_type(p.descriptor_type);
        let array_layers = if p.view_type == vk::ImageViewType::_3D {
            1
        } else if is_image_view_type_cube(p.view_type) {
            6 * ARRAY_SIZE
        } else {
            ARRAY_SIZE
        };
        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: source.len() as u32,
            base_array_layer: 0,
            layer_count: array_layers,
        };

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let pre = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre],
            );

            device.cmd_copy_buffer_to_image(*command_buffer, staging.get(), image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &copies);

            let post = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::SHADER_READ)
                .old_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                .new_layout(layout)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post],
            );
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)
    }

    /// `ImageFetchComputeInstance::createDescriptorSetLayout` and
    /// `ImageSampleComputeInstance::createDescriptorSetLayout`.
    ///
    /// The separate-sampler type needs an extra binding for the texture the samplers
    /// are applied to, and the immutable variant bakes the sampler into the layout
    /// here instead of writing it into the descriptor later.
    fn create_descriptor_set_layout(&self, set_ndx: u32, samplers: &[vk::Sampler]) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        let p = self.params;
        let mut builder = DescriptorSetLayoutBuilder::new();
        let mut binding = 0;
        let stages = p.stage_flags;

        // The result buffer exists only on the dispatch path.
        if set_ndx == 0 && p.is_compute() {
            builder = builder.add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE, binding, 1);
            binding += 1;
        }

        let is_separate_sampler = p.descriptor_type == vk::DescriptorType::SAMPLER;
        // The storage image case has no samplers at all; the array is still built so
        // the immutable path below can index it uniformly.
        let set_samplers: [vk::Sampler; 2] = std::array::from_fn(|ndx| match samplers.len() {
            0 => vk::Sampler::null(),
            n => samplers[(set_ndx * p.shader_interface.num_resources() + ndx as u32) as usize % n],
        });
        let immutable = |ndx: usize| -> Option<&[vk::Sampler]> { p.is_immutable_sampler.then(|| &set_samplers[ndx..ndx + 1]) };

        let add = |builder: DescriptorSetLayoutBuilder, b: u32, samplers: Option<&[vk::Sampler]>, count: u32| match samplers {
            Some(s) => builder.add_indexed_sampler_binding(p.descriptor_type, stages, b, s),
            None => builder.add_indexed_binding(p.descriptor_type, stages, b, count),
        };

        builder = match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => {
                if is_separate_sampler {
                    builder = builder.add_indexed_binding(vk::DescriptorType::SAMPLED_IMAGE, stages, binding, 1);
                    binding += 1;
                }
                add(builder, binding, immutable(0), 1)
            }
            ShaderInputInterface::MultipleContiguousDescriptors => {
                if is_separate_sampler {
                    builder = builder.add_indexed_binding(vk::DescriptorType::SAMPLED_IMAGE, stages, binding, 1);
                    binding += 1;
                }
                let builder = add(builder, binding, immutable(0), 1);
                add(builder, binding + 1, immutable(1), 1)
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                // The texture sits between the two samplers here rather than before
                // them, which is the whole point of the arrangement.
                let mut builder = add(builder, binding, immutable(0), 1);
                if is_separate_sampler {
                    builder = builder.add_indexed_binding(vk::DescriptorType::SAMPLED_IMAGE, stages, binding + 1, 1);
                }
                add(builder, binding + 2, immutable(1), 1)
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                if is_separate_sampler {
                    builder = builder.add_indexed_binding(vk::DescriptorType::SAMPLED_IMAGE, stages, binding, 1);
                }
                let builder = add(builder, arbitrary_binding_index(0), immutable(0), 1);
                add(builder, arbitrary_binding_index(1), immutable(1), 1)
            }
            ShaderInputInterface::DescriptorArray => {
                if is_separate_sampler {
                    builder = builder.add_indexed_binding(vk::DescriptorType::SAMPLED_IMAGE, stages, binding, 1);
                    binding += 1;
                }
                add(builder, binding, p.is_immutable_sampler.then_some(&set_samplers[..]), 2)
            }
        };

        // `VK_DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR` - a push layout is
        // never allocated from, so the flag is load-bearing rather than advisory.
        let flags = if p.update_method.is_push() {
            vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR
        } else {
            vk::DescriptorSetLayoutCreateFlags::empty()
        };
        builder.build_with_flags(self.context.get_device(), flags)
    }

    /// `ImageFetchComputeInstance::createDescriptorPool` /
    /// `ImageSampleComputeInstance::createDescriptorPool`
    fn create_descriptor_pool(&self) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        let p = self.params;
        let num = p.descriptor_set_count.count() * p.shader_interface.num_resources();
        let mut builder = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(p.descriptor_type, num);

        if p.descriptor_type == vk::DescriptorType::SAMPLER {
            builder = builder.add_type(vk::DescriptorType::SAMPLED_IMAGE, p.descriptor_set_count.count());
        }

        builder.build(
            self.context.get_device(),
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            p.descriptor_set_count.count(),
        )
    }

    /// `ImageFetchComputeInstance::writeDescriptorSet`,
    /// `ImageSampleComputeInstance::writeSamplerDescriptorSet` and
    /// `writeImageSamplerDescriptorSet`.
    fn write_descriptor_set(&self, target: DescriptorTarget, set_ndx: u32, view_a: vk::ImageView, view_b: vk::ImageView, samplers: &[vk::Sampler], result: vk::Buffer) {
        let set = target.set();
        let p = self.params;
        let device = self.context.get_device();
        let layout = image_layout_for_descriptor_type(p.descriptor_type);
        let is_separate_sampler = p.descriptor_type == vk::DescriptorType::SAMPLER;

        let result_info = [vk::DescriptorBufferInfo {
            buffer: result,
            offset: 0,
            range: RESULT_DATA_SIZE,
        }];

        // A combined descriptor carries its own sampler; an immutable one has it from
        // the layout instead and leaves the handle null.
        let combined_sampler = |ndx: u32| -> vk::Sampler {
            if p.is_immutable_sampler || samplers.is_empty() {
                vk::Sampler::null()
            } else {
                samplers[(set_ndx * p.shader_interface.num_resources() + ndx) as usize % samplers.len()]
            }
        };
        let image_infos = [
            vk::DescriptorImageInfo {
                sampler: combined_sampler(0),
                image_view: view_a,
                image_layout: layout,
            },
            vk::DescriptorImageInfo {
                sampler: combined_sampler(1),
                image_view: view_b,
                image_layout: layout,
            },
        ];
        let sampler_infos: [vk::DescriptorImageInfo; 2] = std::array::from_fn(|ndx| vk::DescriptorImageInfo {
            sampler: if samplers.is_empty() {
                vk::Sampler::null()
            } else {
                samplers[(set_ndx * p.shader_interface.num_resources() + ndx as u32) as usize % samplers.len()]
            },
            image_view: vk::ImageView::null(),
            image_layout: vk::ImageLayout::UNDEFINED,
        });
        let texture_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: view_a,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];

        let mut writes = Vec::new();
        let mut binding = 0;

        if set_ndx == 0 && p.is_compute() {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(set)
                    .dst_binding(binding)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&result_info)
                    .build(),
            );
            binding += 1;
        }

        // The stand-alone texture, for the separate-sampler type only.
        if is_separate_sampler {
            let texture_binding = if p.shader_interface == ShaderInputInterface::MultipleDiscontiguousDescriptors {
                binding + 1
            } else {
                let b = binding;
                binding += 1;
                b
            };
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(set)
                    .dst_binding(texture_binding)
                    .descriptor_type(vk::DescriptorType::SAMPLED_IMAGE)
                    .image_info(&texture_info)
                    .build(),
            );
        }

        // An immutable separate sampler has nothing left to write.
        let write_resource = !(is_separate_sampler && p.is_immutable_sampler);
        if write_resource {
            let infos: &[vk::DescriptorImageInfo; 2] = if is_separate_sampler { &sampler_infos } else { &image_infos };
            let single = |dst_binding: u32, info: &[vk::DescriptorImageInfo]| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(set)
                    .dst_binding(dst_binding)
                    .descriptor_type(p.descriptor_type)
                    .image_info(info)
                    .build()
            };

            match p.shader_interface {
                ShaderInputInterface::SingleDescriptor => writes.push(single(binding, &infos[0..1])),
                ShaderInputInterface::MultipleContiguousDescriptors => {
                    writes.push(single(binding, &infos[0..1]));
                    writes.push(single(binding + 1, &infos[1..2]));
                }
                ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                    writes.push(single(binding, &infos[0..1]));
                    writes.push(single(binding + 2, &infos[1..2]));
                }
                ShaderInputInterface::MultipleArbitraryDescriptors => {
                    writes.push(single(arbitrary_binding_index(0), &infos[0..1]));
                    writes.push(single(arbitrary_binding_index(1), &infos[1..2]));
                }
                ShaderInputInterface::DescriptorArray => writes.push(single(binding, infos)),
            }
        }

        target.apply(device, &writes);
    }

    fn create_compute_pipeline(&self, layout: vk::PipelineLayout, module: vk::ShaderModule) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let entry = c"main";
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build();
        let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(layout);
        let pipeline = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0];
        Ok(Unique::new(device, pipeline))
    }
}

/// `s_imageTypes` - the view type each case name stands for.
const IMAGE_TYPES: [(&str, vk::ImageViewType, u32, u32); 20] = [
    ("1d", vk::ImageViewType::_1D, 0, 0),
    ("1d_base_mip", vk::ImageViewType::_1D, 1, 0),
    ("1d_base_slice", vk::ImageViewType::_1D, 0, 1),
    ("1d_array", vk::ImageViewType::_1D_ARRAY, 0, 0),
    ("1d_array_base_mip", vk::ImageViewType::_1D_ARRAY, 1, 0),
    ("1d_array_base_slice", vk::ImageViewType::_1D_ARRAY, 0, 1),
    ("2d", vk::ImageViewType::_2D, 0, 0),
    ("2d_base_mip", vk::ImageViewType::_2D, 1, 0),
    ("2d_base_slice", vk::ImageViewType::_2D, 0, 1),
    ("2d_array", vk::ImageViewType::_2D_ARRAY, 0, 0),
    ("2d_array_base_mip", vk::ImageViewType::_2D_ARRAY, 1, 0),
    ("2d_array_base_slice", vk::ImageViewType::_2D_ARRAY, 0, 1),
    ("3d", vk::ImageViewType::_3D, 0, 0),
    ("3d_base_mip", vk::ImageViewType::_3D, 1, 0),
    // no 3d array textures
    ("cube", vk::ImageViewType::CUBE, 0, 0),
    ("cube_base_mip", vk::ImageViewType::CUBE, 1, 0),
    ("cube_base_slice", vk::ImageViewType::CUBE, 0, 1),
    ("cube_array", vk::ImageViewType::CUBE_ARRAY, 0, 0),
    ("cube_array_base_mip", vk::ImageViewType::CUBE_ARRAY, 1, 0),
    ("cube_array_base_slice", vk::ImageViewType::CUBE_ARRAY, 0, 1),
];

/// `createShaderAccessImageTests`' "skip some image view variations to avoid
/// unnecessary bloating": only the plain 2D view gets the arrangements that already
/// multiply out, so the group does not become the product of every axis.
fn image_case_exists(
    view_type: vk::ImageViewType,
    descriptor_set_count: DescriptorSetCount,
    shader_interface: ShaderInputInterface,
    descriptor_type: vk::DescriptorType,
    is_compute: bool,
) -> bool {
    if view_type == vk::ImageViewType::_2D {
        return true;
    }
    if shader_interface == ShaderInputInterface::MultipleArbitraryDescriptors || descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
        return false;
    }
    // Upstream keeps the discontiguous arrangement on a non-2D view only for the
    // separate sampler type, where it is about where the sampler sits relative to the
    // texture rather than about the view - and a second rule takes it away again in a
    // compute shader.
    if shader_interface == ShaderInputInterface::MultipleDiscontiguousDescriptors {
        return descriptor_type == vk::DescriptorType::SAMPLER && !is_compute;
    }
    true
}

/// `ImageSampleInstanceImages::createRefSampler` - the two the group alternates
/// between. They differ in both filter and wrap mode, so a descriptor that resolved to
/// the wrong sampler reads a visibly different colour.
fn create_ref_sampler(ndx: u32) -> tcu::pixel::Sampler {
    if ndx.is_multiple_of(2) {
        // linear, wrapping
        tcu::pixel::Sampler {
            wrap_s: tcu::pixel::WrapMode::Repeat,
            wrap_t: tcu::pixel::WrapMode::Repeat,
            wrap_r: tcu::pixel::WrapMode::Repeat,
            filter: tcu::pixel::FilterMode::Linear,
            normalized_coords: true,
        }
    } else {
        // nearest, clamping
        tcu::pixel::Sampler {
            wrap_s: tcu::pixel::WrapMode::ClampToEdge,
            wrap_t: tcu::pixel::WrapMode::ClampToEdge,
            wrap_r: tcu::pixel::WrapMode::ClampToEdge,
            filter: tcu::pixel::FilterMode::Nearest,
            normalized_coords: true,
        }
    }
}

/// `vk::mapWrapMode`
fn map_wrap_mode(mode: tcu::pixel::WrapMode) -> vk::SamplerAddressMode {
    match mode {
        tcu::pixel::WrapMode::ClampToEdge => vk::SamplerAddressMode::CLAMP_TO_EDGE,
        tcu::pixel::WrapMode::ClampToBorder => vk::SamplerAddressMode::CLAMP_TO_BORDER,
        tcu::pixel::WrapMode::Repeat => vk::SamplerAddressMode::REPEAT,
    }
}

/// `vk::mapSampler`, for the non-mipmapping, non-comparing samplers this group builds.
/// `maxLod` is 0.25 rather than 0 because upstream passes the whole pyramid and lets
/// the filter mode decide; with no mipmap mode selected the level is 0 either way.
fn create_sampler<'a>(device: &'a Device, sampler: &tcu::pixel::Sampler) -> Result<Unique<'a, vk::Sampler>, TestError> {
    let filter = match sampler.filter {
        tcu::pixel::FilterMode::Nearest => vk::Filter::NEAREST,
        _ => vk::Filter::LINEAR,
    };
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(filter)
        .min_filter(filter)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(map_wrap_mode(sampler.wrap_s))
        .address_mode_v(map_wrap_mode(sampler.wrap_t))
        .address_mode_w(map_wrap_mode(sampler.wrap_r))
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::ALWAYS)
        .min_lod(0.0)
        .max_lod(0.25)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(!sampler.normalized_coords);
    let handle = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, handle))
}

/// `ImageSampleInstanceImages::getSamplePos` - arbitrary values chosen so that NEAREST
/// filtering does not land on a texel boundary.
fn get_sample_pos(view_type: vk::ImageViewType, base_mip_level: u32, base_array_slice: u32, sample_pos_ndx: usize) -> [f32; 4] {
    let image_size = (IMAGE_SIZE >> base_mip_level) as f32;
    let image_size_u = IMAGE_SIZE >> base_mip_level;
    let array_size = if is_image_view_type_array(view_type) { ARRAY_SIZE - base_array_slice } else { 1 };

    if is_image_view_type_cube(view_type) {
        // These are in [0, texSize]^3 for convenience and get mapped to [-1, 1]^3.
        let coords = [
            [0.75, 0.5, image_size],
            [(13 % image_size_u) as f32 + 0.25, 0.0, (16 % image_size_u) as f32 + 0.5],
            [0.0, (84 % image_size_u) as f32 + 0.5, (10 % image_size_u) as f32 + 0.75],
            [image_size, (75 % image_size_u) as f32 + 0.25, (83 % image_size_u) as f32 + 0.75],
        ][sample_pos_ndx];
        let slices = [1 % array_size, 2 % array_size, 9 % array_size, 5 % array_size];
        return [
            coords[0] / image_size * 2.0 - 1.0,
            coords[1] / image_size * 2.0 - 1.0,
            coords[2] / image_size * 2.0 - 1.0,
            slices[sample_pos_ndx] as f32,
        ];
    }

    let coords = [
        [0.75, 0.5, (12 % image_size_u) as f32 + 0.25],
        [
            (23 % image_size_u) as f32 + 0.25,
            (73 % image_size_u) as f32 + 0.5,
            (16 % image_size_u) as f32 + 0.5 + image_size,
        ],
        [
            -((43 % image_size_u) as f32) + 0.25,
            (84 % image_size_u) as f32 + 0.5 + image_size,
            (117 % image_size_u) as f32 + 0.75,
        ],
        [image_size + 0.5, (75 % image_size_u) as f32 + 0.25, (83 % image_size_u) as f32 + 0.25 + image_size],
    ][sample_pos_ndx];
    let slices = [0 % array_size, 4 % array_size, 9 % array_size, 2 % array_size];

    if is_image_view_type_1d(view_type) {
        [coords[0] / image_size, slices[sample_pos_ndx] as f32, 0.0, 0.0]
    } else if is_image_view_type_2d(view_type) {
        [coords[0] / image_size, coords[1] / image_size, slices[sample_pos_ndx] as f32, 0.0]
    } else {
        [coords[0] / image_size, coords[1] / image_size, coords[2] / image_size, 0.0]
    }
}

/// `ImageSampleInstanceImages::fetchSampleValue` - the reference the shader's
/// `textureLod` should have produced, taken through the same tcu sampler the VkSampler
/// was built from and the same texels the image was filled with.
#[allow(clippy::too_many_arguments)]
fn fetch_sample_value(
    source_images: &[Vec<TextureLevel>],
    ref_samplers: &[tcu::pixel::Sampler],
    descriptor_type: vk::DescriptorType,
    shader_interface: ShaderInputInterface,
    view_type: vk::ImageViewType,
    base_mip_level: u32,
    base_array_slice: u32,
    sample_pos_ndx: usize,
    set_ndx: u32,
) -> [f32; 4] {
    let num_resources = shader_interface.num_resources();
    // Texture order is ABAB; a separate sampler has only the one texture.
    let is_sampler_case = descriptor_type == vk::DescriptorType::SAMPLER;
    let num_images = if is_sampler_case { 1 } else { num_resources };
    let src_a = (set_ndx * num_images) as usize % source_images.len();
    let src_b = if shader_interface == ShaderInputInterface::SingleDescriptor {
        src_a
    } else {
        (set_ndx * num_images + 1) as usize % source_images.len()
    };
    let src = if is_sampler_case || sample_pos_ndx.is_multiple_of(2) { src_a } else { src_b };

    // Sampler order is ABAB too, and independent of the texture order.
    let sampler_a = (set_ndx * num_resources) as usize % ref_samplers.len();
    let sampler_b = if shader_interface == ShaderInputInterface::SingleDescriptor {
        sampler_a
    } else {
        (set_ndx * num_resources + 1) as usize % ref_samplers.len()
    };
    let sampler = &ref_samplers[if sample_pos_ndx.is_multiple_of(2) { sampler_a } else { sampler_b }];

    let pos = get_sample_pos(view_type, base_mip_level, base_array_slice, sample_pos_ndx);
    // The pyramid is cut at the base mip level and the array at the base slice, so the
    // view the reference samples is the one the descriptor actually exposes.
    let whole = source_images[src][base_mip_level as usize].get_const_access();
    let [w, h, d] = whole.size();

    if is_image_view_type_1d(view_type) {
        let level0 = whole.get_subregion(0, base_array_slice, 0, w, h - base_array_slice, d);
        tcu::pixel::Texture1DArrayView { level0 }.sample(sampler, pos[0], pos[1])
    } else if is_image_view_type_2d(view_type) {
        let level0 = whole.get_subregion(0, 0, base_array_slice, w, h, d - base_array_slice);
        tcu::pixel::Texture2DArrayView { level0 }.sample(sampler, pos[0], pos[1], pos[2])
    } else if is_image_view_type_cube(view_type) {
        let level0 = whole.get_subregion(0, 0, base_array_slice * 6, w, h, d - base_array_slice * 6);
        tcu::pixel::TextureCubeArrayView { level0 }.sample(sampler, pos[0], pos[1], pos[2], pos[3])
    } else {
        tcu::pixel::Texture3DView { level0: whole }.sample(sampler, pos[0], pos[1], pos[2])
    }
}

// ---------------------------------------------------------------------------------
// Descriptor update templates
// ---------------------------------------------------------------------------------

/// `RawUpdateRegistry` - the blob a descriptor update template reads from. Entries
/// point into it by byte offset, so the objects have to be laid down in the order the
/// entries are built and kept alive until the update has happened.
#[derive(Default)]
struct RawUpdateRegistry {
    data: Vec<u8>,
    offsets: Vec<usize>,
}

impl RawUpdateRegistry {
    fn add_write_object<T: Copy>(&mut self, object: T) {
        self.offsets.push(self.data.len());
        let bytes = unsafe { std::slice::from_raw_parts(std::ptr::from_ref(&object).cast::<u8>(), std::mem::size_of::<T>()) };
        self.data.extend_from_slice(bytes);
    }

    fn write_object_offset(&self, object_id: usize) -> usize {
        self.offsets[object_id]
    }

    fn raw_pointer(&self) -> *const std::ffi::c_void {
        self.data.as_ptr().cast()
    }
}

/// `createTemplateBinding`
fn create_template_binding(
    binding: u32,
    array_element: u32,
    descriptor_count: u32,
    descriptor_type: vk::DescriptorType,
    offset: usize,
    stride: usize,
) -> vk::DescriptorUpdateTemplateEntry {
    vk::DescriptorUpdateTemplateEntry {
        dst_binding: binding,
        dst_array_element: array_element,
        descriptor_count,
        descriptor_type,
        offset,
        stride,
    }
}

/// `vk::createDescriptorUpdateTemplate` and the update that follows it.
///
/// The entry point is picked by whether the device still advertises the extension: a
/// 1.0 driver only has the KHR name loaded, a 1.1+ driver that dropped the string only
/// has the core one. `require_device_functionality` accepts both, so this has to too.
/// `m_updateTemplates` + `m_updateRegistry` - a pushed template is referenced by the
/// command buffer, not consumed when it is recorded, so both the template and the data
/// it points at have to outlive submission. Upstream keeps them as instance members
/// for exactly that reason; this is the same thing scoped to one call.
struct TemplateKeepAlive<'a> {
    device: &'a Device,
    template: vk::DescriptorUpdateTemplate,
    use_khr: bool,
    _registry: RawUpdateRegistry,
}

impl Drop for TemplateKeepAlive<'_> {
    fn drop(&mut self) {
        use vulkanalia::vk::{DeviceV1_1, KhrDescriptorUpdateTemplateExtensionDeviceCommands};
        unsafe {
            if self.use_khr {
                self.device.destroy_descriptor_update_template_khr(self.template, None);
            } else {
                self.device.destroy_descriptor_update_template(self.template, None);
            }
        }
    }
}

fn update_descriptor_set_with_template<'a>(
    context: &'a Context,
    entries: &[vk::DescriptorUpdateTemplateEntry],
    layout: vk::DescriptorSetLayout,
    target: DescriptorTarget,
    pipeline_layout: vk::PipelineLayout,
    registry: RawUpdateRegistry,
) -> Result<Option<TemplateKeepAlive<'a>>, TestError> {
    use vulkanalia::vk::{DeviceV1_1, KhrDescriptorUpdateTemplateExtensionDeviceCommands};

    let device = context.get_device();
    let set = target.set();
    // The layout a plain template is built against must be the one its target set was
    // allocated from, so it comes from the target rather than from a separate argument
    // that could name a different set's layout. A push template names no set and keeps
    // the layout it was handed.
    let layout = match target {
        DescriptorTarget::Set { layout, .. } => layout,
        DescriptorTarget::Push { .. } => layout,
    };
    // A push template names the pipeline layout and the bind point it will be pushed
    // at; a plain one names the descriptor set layout it will write through.
    let (template_type, bind_point) = match target {
        DescriptorTarget::Set { .. } => (vk::DescriptorUpdateTemplateType::DESCRIPTOR_SET, vk::PipelineBindPoint::COMPUTE),
        DescriptorTarget::Push { bind_point, .. } => (vk::DescriptorUpdateTemplateType::PUSH_DESCRIPTORS, bind_point),
    };
    let mut info = vk::DescriptorUpdateTemplateCreateInfo::builder()
        .descriptor_update_entries(entries)
        .template_type(template_type)
        .descriptor_set_layout(layout)
        .pipeline_bind_point(bind_point);
    if let DescriptorTarget::Push { set_ndx, .. } = target {
        info = info.pipeline_layout(pipeline_layout).set(set_ndx);
    }

    let use_khr = context.get_device_extensions().iter().any(|e| e == "VK_KHR_descriptor_update_template");
    let handle = unsafe {
        if use_khr {
            device.create_descriptor_update_template_khr(&info, None)
        } else {
            device.create_descriptor_update_template(&info, None)
        }
    }
    .vk_check("vkCreateDescriptorUpdateTemplate")?;

    // The template is consumed by the update and nothing refers to it afterwards, so
    // it is destroyed here rather than being tied to the instance's lifetime.
    match target {
        // A plain update is done by the time the call returns, so nothing has to be
        // kept: the template is destroyed here as before.
        DescriptorTarget::Set { .. } => {
            unsafe {
                if use_khr {
                    device.update_descriptor_set_with_template_khr(set, handle, registry.raw_pointer());
                } else {
                    device.update_descriptor_set_with_template(set, handle, registry.raw_pointer());
                }
                if use_khr {
                    device.destroy_descriptor_update_template_khr(handle, None);
                } else {
                    device.destroy_descriptor_update_template(handle, None);
                }
            }
            Ok(None)
        }
        DescriptorTarget::Push { cmd, set_ndx: push_set, .. } => {
            unsafe {
                vulkanalia::vk::KhrPushDescriptorExtensionDeviceCommands::cmd_push_descriptor_set_with_template_khr(
                    device,
                    cmd,
                    handle,
                    pipeline_layout,
                    push_set,
                    registry.raw_pointer(),
                );
            }
            Ok(Some(TemplateKeepAlive {
                device,
                template: handle,
                use_khr,
                _registry: registry,
            }))
        }
    }
}

impl BufferAccessInstance<'_> {
    /// `BufferComputeInstance::writeDescriptorSetWithTemplate`. The entries mirror
    /// `write_descriptor_set`'s bindings exactly; only the way the driver is handed
    /// the contents differs.
    #[allow(clippy::too_many_arguments)]
    fn write_descriptor_set_with_template(
        &self,
        target: DescriptorTarget,
        layout: vk::DescriptorSetLayout,
        pipeline_layout: vk::PipelineLayout,
        set_ndx: u32,
        view_a: vk::Buffer,
        offset_a: u32,
        view_b: vk::Buffer,
        offset_b: u32,
        result: vk::Buffer,
    ) -> Result<Option<TemplateKeepAlive<'_>>, TestError> {
        let range = std::mem::size_of::<[f32; 8]>() as u64;
        let buffer_infos = [
            vk::DescriptorBufferInfo {
                buffer: view_a,
                offset: u64::from(offset_a),
                range,
            },
            vk::DescriptorBufferInfo {
                buffer: view_b,
                offset: u64::from(offset_b),
                range,
            },
        ];

        let mut registry = RawUpdateRegistry::default();
        if set_ndx == 0 && self.params.is_compute() {
            registry.add_write_object(vk::DescriptorBufferInfo {
                buffer: result,
                offset: 0,
                range: RESULT_DATA_SIZE,
            });
        }
        registry.add_write_object(buffer_infos[0]);
        registry.add_write_object(buffer_infos[1]);

        let entries = self.template_entries(set_ndx, &registry, std::mem::size_of::<vk::DescriptorBufferInfo>());
        update_descriptor_set_with_template(self.context, &entries, layout, target, pipeline_layout, registry)
    }

    /// `writeDescriptorSetWithTemplate`'s switch, which is the same for the plain and
    /// the texel buffer types and differs from `write_descriptor_set` only in that the
    /// binding is described rather than written.
    fn template_entries(&self, set_ndx: u32, registry: &RawUpdateRegistry, info_size: usize) -> Vec<vk::DescriptorUpdateTemplateEntry> {
        let p = self.params;
        let mut entries = Vec::new();
        let mut binding = 0;
        let mut object = 0;

        if set_ndx == 0 && self.params.is_compute() {
            entries.push(create_template_binding(
                binding,
                0,
                1,
                vk::DescriptorType::STORAGE_BUFFER,
                registry.write_object_offset(object),
                0,
            ));
            binding += 1;
            object += 1;
        }

        match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => {
                entries.push(create_template_binding(binding, 0, 1, p.descriptor_type, registry.write_object_offset(object), 0));
            }
            ShaderInputInterface::MultipleContiguousDescriptors => {
                entries.push(create_template_binding(binding, 0, 1, p.descriptor_type, registry.write_object_offset(object), 0));
                entries.push(create_template_binding(binding + 1, 0, 1, p.descriptor_type, registry.write_object_offset(object + 1), 0));
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                entries.push(create_template_binding(binding, 0, 1, p.descriptor_type, registry.write_object_offset(object), 0));
                entries.push(create_template_binding(binding + 2, 0, 1, p.descriptor_type, registry.write_object_offset(object + 1), 0));
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                entries.push(create_template_binding(
                    arbitrary_binding_index(0),
                    0,
                    1,
                    p.descriptor_type,
                    registry.write_object_offset(object),
                    0,
                ));
                entries.push(create_template_binding(
                    arbitrary_binding_index(1),
                    0,
                    1,
                    p.descriptor_type,
                    registry.write_object_offset(object + 1),
                    0,
                ));
            }
            // One entry covering both, which is why the two infos have to sit next to
            // each other in the blob and the stride is the info's own size.
            ShaderInputInterface::DescriptorArray => {
                entries.push(create_template_binding(binding, 0, 2, p.descriptor_type, registry.write_object_offset(object), info_size));
            }
        }

        entries
    }

    /// `TexelBufferComputeInstance::writeDescriptorSetWithTemplate`
    #[allow(clippy::too_many_arguments)]
    fn write_texel_descriptor_set_with_template(
        &self,
        target: DescriptorTarget,
        layout: vk::DescriptorSetLayout,
        pipeline_layout: vk::PipelineLayout,
        set_ndx: u32,
        view_a: vk::BufferView,
        view_b: vk::BufferView,
        result: vk::Buffer,
    ) -> Result<Option<TemplateKeepAlive<'_>>, TestError> {
        let mut registry = RawUpdateRegistry::default();
        if set_ndx == 0 && self.params.is_compute() {
            registry.add_write_object(vk::DescriptorBufferInfo {
                buffer: result,
                offset: 0,
                range: RESULT_DATA_SIZE,
            });
        }
        registry.add_write_object(view_a);
        registry.add_write_object(view_b);

        let entries = self.template_entries(set_ndx, &registry, std::mem::size_of::<vk::BufferView>());
        update_descriptor_set_with_template(self.context, &entries, layout, target, pipeline_layout, registry)
    }
}

impl ImageAccessInstance<'_> {
    /// `ImageFetchComputeInstance::writeDescriptorSetWithTemplate`,
    /// `ImageSampleComputeInstance::writeSamplerDescriptorSetWithTemplate` and
    /// `writeImageSamplerDescriptorSetWithTemplate`, which describe exactly the
    /// bindings `write_descriptor_set` writes.
    #[allow(clippy::too_many_arguments)]
    fn write_descriptor_set_with_template(
        &self,
        target: DescriptorTarget,
        layout: vk::DescriptorSetLayout,
        pipeline_layout: vk::PipelineLayout,
        set_ndx: u32,
        view_a: vk::ImageView,
        view_b: vk::ImageView,
        samplers: &[vk::Sampler],
        result: vk::Buffer,
    ) -> Result<Option<TemplateKeepAlive<'_>>, TestError> {
        let p = self.params;
        let image_layout = image_layout_for_descriptor_type(p.descriptor_type);
        let is_separate_sampler = p.descriptor_type == vk::DescriptorType::SAMPLER;

        let combined_sampler = |ndx: u32| -> vk::Sampler {
            if p.is_immutable_sampler || samplers.is_empty() {
                vk::Sampler::null()
            } else {
                samplers[(set_ndx * p.shader_interface.num_resources() + ndx) as usize % samplers.len()]
            }
        };
        let resource_infos = [
            vk::DescriptorImageInfo {
                sampler: if is_separate_sampler {
                    samplers[(set_ndx * p.shader_interface.num_resources()) as usize % samplers.len()]
                } else {
                    combined_sampler(0)
                },
                image_view: if is_separate_sampler { vk::ImageView::null() } else { view_a },
                image_layout: if is_separate_sampler { vk::ImageLayout::UNDEFINED } else { image_layout },
            },
            vk::DescriptorImageInfo {
                sampler: if is_separate_sampler {
                    samplers[(set_ndx * p.shader_interface.num_resources() + 1) as usize % samplers.len()]
                } else {
                    combined_sampler(1)
                },
                image_view: if is_separate_sampler { vk::ImageView::null() } else { view_b },
                image_layout: if is_separate_sampler { vk::ImageLayout::UNDEFINED } else { image_layout },
            },
        ];

        let mut registry = RawUpdateRegistry::default();
        if set_ndx == 0 && p.is_compute() {
            registry.add_write_object(vk::DescriptorBufferInfo {
                buffer: result,
                offset: 0,
                range: RESULT_DATA_SIZE,
            });
        }
        if is_separate_sampler {
            registry.add_write_object(vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: view_a,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            });
        }
        registry.add_write_object(resource_infos[0]);
        registry.add_write_object(resource_infos[1]);

        let mut entries = Vec::new();
        let mut binding = 0;
        let mut object = 0;

        if set_ndx == 0 && p.is_compute() {
            entries.push(create_template_binding(
                binding,
                0,
                1,
                vk::DescriptorType::STORAGE_BUFFER,
                registry.write_object_offset(object),
                0,
            ));
            binding += 1;
            object += 1;
        }

        if is_separate_sampler {
            let texture_binding = if p.shader_interface == ShaderInputInterface::MultipleDiscontiguousDescriptors {
                binding + 1
            } else {
                let b = binding;
                binding += 1;
                b
            };
            entries.push(create_template_binding(
                texture_binding,
                0,
                1,
                vk::DescriptorType::SAMPLED_IMAGE,
                registry.write_object_offset(object),
                0,
            ));
            object += 1;
        }

        // An immutable separate sampler is already in the layout; there is nothing to
        // describe, and the objects sitting unused in the blob cost nothing.
        if !(is_separate_sampler && p.is_immutable_sampler) {
            let info_size = std::mem::size_of::<vk::DescriptorImageInfo>();
            match p.shader_interface {
                ShaderInputInterface::SingleDescriptor => {
                    entries.push(create_template_binding(binding, 0, 1, p.descriptor_type, registry.write_object_offset(object), 0));
                }
                ShaderInputInterface::MultipleContiguousDescriptors => {
                    entries.push(create_template_binding(binding, 0, 1, p.descriptor_type, registry.write_object_offset(object), 0));
                    entries.push(create_template_binding(binding + 1, 0, 1, p.descriptor_type, registry.write_object_offset(object + 1), 0));
                }
                ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                    entries.push(create_template_binding(binding, 0, 1, p.descriptor_type, registry.write_object_offset(object), 0));
                    entries.push(create_template_binding(binding + 2, 0, 1, p.descriptor_type, registry.write_object_offset(object + 1), 0));
                }
                ShaderInputInterface::MultipleArbitraryDescriptors => {
                    entries.push(create_template_binding(
                        arbitrary_binding_index(0),
                        0,
                        1,
                        p.descriptor_type,
                        registry.write_object_offset(object),
                        0,
                    ));
                    entries.push(create_template_binding(
                        arbitrary_binding_index(1),
                        0,
                        1,
                        p.descriptor_type,
                        registry.write_object_offset(object + 1),
                        0,
                    ));
                }
                ShaderInputInterface::DescriptorArray => {
                    entries.push(create_template_binding(binding, 0, 2, p.descriptor_type, registry.write_object_offset(object), info_size));
                }
            }
        }

        update_descriptor_set_with_template(self.context, &entries, layout, target, pipeline_layout, registry)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The discontiguous arrangement is the reason a descriptor set index may not be
    /// used to index a pipeline-layout-shaped list: set 1 of two lives in slot 2, and
    /// slot 1 holds an unused layout. Building a descriptor update template against
    /// that unused layout makes the driver walk the update data with the wrong
    /// strides - it reads off the end of the registry and writes garbage descriptors,
    /// which shows up as a segfault inside the driver or a GPU hang rather than as a
    /// test failure.
    #[test]
    fn discontiguous_set_index_is_not_a_layout_index() {
        assert_eq!(DescriptorSetCount::MultipleDiscontiguous.set_ndx(0), 0);
        assert_eq!(DescriptorSetCount::MultipleDiscontiguous.set_ndx(1), 2);
        assert_eq!(DescriptorSetCount::MultipleDiscontiguous.count(), 2);

        // The contiguous arrangements are the ones where the two indices coincide,
        // which is why the hazard stayed invisible until a discontiguous case ran.
        for ndx in 0..DescriptorSetCount::Multiple.count() {
            assert_eq!(DescriptorSetCount::Multiple.set_ndx(ndx), ndx);
        }
        assert_eq!(DescriptorSetCount::Single.set_ndx(0), 0);
    }
}
