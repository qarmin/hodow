// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Mobica Limited.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `basic`, `resume` and
// `draw_outside` test types of the `simple` group are ported, in the monolithic pipeline
// construction and, for the vertex-only pipelines, the graphics pipeline library ones (`construction.rs`); every other type needs shaders or device features this port does not
// have yet (geometry/tessellation permutations, streams, queries, multiview, indirect draws,
// VK_KHR_device_address_commands). The device-address variants are left out with them.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::{IVec2, Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::device_address_commands::{
    self, ADDRESS_COMMAND_FULLY_BOUND, ADDRESS_COMMAND_TRANSFORM_FEEDBACK_BUFFER_USAGE,
    ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE, BindTransformFeedbackBuffer2Info, Commands,
    DeviceAddressRange, buffer_device_address, load_commands,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info,
    make_buffer_memory_barrier, make_command_pool, make_framebuffer, make_graphics_pipeline_staged,
    make_memory_barrier, make_pipeline_layout as make_plain_pipeline_layout, make_render_pass,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, PipelineParts, create_linked_pipeline};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `MINIMUM_TF_BUFFER_SIZE`
pub(super) const MINIMUM_TF_BUFFER_SIZE: u32 = 1 << 27;
/// `IMAGE_SIZE`
pub(super) const IMAGE_SIZE: u32 = 64;
/// `kVec4Components`
const VEC4_COMPONENTS: u32 = 4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Basic,
    Resume,
    XfbPointSize,
    XfbClipDistance,
    XfbCullDistance,
    XfbClipAndCull,
    DrawOutside,
    HolesVertex,
    HolesGeometry,
    MaxOutputComponents,
}

/// The fields of `TestParameters` these test types read.
#[derive(Clone, Copy)]
struct TestParameters {
    test_type: TestType,
    buffer_size: u32,
    part_count: u32,
    stream_id: u32,
    null_counter_buffers: bool,
    null_ptrs_in_end_transform_feedback: bool,
    use_maintenance5: bool,
    use_device_address_commands: bool,
}

struct TransformFeedbackTestCase {
    name: String,
    parameters: TestParameters,
    programs: BinaryCollection,
}

impl TestCase for TransformFeedbackTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`, for these test types.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if xfb_features.transform_feedback == vk::FALSE {
            return Err(TestError::NotSupported(
                "transformFeedback feature is not supported".to_string(),
            ));
        }

        if self.parameters.use_device_address_commands {
            context.require_device_functionality(device_address_commands::EXTENSION_NAME)?;
        }

        if self.parameters.use_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if self.parameters.stream_id > 0 {
            let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            // transformFeedbackRasterizationStreamSelect is required when vertex streams other than zero are rasterized
            if xfb_properties.transform_feedback_rasterization_stream_select == vk::FALSE {
                return Err(TestError::NotSupported(
                    "transformFeedbackRasterizationStreamSelect property is not supported".to_string(),
                ));
            }
        }

        if self.parameters.test_type == TestType::HolesGeometry
            && context.get_device_features().geometry_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "geometryShader feature is not supported".to_string(),
            ));
        }

        if self.parameters.test_type == TestType::MaxOutputComponents {
            let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };

            let max_comps = context.get_device_properties().limits.max_vertex_output_components;
            let total_comps = (self.parameters.part_count + 1/*gl_Position*/) * VEC4_COMPONENTS;

            if total_comps > max_comps {
                return Err(TestError::NotSupported(
                    "Required number of output components not supported".to_string(),
                ));
            }

            let comp_size = std::mem::size_of::<f32>() as u32;
            let per_vertex_size = total_comps * comp_size;
            let message_prefix = format!("Required vertex data size ({per_vertex_size}) greater than ");

            if per_vertex_size > xfb_properties.max_transform_feedback_buffer_data_size {
                return Err(TestError::NotSupported(format!(
                    "{message_prefix}maxTransformFeedbackBufferDataSize"
                )));
            }

            if per_vertex_size > xfb_properties.max_transform_feedback_stream_data_size {
                return Err(TestError::NotSupported(format!(
                    "{message_prefix}maxTransformFeedbackStreamDataSize"
                )));
            }

            if per_vertex_size > xfb_properties.max_transform_feedback_buffer_data_stride {
                return Err(TestError::NotSupported(format!(
                    "{message_prefix}maxTransformFeedbackBufferDataStride"
                )));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TransformFeedbackTestInstance {
            context,
            parameters: self.parameters,
            rnd: Random::new(0),
        })
    }
}

/// A buffer whose usage is given in a `VkBufferUsageFlags2CreateInfo` chained on, with `usage` left zero, when `use_maintenance5` is set
/// (`bufferUsageFlags2` of the resume instance).
fn create_buffer_with_usage<'a>(
    device: &'a Device,
    allocator: &crate::vk::mem_util::SimpleAllocator,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    requirement: MemoryRequirement,
    use_maintenance5: bool,
) -> Result<BufferWithMemory<'a>, TestError> {
    let mut info = make_buffer_create_info(size, usage);
    let usage2 = vk::BufferUsageFlags2CreateInfo::builder()
        .usage(vk::BufferUsageFlags2::from_bits_truncate(u64::from(usage.bits())));
    if use_maintenance5 {
        info.next = (&*usage2 as *const vk::BufferUsageFlags2CreateInfo).cast::<c_void>();
        info.usage = vk::BufferUsageFlags::empty();
    }
    BufferWithMemory::new(device, allocator, info, requirement)
}

/// `TransformFeedbackTestInstance::validateLimits`, with the properties struct that the upstream constructor reads.
pub(super) fn validate_limits(
    context: &Context<'_>,
) -> Result<vk::PhysicalDeviceTransformFeedbackPropertiesEXT, TestError> {
    let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };

    let validate_minimum = |name: &str, a: u64, b: u64| -> Result<(), TestError> {
        if a < b {
            return Err(TestError::Fail(format!(
                "{name}=={a} which is less than required by specification ({b})"
            )));
        }
        Ok(())
    };
    let validate_bool = |name: &str, a: vk::Bool32| -> Result<(), TestError> {
        if !(a == vk::TRUE || a == vk::FALSE) {
            return Err(TestError::Fail(format!(
                "{name} expected to be VK_TRUE or VK_FALSE. Received {a}"
            )));
        }
        Ok(())
    };

    validate_minimum(
        "maxTransformFeedbackBuffers",
        xfb_properties.max_transform_feedback_buffers as u64,
        1,
    )?;
    validate_minimum(
        "maxTransformFeedbackBufferSize",
        xfb_properties.max_transform_feedback_buffer_size,
        MINIMUM_TF_BUFFER_SIZE as u64,
    )?;
    validate_minimum(
        "maxTransformFeedbackStreamDataSize",
        xfb_properties.max_transform_feedback_stream_data_size as u64,
        512,
    )?;
    validate_minimum(
        "maxTransformFeedbackBufferDataSize",
        xfb_properties.max_transform_feedback_buffer_data_size as u64,
        512,
    )?;
    validate_minimum(
        "maxTransformFeedbackBufferDataStride",
        xfb_properties.max_transform_feedback_buffer_data_stride as u64,
        512,
    )?;

    validate_bool("transformFeedbackQueries", xfb_properties.transform_feedback_queries)?;
    validate_bool(
        "transformFeedbackStreamsLinesTriangles",
        xfb_properties.transform_feedback_streams_lines_triangles,
    )?;
    validate_bool(
        "transformFeedbackRasterizationStreamSelect",
        xfb_properties.transform_feedback_rasterization_stream_select,
    )?;
    validate_bool("transformFeedbackDraw", xfb_properties.transform_feedback_draw)?;
    Ok(xfb_properties)
}

/// `TransformFeedbackTestInstance` and the three instances derived from it.
struct TransformFeedbackTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TestParameters,
    /// `m_rnd` - seeded with the command line's base seed, which defaults to 0.
    rnd: Random,
}

impl TransformFeedbackTestInstance<'_> {
    /// `validateLimits` (the properties struct is read in the upstream constructor); returns
    /// the properties it read, `m_transformFeedbackProperties`.
    fn validate_limits(&self) -> Result<vk::PhysicalDeviceTransformFeedbackPropertiesEXT, TestError> {
        validate_limits(self.context)
    }

    /// `generateSizesList`
    fn generate_sizes_list(&mut self, buf_bytes: usize, chunk_count: usize) -> Vec<vk::DeviceSize> {
        let min_chunk_slot = 1i32;
        let max_chunk_slot = (buf_bytes / std::mem::size_of::<u32>()) as i32;
        let mut prev_offset_slot = 0i32;
        let mut offsets_set: std::collections::BTreeSet<i32> = std::collections::BTreeSet::new();
        let mut result: Vec<vk::DeviceSize> = Vec::new();

        debug_assert!(buf_bytes <= MINIMUM_TF_BUFFER_SIZE as usize);
        debug_assert!(buf_bytes.is_multiple_of(std::mem::size_of::<u32>()));
        debug_assert!(min_chunk_slot <= max_chunk_slot);
        debug_assert!(chunk_count > 0);
        // To be effective this algorithm requires that chunkCount is much less than amount of chunks possible
        debug_assert!(8 * chunk_count <= max_chunk_slot as usize);

        offsets_set.insert(0);

        // Create a list of unique offsets first
        for _chunk_ndx in 1..chunk_count {
            let mut chunk_slot;

            loop {
                chunk_slot = self.rnd.get_int(min_chunk_slot, max_chunk_slot - 1);
                if !offsets_set.contains(&chunk_slot) {
                    break;
                }
            }

            offsets_set.insert(chunk_slot);
        }
        offsets_set.insert(max_chunk_slot);

        // Calculate sizes of offsets list
        result.reserve(chunk_count);
        for &offset_slot in &offsets_set {
            if offset_slot == 0 {
                continue;
            }

            debug_assert!(prev_offset_slot < offset_slot && offset_slot > 0);

            result.push(((offset_slot - prev_offset_slot) as usize * std::mem::size_of::<u32>()) as vk::DeviceSize);

            prev_offset_slot = offset_slot;
        }

        debug_assert!(result.len() == chunk_count);

        result
    }

    /// `generateOffsetsList`
    fn generate_offsets_list(sizes_list: &[vk::DeviceSize]) -> Vec<vk::DeviceSize> {
        let mut offset = 0u64;
        let mut result = Vec::with_capacity(sizes_list.len());

        for size in sizes_list {
            result.push(offset);

            offset += size;
        }

        debug_assert!(sizes_list.len() == result.len());

        result
    }

    /// `verifyTransformFeedbackBuffer`
    fn verify_transform_feedback_buffer(&self, buf_alloc: &Allocation<'_>, buf_bytes: u32) -> Result<(), TestError> {
        let device = self.context.get_device();
        let num_points = buf_bytes as usize / std::mem::size_of::<u32>();
        invalidate_alloc(device, buf_alloc)?;
        let tf_data = buf_alloc.get_host_ptr().cast_const().cast::<u32>();

        for i in 0..num_points {
            let received = unsafe { *tf_data.add(i) };
            if received != i as u32 {
                return Err(TestError::Fail(format!(
                    "Failed at item {i} received:{received} expected:{i}"
                )));
            }
        }
        Ok(())
    }
}

/// `makeRenderPass(vk, device, VK_FORMAT_UNDEFINED)` - no attachments, one subpass.
pub(super) fn make_attachmentless_render_pass(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let subpass = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let info = vk::RenderPassCreateInfo::builder().subpasses(&subpass);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `TransformFeedback::makePipelineLayout` - one vertex-stage push constant.
pub(super) fn make_pipeline_layout(device: &Device) -> Result<Unique<'_, vk::PipelineLayout>, TestError> {
    let push_constant_ranges = [vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::VERTEX,
        offset: 0,
        size: std::mem::size_of::<u32>() as u32,
    }];
    let info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
    Ok(Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
    ))
}

/// `TransformFeedback::makeGraphicsPipeline`, vertex stage only: rasteriser discard on (there
/// is no fragment shader) with the rasterization stream chained, point list, no vertex input.
fn make_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    rasterization_stream: u32,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let render_size = (IMAGE_SIZE, IMAGE_SIZE);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: render_size.0 as f32,
        height: render_size.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, render_size.0, render_size.1)];

    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
    let disable_rasterization = true;

    let rasterization_state_stream_create_info = vk::PipelineRasterizationStateStreamCreateInfoEXT {
        s_type: vk::StructureType::PIPELINE_RASTERIZATION_STATE_STREAM_CREATE_INFO_EXT,
        next: std::ptr::null(),
        flags: vk::PipelineRasterizationStateStreamCreateFlagsEXT::empty(),
        rasterization_stream,
    };
    let rasterization_state_create_info = vk::PipelineRasterizationStateCreateInfo {
        s_type: vk::StructureType::PIPELINE_RASTERIZATION_STATE_CREATE_INFO,
        next: (&rasterization_state_stream_create_info as *const vk::PipelineRasterizationStateStreamCreateInfoEXT)
            .cast::<c_void>(),
        flags: vk::PipelineRasterizationStateCreateFlags::empty(),
        depth_clamp_enable: vk::FALSE,
        rasterizer_discard_enable: disable_rasterization as vk::Bool32,
        polygon_mode: vk::PolygonMode::FILL,
        cull_mode: vk::CullModeFlags::NONE,
        front_face: vk::FrontFace::COUNTER_CLOCKWISE,
        depth_bias_enable: vk::FALSE,
        depth_bias_constant_factor: 0.0,
        depth_bias_clamp: 0.0,
        depth_bias_slope_factor: 0.0,
        line_width: 1.0,
    };

    let entry = c"main";
    let stages = [vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::VERTEX)
        .module(vertex_module)
        .name(entry.to_bytes_with_nul())
        .build()];
    let input_assembly =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::POINT_LIST);
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().logic_op(vk::LogicOp::CLEAR);

    let construction = super::construction::ambient_construction_type();
    if construction != PipelineConstructionType::Monolithic {
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::default();
        let parts = PipelineParts {
            flags: vk::PipelineCreateFlags::empty(),
            layout: pipeline_layout,
            render_pass,
            subpass: 0,
            stages: &stages,
            vertex_input: &vertex_input,
            input_assembly: &input_assembly,
            tessellation: None,
            viewport: &viewport_state,
            rasterization: &rasterization_state_create_info,
            multisample: &multisample,
            depth_stencil: &depth_stencil,
            color_blend: Some(&color_blend),
            dynamic: None,
            rendering: None,
            fragment_shading_rate: None,
        };
        return create_linked_pipeline(device, construction, &parts);
    }

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state_create_info)
        .multisample_state(&multisample)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// The max_output_components pipeline: vertex stage only with a `vec4` position attribute, a
/// triangle list and rasterization left enabled (no stream chained), as upstream passes its own
/// rasterization state there.
fn make_vertex_input_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    render_size: (u32, u32),
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: render_size.0 as f32,
        height: render_size.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, render_size.0, render_size.1)];

    let bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<[f32; 4]>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);

    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);

    let entry = c"main";
    let stages = [vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::VERTEX)
        .module(vertex_module)
        .name(entry.to_bytes_with_nul())
        .build()];
    let input_assembly =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().logic_op(vk::LogicOp::CLEAR);

    let construction = super::construction::ambient_construction_type();
    if construction != PipelineConstructionType::Monolithic {
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::default();
        let parts = PipelineParts {
            flags: vk::PipelineCreateFlags::empty(),
            layout: pipeline_layout,
            render_pass,
            subpass: 0,
            stages: &stages,
            vertex_input: &vertex_input,
            input_assembly: &input_assembly,
            tessellation: None,
            viewport: &viewport_state,
            rasterization: &rasterization,
            multisample: &multisample,
            depth_stencil: &depth_stencil,
            color_blend: Some(&color_blend),
            dynamic: None,
            rendering: None,
            fragment_shading_rate: None,
        };
        return create_linked_pipeline(device, construction, &parts);
    }

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `vkCmdBeginTransformFeedbackEXT` with the counter buffer arrays given as raw pointers,
/// because the null-array forms are exactly what two of the cases exercise.
unsafe fn cmd_begin_transform_feedback_raw(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    first_counter_buffer: u32,
    counter_buffer_count: u32,
    counter_buffers: *const vk::Buffer,
    counter_buffer_offsets: *const vk::DeviceSize,
) {
    unsafe {
        (device.commands().cmd_begin_transform_feedback_ext)(
            cmd_buffer,
            first_counter_buffer,
            counter_buffer_count,
            counter_buffers,
            counter_buffer_offsets,
        )
    };
}

/// `vkCmdEndTransformFeedbackEXT`, raw for the same reason.
unsafe fn cmd_end_transform_feedback_raw(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    first_counter_buffer: u32,
    counter_buffer_count: u32,
    counter_buffers: *const vk::Buffer,
    counter_buffer_offsets: *const vk::DeviceSize,
) {
    unsafe {
        (device.commands().cmd_end_transform_feedback_ext)(
            cmd_buffer,
            first_counter_buffer,
            counter_buffer_count,
            counter_buffers,
            counter_buffer_offsets,
        )
    };
}

/// The `cmd*TransformFeedback*` wrappers of `TransformFeedbackTestInstance`: the plain EXT commands, or the device address ones when the
/// parameters ask for `useDeviceAddressCommands`.
pub(super) struct AddressCommands(Option<Commands>);

impl AddressCommands {
    pub(super) fn new(context: &Context<'_>, enabled: bool) -> Result<Self, TestError> {
        Ok(Self(if enabled { Some(load_commands(context)?) } else { None }))
    }

    pub(super) fn enabled(&self) -> bool {
        self.0.is_some()
    }

    pub(super) fn usage(&self, usage: vk::BufferUsageFlags) -> vk::BufferUsageFlags {
        if self.enabled() {
            usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
        } else {
            usage
        }
    }

    pub(super) fn requirement(&self, requirement: MemoryRequirement) -> MemoryRequirement {
        if self.enabled() {
            requirement | MemoryRequirement::DEVICE_ADDRESS
        } else {
            requirement
        }
    }

    /// `getBufferDeviceAddress` when the device address commands are used, zero otherwise.
    pub(super) fn address(&self, device: &Device, buffer: vk::Buffer) -> vk::DeviceAddress {
        if self.enabled() {
            buffer_device_address(device, buffer)
        } else {
            0
        }
    }

    /// `cmdBindTransformFeedbackBuffers`
    pub(super) unsafe fn bind_buffers(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        first_binding: u32,
        buffers: &[vk::Buffer],
        addresses: &[vk::DeviceAddress],
        offsets: &[vk::DeviceSize],
        sizes: &[vk::DeviceSize],
    ) {
        let Some(commands) = &self.0 else {
            unsafe {
                device.cmd_bind_transform_feedback_buffers_ext(cmd_buffer, first_binding, buffers, offsets, sizes)
            };
            return;
        };

        // use different valid addressFlags in some cases to test them
        let address_flags = if buffers.len() == 1 {
            ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE
        } else {
            ADDRESS_COMMAND_TRANSFORM_FEEDBACK_BUFFER_USAGE
        };
        let binding_infos: Vec<BindTransformFeedbackBuffer2Info> = (0..buffers.len())
            .map(|i| {
                BindTransformFeedbackBuffer2Info::new(
                    DeviceAddressRange {
                        address: addresses[i] + offsets[i],
                        size: sizes[i],
                    },
                    address_flags,
                )
            })
            .collect();
        let function = commands
            .bind_transform_feedback_buffers2
            .expect("VK_EXT_transform_feedback is enabled next to VK_KHR_device_address_commands");
        unsafe { function(cmd_buffer, first_binding, buffers.len() as u32, binding_infos.as_ptr()) };
    }

    fn counter_infos(
        count: u32,
        addresses: *const vk::DeviceAddress,
        offsets: *const vk::DeviceSize,
        sizes: *const vk::DeviceSize,
        address_flags: u32,
    ) -> Vec<BindTransformFeedbackBuffer2Info> {
        (0..count as usize)
            .map(|i| {
                BindTransformFeedbackBuffer2Info::new(
                    DeviceAddressRange {
                        address: unsafe { *addresses.add(i) + *offsets.add(i) },
                        size: unsafe { *sizes.add(i) },
                    },
                    address_flags,
                )
            })
            .collect()
    }

    /// `cmdBeginTransformFeedback`; the counter arrays may be null where the count is zero.
    #[allow(clippy::too_many_arguments)]
    pub(super) unsafe fn begin(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        first_counter_buffer: u32,
        counter_buffer_count: u32,
        counter_buffers: *const vk::Buffer,
        counter_addresses: *const vk::DeviceAddress,
        counter_offsets: *const vk::DeviceSize,
        counter_sizes: *const vk::DeviceSize,
    ) {
        let Some(commands) = &self.0 else {
            unsafe {
                cmd_begin_transform_feedback_raw(
                    device,
                    cmd_buffer,
                    first_counter_buffer,
                    counter_buffer_count,
                    counter_buffers,
                    counter_offsets,
                )
            };
            return;
        };

        let counter_infos = Self::counter_infos(
            counter_buffer_count,
            counter_addresses,
            counter_offsets,
            counter_sizes,
            ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE | ADDRESS_COMMAND_FULLY_BOUND,
        );
        let function = commands
            .begin_transform_feedback2
            .expect("VK_EXT_transform_feedback is enabled next to VK_KHR_device_address_commands");
        unsafe {
            function(
                cmd_buffer,
                first_counter_buffer,
                counter_buffer_count,
                counter_infos.as_ptr(),
            )
        };
    }

    /// `cmdEndTransformFeedback`
    #[allow(clippy::too_many_arguments)]
    pub(super) unsafe fn end(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        first_counter_buffer: u32,
        counter_buffer_count: u32,
        counter_buffers: *const vk::Buffer,
        counter_addresses: *const vk::DeviceAddress,
        counter_offsets: *const vk::DeviceSize,
        counter_sizes: *const vk::DeviceSize,
    ) {
        let Some(commands) = &self.0 else {
            unsafe {
                cmd_end_transform_feedback_raw(
                    device,
                    cmd_buffer,
                    first_counter_buffer,
                    counter_buffer_count,
                    counter_buffers,
                    counter_offsets,
                )
            };
            return;
        };

        let counter_infos = Self::counter_infos(
            counter_buffer_count,
            counter_addresses,
            counter_offsets,
            counter_sizes,
            ADDRESS_COMMAND_TRANSFORM_FEEDBACK_BUFFER_USAGE | ADDRESS_COMMAND_FULLY_BOUND,
        );
        let function = commands
            .end_transform_feedback2
            .expect("VK_EXT_transform_feedback is enabled next to VK_KHR_device_address_commands");
        unsafe {
            function(
                cmd_buffer,
                first_counter_buffer,
                counter_buffer_count,
                counter_infos.as_ptr(),
            )
        };
    }

    /// `cmdDrawIndirectCount`
    #[allow(clippy::too_many_arguments)]
    pub(super) unsafe fn draw_indirect_count(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        buffer: vk::Buffer,
        buffer_address: vk::DeviceAddress,
        offset: vk::DeviceSize,
        size: vk::DeviceSize,
        count_buffer: vk::Buffer,
        count_buffer_address: vk::DeviceAddress,
        count_offset: vk::DeviceSize,
        count_size: vk::DeviceSize,
        max_draw_count: u32,
        stride: u32,
    ) {
        let Some(commands) = &self.0 else {
            unsafe {
                device.cmd_draw_indirect_count(
                    cmd_buffer,
                    buffer,
                    offset,
                    count_buffer,
                    count_offset,
                    max_draw_count,
                    stride,
                )
            };
            return;
        };

        let info = device_address_commands::DrawIndirectCount2Info::new(
            device_address_commands::StridedDeviceAddressRange {
                address: buffer_address + offset,
                size: size - offset,
                stride: stride as vk::DeviceSize,
            },
            DeviceAddressRange {
                address: count_buffer_address + count_offset,
                size: count_size,
            },
            max_draw_count,
        );
        let function = commands
            .draw_indirect_count2
            .expect("VK_KHR_draw_indirect_count is enabled next to VK_KHR_device_address_commands");
        unsafe { function(cmd_buffer, &info) };
    }

    /// `cmdDrawIndirectByteCount`
    #[allow(clippy::too_many_arguments)]
    pub(super) unsafe fn draw_indirect_byte_count(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        instance_count: u32,
        first_instance: u32,
        counter_buffer: vk::Buffer,
        counter_buffer_address: vk::DeviceAddress,
        counter_buffer_offset: vk::DeviceSize,
        counter_buffer_size: vk::DeviceSize,
        counter_offset: u32,
        vertex_stride: u32,
    ) {
        let Some(commands) = &self.0 else {
            unsafe {
                device.cmd_draw_indirect_byte_count_ext(
                    cmd_buffer,
                    instance_count,
                    first_instance,
                    counter_buffer,
                    counter_buffer_offset,
                    counter_offset,
                    vertex_stride,
                )
            };
            return;
        };

        let info = BindTransformFeedbackBuffer2Info::new(
            DeviceAddressRange {
                address: counter_buffer_address + counter_buffer_offset,
                size: counter_buffer_size,
            },
            0,
        );
        let function = commands
            .draw_indirect_byte_count2
            .expect("VK_EXT_transform_feedback is enabled next to VK_KHR_device_address_commands");
        unsafe {
            function(
                cmd_buffer,
                instance_count,
                first_instance,
                &info,
                counter_offset,
                vertex_stride,
            )
        };
    }
}

impl TestInstance for TransformFeedbackTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // The holes and max_output_components instances derive from `vkt::TestInstance`
        // directly upstream, so they never run `validateLimits`.
        match self.parameters.test_type {
            TestType::HolesVertex | TestType::HolesGeometry => return self.iterate_holes(),
            TestType::MaxOutputComponents => return self.iterate_max_output_components(),
            _ => {}
        }

        let xfb_properties = self.validate_limits()?;

        match self.parameters.test_type {
            TestType::Basic => self.iterate_basic(),
            TestType::Resume => self.iterate_resume(),
            TestType::XfbPointSize
            | TestType::XfbClipDistance
            | TestType::XfbCullDistance
            | TestType::XfbClipAndCull => self.iterate_builtin(&xfb_properties),
            TestType::DrawOutside => self.iterate_draw_outside(),
            TestType::HolesVertex | TestType::HolesGeometry | TestType::MaxOutputComponents => unreachable!(),
        }
    }
}

impl TransformFeedbackTestInstance<'_> {
    /// `TransformFeedbackBasicTestInstance::iterate`
    fn iterate_basic(&mut self) -> TestOutcome {
        let params = self.parameters;
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let allocator = self.context.get_default_allocator();

        let vertex_module = create_shader_module(vk, self.context.get_binary_collection().get("vert")?)?;
        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let pipeline = make_graphics_pipeline(vk, *pipeline_layout, *render_pass, *vertex_module, params.stream_id)?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let address_commands = AddressCommands::new(self.context, params.use_device_address_commands)?;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                params.buffer_size as u64,
                address_commands
                    .usage(vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            ),
            address_commands.requirement(MemoryRequirement::HOST_VISIBLE),
        )?;
        let tf_buf_device_address = address_commands.address(vk, tf_buf.get());
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let tf_buf_binding_sizes = self.generate_sizes_list(params.buffer_size as usize, params.part_count as usize);
        let tf_buf_binding_offsets = Self::generate_offsets_list(&tf_buf_binding_sizes);

        begin_command_buffer(vk, cmd_buffer)?;
        {
            begin_render_pass(
                vk,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE),
                zero_clear_value(),
            );
            unsafe {
                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                for draw_ndx in 0..params.part_count as usize {
                    let start_value = (tf_buf_binding_offsets[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;
                    let num_points = (tf_buf_binding_sizes[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;

                    address_commands.bind_buffers(
                        vk,
                        cmd_buffer,
                        0,
                        &[tf_buf.get()],
                        &[tf_buf_device_address],
                        &[tf_buf_binding_offsets[draw_ndx]],
                        &[tf_buf_binding_sizes[draw_ndx]],
                    );

                    vk.cmd_push_constants(
                        cmd_buffer,
                        *pipeline_layout,
                        vk::ShaderStageFlags::VERTEX,
                        0,
                        &start_value.to_ne_bytes(),
                    );

                    address_commands.begin(
                        vk,
                        cmd_buffer,
                        0,
                        0,
                        std::ptr::null(),
                        std::ptr::null(),
                        std::ptr::null(),
                        std::ptr::null(),
                    );
                    {
                        vk.cmd_draw(cmd_buffer, num_points, 1, 0, 0);
                    }
                    address_commands.end(
                        vk,
                        cmd_buffer,
                        0,
                        0,
                        std::ptr::null(),
                        std::ptr::null(),
                        std::ptr::null(),
                        std::ptr::null(),
                    );
                }
            }
            end_render_pass(vk, cmd_buffer);

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        self.verify_transform_feedback_buffer(tf_buf.get_allocation(), params.buffer_size)?;

        Ok(TestStatus::pass("Pass"))
    }

    /// `TransformFeedbackResumeTestInstance::iterate`
    fn iterate_resume(&mut self) -> TestOutcome {
        let params = self.parameters;
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let allocator = self.context.get_default_allocator();

        let vertex_module = create_shader_module(vk, self.context.get_binary_collection().get("vert")?)?;
        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let pipeline = make_graphics_pipeline(vk, *pipeline_layout, *render_pass, *vertex_module, params.stream_id)?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let address_commands = AddressCommands::new(self.context, params.use_device_address_commands)?;
        let tf_buf = create_buffer_with_usage(
            vk,
            allocator,
            params.buffer_size as u64,
            address_commands
                .usage(vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            address_commands.requirement(MemoryRequirement::HOST_VISIBLE),
            params.use_maintenance5,
        )?;
        let tf_buf_device_address = address_commands.address(vk, tf_buf.get());
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let tf_buf_binding_sizes: Vec<vk::DeviceSize> = vec![params.buffer_size as u64];
        let tf_buf_binding_offsets: Vec<vk::DeviceSize> = vec![0];

        let tfc_buf_size = 16 * std::mem::size_of::<u32>() * params.part_count as usize;
        let tfc_buf = create_buffer_with_usage(
            vk,
            allocator,
            tfc_buf_size as u64,
            address_commands.usage(vk::BufferUsageFlags::TRANSFORM_FEEDBACK_COUNTER_BUFFER_EXT),
            address_commands.requirement(MemoryRequirement::ANY),
            params.use_maintenance5,
        )?;
        let tfc_buf_device_address = address_commands.address(vk, tfc_buf.get());
        let tfc_buf_sizes = self.generate_sizes_list(tfc_buf_size, params.part_count as usize);
        let tfc_buf_binding_offsets = Self::generate_offsets_list(&tfc_buf_sizes);
        let tfc_buf_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT,
            vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT,
            tfc_buf.get(),
            0,
            vk::WHOLE_SIZE,
        );

        let chunk_sizes_list = self.generate_sizes_list(params.buffer_size as usize, params.part_count as usize);
        let chunk_offsets_list = Self::generate_offsets_list(&chunk_sizes_list);

        debug_assert!(tf_buf_binding_sizes.len() == 1);
        debug_assert!(tf_buf_binding_offsets.len() == 1);

        begin_command_buffer(vk, cmd_buffer)?;
        {
            for draw_ndx in 0..params.part_count as usize {
                let start_value = (chunk_offsets_list[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;
                let num_points = (chunk_sizes_list[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;
                let count_buffers_count = if draw_ndx == 0 && !params.null_counter_buffers {
                    0
                } else {
                    1
                };

                begin_render_pass(
                    vk,
                    cmd_buffer,
                    *render_pass,
                    *framebuffer,
                    make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE),
                    zero_clear_value(),
                );
                {
                    unsafe {
                        vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                        address_commands.bind_buffers(
                            vk,
                            cmd_buffer,
                            0,
                            &[tf_buf.get()],
                            &[tf_buf_device_address],
                            &tf_buf_binding_offsets,
                            &tf_buf_binding_sizes,
                        );

                        vk.cmd_push_constants(
                            cmd_buffer,
                            *pipeline_layout,
                            vk::ShaderStageFlags::VERTEX,
                            0,
                            &start_value.to_ne_bytes(),
                        );

                        let counter_buffer = [tfc_buf.get()];
                        let counter_offset = [if draw_ndx == 0 {
                            0
                        } else {
                            tfc_buf_binding_offsets[draw_ndx - 1]
                        }];
                        let counter_address = [tfc_buf_device_address];
                        let counter_size = [if draw_ndx == 0 { 0 } else { tfc_buf_sizes[draw_ndx - 1] }];
                        address_commands.begin(
                            vk,
                            cmd_buffer,
                            0,
                            count_buffers_count,
                            if draw_ndx == 0 {
                                std::ptr::null()
                            } else {
                                counter_buffer.as_ptr()
                            },
                            if draw_ndx == 0 {
                                std::ptr::null()
                            } else {
                                counter_address.as_ptr()
                            },
                            if draw_ndx == 0 {
                                std::ptr::null()
                            } else {
                                counter_offset.as_ptr()
                            },
                            if draw_ndx == 0 {
                                std::ptr::null()
                            } else {
                                counter_size.as_ptr()
                            },
                        );
                        {
                            vk.cmd_draw(cmd_buffer, num_points, 1, 0, 0);
                        }
                        let use_null = draw_ndx == 0 && params.null_ptrs_in_end_transform_feedback;
                        let end_offset = [tfc_buf_binding_offsets[draw_ndx]];
                        let end_size = [tfc_buf_sizes[draw_ndx]];
                        address_commands.end(
                            vk,
                            cmd_buffer,
                            0,
                            1,
                            if use_null {
                                std::ptr::null()
                            } else {
                                counter_buffer.as_ptr()
                            },
                            if use_null {
                                std::ptr::null()
                            } else {
                                counter_address.as_ptr()
                            },
                            if use_null {
                                std::ptr::null()
                            } else {
                                end_offset.as_ptr()
                            },
                            if use_null { std::ptr::null() } else { end_size.as_ptr() },
                        );
                    }
                }
                end_render_pass(vk, cmd_buffer);

                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                        vk::PipelineStageFlags::DRAW_INDIRECT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[tfc_buf_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        self.verify_transform_feedback_buffer(tf_buf.get_allocation(), params.buffer_size)?;

        Ok(TestStatus::pass("Pass"))
    }

    /// The constructor of `TransformFeedbackBuiltinTestInstance`: the device has to offer what
    /// the built-in under test needs.
    fn check_builtin_requirements(
        &self,
        xfb_properties: &vk::PhysicalDeviceTransformFeedbackPropertiesEXT,
    ) -> Result<(), TestError> {
        let test_type = self.parameters.test_type;
        let features = self.context.get_device_features();

        let tf_buffers_supported = xfb_properties.max_transform_feedback_buffers;
        let tf_buffers_required = self.parameters.part_count;

        if (test_type == TestType::XfbClipDistance || test_type == TestType::XfbClipAndCull)
            && features.shader_clip_distance == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "shaderClipDistance feature is not supported".to_string(),
            ));
        }
        if (test_type == TestType::XfbCullDistance || test_type == TestType::XfbClipAndCull)
            && features.shader_cull_distance == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "shaderCullDistance feature is not supported".to_string(),
            ));
        }
        if tf_buffers_supported < tf_buffers_required {
            return Err(TestError::NotSupported(format!(
                "maxTransformFeedbackBuffers={tf_buffers_supported}, while test requires {tf_buffers_required}"
            )));
        }
        Ok(())
    }

    /// `TransformFeedbackBuiltinTestInstance::verifyTransformFeedbackBuffer`
    fn verify_builtin_transform_feedback_buffer(
        &self,
        buf_alloc: &Allocation<'_>,
        offset: vk::DeviceSize,
        buf_bytes: u32,
        one_periodicity: u32,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let num_points = buf_bytes / std::mem::size_of::<f32>() as u32;
        invalidate_alloc(device, buf_alloc)?;
        let tf_data = unsafe { buf_alloc.get_host_ptr().cast_const().add(offset as usize) }.cast::<f32>();

        for i in 0..num_points {
            // onePeriodicity, when different from zero, indicates the periodic position of a 1.0 value in the results buffer. This is
            // typically used when we need to emit a PointSize value together with other interesting data to the XFB buffer.
            let is_one = one_periodicity > 0 && (i % one_periodicity == one_periodicity - 1);
            let divisor = 32768u32;
            let epsilon = if is_one { 0.0f32 } else { 1.0 / divisor as f32 };
            let expected = if is_one { 1.0f32 } else { i as f32 / divisor as f32 };

            let received = unsafe { tf_data.add(i as usize).read_unaligned() };
            if (received - expected).abs() > epsilon {
                return Err(TestError::Fail(format!(
                    "Failed at item {i} received:{received} expected:{expected}"
                )));
            }
        }
        Ok(())
    }

    /// `TransformFeedbackBuiltinTestInstance::iterate`
    fn iterate_builtin(&mut self, xfb_properties: &vk::PhysicalDeviceTransformFeedbackPropertiesEXT) -> TestOutcome {
        self.check_builtin_requirements(xfb_properties)?;

        let params = self.parameters;
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let allocator = self.context.get_default_allocator();

        let vertex_module = create_shader_module(vk, self.context.get_binary_collection().get("vert")?)?;
        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let pipeline = make_graphics_pipeline(vk, *pipeline_layout, *render_pass, *vertex_module, params.stream_id)?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let tf_buf_size = params.buffer_size as u64 * params.part_count as u64;
        let address_commands = AddressCommands::new(self.context, params.use_device_address_commands)?;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                tf_buf_size,
                address_commands
                    .usage(vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            ),
            address_commands.requirement(MemoryRequirement::HOST_VISIBLE),
        )?;
        let tf_buf_device_address = address_commands.address(vk, tf_buf.get());
        let tf_buf_device_address_array = vec![tf_buf_device_address; params.part_count as usize];
        let tf_buf_array: Vec<vk::Buffer> = vec![tf_buf.get(); params.part_count as usize];
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let tf_buf_binding_sizes: Vec<vk::DeviceSize> = vec![params.buffer_size as u64; params.part_count as usize];
        let tf_buf_binding_offsets = Self::generate_offsets_list(&tf_buf_binding_sizes);
        let float_size = std::mem::size_of::<f32>() as u32;
        let per_vertex_data_size = match params.test_type {
            TestType::XfbPointSize => float_size,
            TestType::XfbClipDistance => 8 * float_size,
            TestType::XfbCullDistance => 8 * float_size,
            TestType::XfbClipAndCull => 6 * float_size,
            _ => 0,
        };

        // Every registered case wants the point size (see the manifest).
        let point_size_wanted = true;
        let one_periodicity = match params.test_type {
            TestType::XfbClipDistance if point_size_wanted => 8,
            TestType::XfbCullDistance if point_size_wanted => 8,
            TestType::XfbClipAndCull if point_size_wanted => 6,
            _ => 0,
        };
        let num_points = params.buffer_size / per_vertex_data_size;

        begin_command_buffer(vk, cmd_buffer)?;
        {
            begin_render_pass(
                vk,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE),
                zero_clear_value(),
            );
            unsafe {
                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                address_commands.bind_buffers(
                    vk,
                    cmd_buffer,
                    0,
                    &tf_buf_array,
                    &tf_buf_device_address_array,
                    &tf_buf_binding_offsets,
                    &tf_buf_binding_sizes,
                );

                address_commands.begin(
                    vk,
                    cmd_buffer,
                    0,
                    0,
                    std::ptr::null(),
                    std::ptr::null(),
                    std::ptr::null(),
                    std::ptr::null(),
                );
                {
                    vk.cmd_draw(cmd_buffer, num_points, 1, 0, 0);
                }
                address_commands.end(
                    vk,
                    cmd_buffer,
                    0,
                    0,
                    std::ptr::null(),
                    std::ptr::null(),
                    std::ptr::null(),
                    std::ptr::null(),
                );
            }
            end_render_pass(vk, cmd_buffer);

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        self.verify_builtin_transform_feedback_buffer(
            tf_buf.get_allocation(),
            tf_buf_binding_offsets[params.part_count as usize - 1],
            num_points * per_vertex_data_size,
            one_periodicity,
        )?;

        Ok(TestStatus::pass("Pass"))
    }

    /// `TransformFeedbackHolesInstance::iterate`
    fn iterate_holes(&mut self) -> TestOutcome {
        let params = self.parameters;
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let allocator = self.context.get_default_allocator();

        // We repurpose partCount to indicate somehow the number of draws.
        let extra_draw = params.part_count > 1;
        let fb_extent = (1u32, 1u32);
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let geom_color_bytes = [0u8, 0, 255, 255]; // Must match frag shader values.
        let has_geom = params.test_type == TestType::HolesGeometry;
        let data_stages = if has_geom {
            vk::ShaderStageFlags::GEOMETRY
        } else {
            vk::ShaderStageFlags::VERTEX
        };
        let xfb_comp_count = 3usize; // Per vertex.
        let xfb_chunk_size = xfb_comp_count * std::mem::size_of::<f32>(); // Per vertex, in bytes.
        let total_draws = if extra_draw { 2usize } else { 1usize };

        // Color buffer with verification buffer.
        let color_image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(
                IVec2::new(fb_extent.0 as i32, fb_extent.1 as i32),
                fb_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            vk,
            color_image.get(),
            vk::ImageViewType::_2D,
            fb_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let color_buffer_size = (fb_extent.0 * fb_extent.1 * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Vertices.
        let vertices: [[f32; 4]; 1] = [[0.0, 0.0, 0.0, 1.0]];

        // Vertex buffer.
        let vb_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(vb_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vb_alloc = vertex_buffer.get_allocation();
        let vb_offset: vk::DeviceSize = 0;

        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vb_alloc.get_host_ptr(),
                vb_size as usize,
            )
        };
        flush_alloc(vk, vb_alloc)?;

        // XFB buffer. When using an extra draw, leave space for a possible second draw (NB: but it should not be recorded, see below).
        let xfb_size_factor = total_draws as vk::DeviceSize;
        let xfb_buffer_size = (xfb_chunk_size * vertices.len()) as vk::DeviceSize * xfb_size_factor;
        let xfb_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(xfb_buffer_size, vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let xfb_buffer_alloc = xfb_buffer.get_allocation();
        let xfb_buffer_offset: vk::DeviceSize = 0;

        unsafe { std::ptr::write_bytes(xfb_buffer_alloc.get_host_ptr(), 0, xfb_buffer_size as usize) };
        flush_alloc(vk, xfb_buffer_alloc)?;

        // Push constants.
        let pc_data: [f32; 3] = [10.0, 20.0, 30.0]; // Must match the expected values in the frag shader.
        let pc_bytes: Vec<u8> = pc_data.iter().flat_map(|f| f.to_ne_bytes()).collect();
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: data_stages,
            offset: 0,
            size: pc_bytes.len() as u32,
        }];

        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let render_pass = make_render_pass(vk, fb_format)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_view], fb_extent.0, fb_extent.1, 1)?;

        // Modules.
        let binaries = self.context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get("vert")?)?;
        let geom_module = if has_geom {
            Some(create_shader_module(vk, binaries.get("geom")?)?)
        } else {
            None
        };
        let frag_module = create_shader_module(vk, binaries.get("frag")?)?;

        let pipeline = make_graphics_pipeline_staged(
            vk,
            *pipeline_layout,
            GraphicsPipelineStages {
                vertex: *vert_module,
                fragment: *frag_module,
                tessellation_control: None,
                tessellation_evaluation: None,
                geometry: geom_module.as_ref().map(|m| **m),
            },
            *render_pass,
            fb_extent,
            vk::PrimitiveTopology::POINT_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
            None,
            None,
        )?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        begin_command_buffer(vk, cmd_buffer)?;
        begin_render_pass(
            vk,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            vk.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vb_offset]);
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            vk.cmd_push_constants(cmd_buffer, *pipeline_layout, data_stages, 0, &pc_bytes);
            vk.cmd_bind_transform_feedback_buffers_ext(
                cmd_buffer,
                0,
                &[xfb_buffer.get()],
                &[xfb_buffer_offset],
                &[xfb_buffer_size],
            );
            cmd_begin_transform_feedback_raw(vk, cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
            vk.cmd_draw(cmd_buffer, vertices.len() as u32, 1, 0, 0);
            cmd_end_transform_feedback_raw(vk, cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
            if extra_draw {
                // When extra_draw is true, record a new draw outside the transform feedback section. The XFB buffer will have enough space
                // to record this draw, but it should not be recorded, obviously, so the values in the buffer should stay zero. We are also
                // avoiding any state changes between both draws.
                vk.cmd_draw(cmd_buffer, vertices.len() as u32, 1, 0, 0);
            }
        }
        end_render_pass(vk, cmd_buffer);
        let xfb_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: fb_extent.0,
                height: fb_extent.1,
                depth: 1,
            },
        };
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            color_buffer.get(),
            0,
            color_buffer_size,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[xfb_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            vk.cmd_copy_image_to_buffer(
                cmd_buffer,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                &[copy_region],
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        // Verify color output. (Only 0 and 1 are used, so the 8-bit result is exact.)
        invalidate_alloc(vk, color_buffer.get_allocation())?;
        let result_pixel =
            unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr().cast_const(), 4) };
        if result_pixel != geom_color_bytes {
            log::info!("Result pixel is {result_pixel:?}, expected {geom_color_bytes:?}");
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }

        // Verify XFB buffer.
        invalidate_alloc(vk, xfb_buffer_alloc)?;
        let ref_recorded_values = [pc_data[0], 0.0f32, pc_data[2]]; // Per-vertex, must match vert/geom shader, note Y is not saved.
        let ref_empty_values = [0.0f32; 3]; // For empty areas of the XFB buffer.
        let data_ptr = xfb_buffer_alloc.get_host_ptr().cast_const();

        for draw_idx in 0..total_draws {
            let ref_values = if draw_idx > 0 {
                &ref_empty_values
            } else {
                &ref_recorded_values
            };
            for vert_idx in 0..vertices.len() {
                let vertex_data_ptr =
                    unsafe { data_ptr.add(vert_idx * xfb_chunk_size + draw_idx * vertices.len() * xfb_chunk_size) };
                let mut vert_values = [0.0f32; 3];
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        vertex_data_ptr,
                        vert_values.as_mut_ptr().cast::<u8>(),
                        std::mem::size_of_val(&vert_values),
                    )
                };

                if &vert_values != ref_values {
                    return Err(TestError::Fail(format!(
                        "Invalid data found for vertex {vert_idx}: expected {ref_recorded_values:?} and found {vert_values:?}"
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `TransformFeedbackMaxOutputComponentsInstance::iterate`
    fn iterate_max_output_components(&mut self) -> TestOutcome {
        let params = self.parameters;
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let allocator = self.context.get_default_allocator();

        let fb_extent = (1u32, 1u32);

        // Vertices for a full-screen triangle.
        let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [-1.0, 3.0, 0.0, 1.0], [3.0, -1.0, 0.0, 1.0]];
        let total_parts = params.part_count + 1; // +1 for gl_Position
        let total_comps = total_parts * VEC4_COMPONENTS;
        let vertex_count = vertices.len() as u32;

        // Transform feedback buffer.
        let xfb_buffer_size =
            (vertex_count * total_comps) as vk::DeviceSize * std::mem::size_of::<f32>() as vk::DeviceSize;
        let xfb_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(xfb_buffer_size, vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let xfb_buffer_alloc = xfb_buffer.get_allocation();
        let xfb_buffer_offset: vk::DeviceSize = 0;

        unsafe { std::ptr::write_bytes(xfb_buffer_alloc.get_host_ptr(), 0, xfb_buffer_size as usize) };
        flush_alloc(vk, xfb_buffer_alloc)?;

        // Vertex buffer
        let vb_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(vb_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vb_alloc = vertex_buffer.get_allocation();
        let vb_offset: vk::DeviceSize = 0;

        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vb_alloc.get_host_ptr(),
                vb_size as usize,
            )
        };
        flush_alloc(vk, vb_alloc)?; // strictly speaking, not needed.

        let pipeline_layout = make_plain_pipeline_layout(vk, &[])?;
        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], fb_extent.0, fb_extent.1, 1)?;

        // Modules.
        let vert_module = create_shader_module(vk, self.context.get_binary_collection().get("vert")?)?;

        let pipeline = make_vertex_input_pipeline(vk, *pipeline_layout, *render_pass, *vert_module, fb_extent)?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        begin_command_buffer(vk, cmd_buffer)?;
        begin_render_pass(
            vk,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
            zero_clear_value(),
        );
        unsafe {
            vk.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vb_offset]);
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            vk.cmd_bind_transform_feedback_buffers_ext(
                cmd_buffer,
                0,
                &[xfb_buffer.get()],
                &[xfb_buffer_offset],
                &[xfb_buffer_size],
            );
            cmd_begin_transform_feedback_raw(vk, cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
            vk.cmd_draw(cmd_buffer, vertex_count, 1, 0, 0);
            cmd_end_transform_feedback_raw(vk, cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
        }
        end_render_pass(vk, cmd_buffer);
        let pre_host_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[pre_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        // Verify transform feedback buffer.
        invalidate_alloc(vk, xfb_buffer_alloc)?;

        let mut val_idx = 0usize;
        let xfb_values = xfb_buffer_alloc.get_host_ptr().cast_const().cast::<f32>();
        for vert_idx in 0..vertex_count {
            for part_idx in 0..total_parts {
                for comp_idx in 0..VEC4_COMPONENTS {
                    // Must match vertex shader.
                    // Note for outputs other than gl_Position, the component order is reversed due to the xfb offsets in the shader.
                    let expected_val = if part_idx == 0 {
                        // gl_Position?
                        vertices[vert_idx as usize][comp_idx as usize]
                    } else {
                        (vert_idx + 1) as f32 * 10000.0
                            + part_idx as f32 * 10.0
                            + (VEC4_COMPONENTS - 1 - comp_idx) as f32
                    };

                    let result = unsafe { xfb_values.add(val_idx).read_unaligned() };

                    if result != expected_val {
                        return Err(TestError::Fail(format!(
                            "XFB Buffer value at position {val_idx} ({result}) does not match expected value ({expected_val}); vertex={vert_idx} vector={part_idx} component={comp_idx}"
                        )));
                    }

                    val_idx += 1;
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `TransformFeedbackDrawOutsideTestInstance::iterate`
    fn iterate_draw_outside(&mut self) -> TestOutcome {
        let params = self.parameters;
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let allocator = self.context.get_default_allocator();

        let binaries = self.context.get_binary_collection();
        let vertex_module1 = create_shader_module(vk, binaries.get("vert")?)?;
        let vertex_module2 = create_shader_module(vk, binaries.get("vert2")?)?;
        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let pipeline1 = make_graphics_pipeline(vk, *pipeline_layout, *render_pass, *vertex_module1, params.stream_id)?;
        let pipeline2 = make_graphics_pipeline(vk, *pipeline_layout, *render_pass, *vertex_module2, params.stream_id)?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let address_commands = AddressCommands::new(self.context, params.use_device_address_commands)?;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                params.buffer_size as u64,
                address_commands
                    .usage(vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            ),
            address_commands.requirement(MemoryRequirement::HOST_VISIBLE),
        )?;
        let tf_buf_device_address = address_commands.address(vk, tf_buf.get());
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let tf_buf_binding_sizes = self.generate_sizes_list(params.buffer_size as usize, params.part_count as usize);
        let tf_buf_binding_offsets = Self::generate_offsets_list(&tf_buf_binding_sizes);

        begin_command_buffer(vk, cmd_buffer)?;
        {
            begin_render_pass(
                vk,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE),
                zero_clear_value(),
            );
            {
                for i in 0..2 {
                    let pipeline = if i == 0 { *pipeline1 } else { *pipeline2 };
                    unsafe { vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline) };

                    for draw_ndx in 0..params.part_count as usize {
                        let start_value = (tf_buf_binding_offsets[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;
                        let num_points = (tf_buf_binding_sizes[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;

                        unsafe {
                            address_commands.bind_buffers(
                                vk,
                                cmd_buffer,
                                0,
                                &[tf_buf.get()],
                                &[tf_buf_device_address],
                                &[tf_buf_binding_offsets[draw_ndx]],
                                &[tf_buf_binding_sizes[draw_ndx]],
                            );

                            vk.cmd_push_constants(
                                cmd_buffer,
                                *pipeline_layout,
                                vk::ShaderStageFlags::VERTEX,
                                0,
                                &start_value.to_ne_bytes(),
                            );

                            if i == 0 {
                                address_commands.begin(
                                    vk,
                                    cmd_buffer,
                                    0,
                                    0,
                                    std::ptr::null(),
                                    std::ptr::null(),
                                    std::ptr::null(),
                                    std::ptr::null(),
                                );
                            }
                            {
                                vk.cmd_draw(cmd_buffer, num_points, 1, 0, 0);
                            }
                            if i == 0 {
                                address_commands.end(
                                    vk,
                                    cmd_buffer,
                                    0,
                                    0,
                                    std::ptr::null(),
                                    std::ptr::null(),
                                    std::ptr::null(),
                                    std::ptr::null(),
                                );
                            }
                        }
                    }
                }
            }
            end_render_pass(vk, cmd_buffer);

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        self.verify_transform_feedback_buffer(tf_buf.get_allocation(), params.buffer_size)?;

        Ok(TestStatus::pass("Pass"))
    }
}

/// The clear value the attachmentless passes are begun with; there is nothing to clear.
pub(super) fn zero_clear_value() -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    }
}

/// `addTransformFeedbackTestCaseVariants`, for point-list cases with `pointSize == 0`.
///
/// Upstream tries point sizes {0, 1}. For a point list the size-less variant is illegal and
/// skipped, so the size-1 variant is the only one added and - because `caseCount` is still 0
/// when it is - carries no `_ptsz` suffix.
fn add_transform_feedback_test_case_variants(
    group: &mut TestCaseGroup,
    name: &str,
    parameters: TestParameters,
    programs: BinaryCollection,
) {
    group.add_child(Box::new(TransformFeedbackTestCase {
        name: name.to_string(),
        parameters,
        programs,
    }) as Box<dyn TestCase>);
}

/// `createTransformFeedbackSimpleTests` (the registration half), for the ported test types.
pub fn create_transform_feedback_simple_tests() -> TestCaseGroup {
    let mut group = create_simple_group("simple");
    super::simple_rebind_tests::add_rebind_tests(&mut group);
    group
}

pub(super) fn create_simple_group(name: &str) -> TestCaseGroup {
    use crate::generated::shaders::transform_feedback_simple as g;

    let mut group = TestCaseGroup::new(name);
    // Only the monolithic group repeats the basic cases with device address commands; the library groups are the same tree under other names.
    let is_monolithic = name == "simple";

    let buffer_counts = [1u32, 2, 4, 8];
    let buffer_sizes = [256u32, 512, 128 * 1024];
    let test_types = [
        (TestType::Basic, "basic"),
        (TestType::Resume, "resume"),
        (TestType::XfbPointSize, "xfb_pointsize"),
        (TestType::XfbClipDistance, "xfb_clipdistance"),
        (TestType::XfbCullDistance, "xfb_culldistance"),
        (TestType::XfbClipAndCull, "xfb_clip_and_cull"),
        (TestType::DrawOutside, "draw_outside"),
    ];

    for (test_type, test_name) in test_types {
        for part_count in buffer_counts {
            let programs = match test_type {
                TestType::DrawOutside => g::SIMPLE_DRAW_OUTSIDE_PROGRAMS.programs,
                TestType::Basic | TestType::Resume => g::SIMPLE_BASIC_PROGRAMS.programs,
                _ => builtin_programs(test_type, part_count),
            };

            for buffer_size in buffer_sizes {
                let mut parameters = TestParameters {
                    test_type,
                    buffer_size,
                    part_count,
                    stream_id: 0,
                    null_counter_buffers: false,
                    null_ptrs_in_end_transform_feedback: false,
                    use_maintenance5: false,
                    use_device_address_commands: false,
                };

                // Simple Transform Feedback test
                let postfix_str = format!("_{part_count}_{buffer_size}");
                add_transform_feedback_test_case_variants(
                    &mut group,
                    &format!("{test_name}{postfix_str}"),
                    parameters,
                    programs,
                );

                // The stream id 0 begin/end query indexed modes only change what the query
                // tests do; for these test types the instance is the same.
                add_transform_feedback_test_case_variants(
                    &mut group,
                    &format!("{test_name}_beginqueryindexed_streamid_0{postfix_str}"),
                    parameters,
                    programs,
                );
                add_transform_feedback_test_case_variants(
                    &mut group,
                    &format!("{test_name}_endqueryindexed_streamid_0{postfix_str}"),
                    parameters,
                    programs,
                );

                // limit number of tests repeated for device_address_commands
                if part_count == 2 && buffer_size == 256 && is_monolithic {
                    parameters.use_device_address_commands = true;
                    add_transform_feedback_test_case_variants(
                        &mut group,
                        &format!("{test_name}{postfix_str}_device_address"),
                        parameters,
                        programs,
                    );
                    parameters.use_device_address_commands = false;
                }

                if test_type == TestType::Resume && part_count == 1 {
                    parameters.null_counter_buffers = true;
                    add_transform_feedback_test_case_variants(
                        &mut group,
                        &format!("{test_name}{postfix_str}_null_counter_buffers"),
                        parameters,
                        programs,
                    );

                    parameters.null_counter_buffers = false;
                    parameters.null_ptrs_in_end_transform_feedback = true;
                    add_transform_feedback_test_case_variants(
                        &mut group,
                        &format!("{test_name}{postfix_str}_null_ptrs_end_xfb"),
                        parameters,
                        programs,
                    );
                }
            }
        }
    }

    super::simple_query_tests::add_query_tests(&mut group);
    super::simple_stream_tests::add_stream_tests(&mut group);
    super::simple_winding_tests::add_winding_tests(&mut group);
    super::simple_multistream_tests::add_multistream_tests(&mut group);
    super::simple_indirect_tests::add_indirect_tests(&mut group);
    super::simple_backward_tests::add_backward_tests(&mut group);
    super::simple_depthclip_tests::add_depth_clip_tests(&mut group);
    super::simple_single_raster_tests::add_single_raster_tests(&mut group);

    // Test skipping components in the XFB buffer
    let hole_cases = [
        (TestType::HolesVertex, "_vert", g::SIMPLE_HOLES_VERT_PROGRAMS.programs),
        (TestType::HolesGeometry, "_geom", g::SIMPLE_HOLES_GEOM_PROGRAMS.programs),
    ];
    for (test_type, suffix, programs) in hole_cases {
        for extra_draw in [false, true] {
            // partCount is repurposed to indicate somehow the number of draws.
            let part_count = if extra_draw { 2 } else { 1 };
            let test_name = format!("holes{}{suffix}", if extra_draw { "_extra_draw" } else { "" });
            let parameters = TestParameters {
                test_type,
                buffer_size: 0,
                part_count,
                stream_id: 0,
                null_counter_buffers: false,
                null_ptrs_in_end_transform_feedback: false,
                use_maintenance5: false,
                use_device_address_commands: false,
            };
            add_transform_feedback_test_case_variants(&mut group, &test_name, parameters, programs);
        }
    }

    // Save a large number of components to the transform feedback buffer. The part count is
    // reused to give the number of custom outputs of the vertex shader.
    for (comp_count, programs) in [
        (64u32, g::SIMPLE_MAX_OUTPUT_COMPONENTS_64_PROGRAMS.programs),
        (128u32, g::SIMPLE_MAX_OUTPUT_COMPONENTS_128_PROGRAMS.programs),
    ] {
        let part_count = comp_count / VEC4_COMPONENTS - 1; // -1 for gl_Position
        let parameters = TestParameters {
            test_type: TestType::MaxOutputComponents,
            buffer_size: 0,
            part_count,
            stream_id: 0,
            null_counter_buffers: false,
            null_ptrs_in_end_transform_feedback: false,
            use_maintenance5: false,
            use_device_address_commands: false,
        };
        add_transform_feedback_test_case_variants(
            &mut group,
            &format!("max_output_components_{comp_count}"),
            parameters,
            programs,
        );
    }

    // The resume test with the buffers' usage given through VK_KHR_maintenance5.
    let maintenance5 = TestParameters {
        test_type: TestType::Resume,
        buffer_size: 96,
        part_count: 2,
        stream_id: 1,
        null_counter_buffers: false,
        null_ptrs_in_end_transform_feedback: false,
        use_maintenance5: true,
        use_device_address_commands: false,
    };
    add_transform_feedback_test_case_variants(
        &mut group,
        "maintenance5",
        maintenance5,
        g::SIMPLE_BASIC_PROGRAMS.programs,
    );

    group
}

/// The generated program set of a built-in case: one shader per type and part count, since
/// `xfb_buffer` is `partCount - 1`.
fn builtin_programs(test_type: TestType, part_count: u32) -> BinaryCollection {
    use crate::generated::shaders::transform_feedback_simple as g;

    match (test_type, part_count) {
        (TestType::XfbPointSize, 1) => g::SIMPLE_XFB_POINTSIZE_1_PROGRAMS.programs,
        (TestType::XfbPointSize, 2) => g::SIMPLE_XFB_POINTSIZE_2_PROGRAMS.programs,
        (TestType::XfbPointSize, 4) => g::SIMPLE_XFB_POINTSIZE_4_PROGRAMS.programs,
        (TestType::XfbPointSize, 8) => g::SIMPLE_XFB_POINTSIZE_8_PROGRAMS.programs,
        (TestType::XfbClipDistance, 1) => g::SIMPLE_XFB_CLIPDISTANCE_1_PROGRAMS.programs,
        (TestType::XfbClipDistance, 2) => g::SIMPLE_XFB_CLIPDISTANCE_2_PROGRAMS.programs,
        (TestType::XfbClipDistance, 4) => g::SIMPLE_XFB_CLIPDISTANCE_4_PROGRAMS.programs,
        (TestType::XfbClipDistance, 8) => g::SIMPLE_XFB_CLIPDISTANCE_8_PROGRAMS.programs,
        (TestType::XfbCullDistance, 1) => g::SIMPLE_XFB_CULLDISTANCE_1_PROGRAMS.programs,
        (TestType::XfbCullDistance, 2) => g::SIMPLE_XFB_CULLDISTANCE_2_PROGRAMS.programs,
        (TestType::XfbCullDistance, 4) => g::SIMPLE_XFB_CULLDISTANCE_4_PROGRAMS.programs,
        (TestType::XfbCullDistance, 8) => g::SIMPLE_XFB_CULLDISTANCE_8_PROGRAMS.programs,
        (TestType::XfbClipAndCull, 1) => g::SIMPLE_XFB_CLIP_AND_CULL_1_PROGRAMS.programs,
        (TestType::XfbClipAndCull, 2) => g::SIMPLE_XFB_CLIP_AND_CULL_2_PROGRAMS.programs,
        (TestType::XfbClipAndCull, 4) => g::SIMPLE_XFB_CLIP_AND_CULL_4_PROGRAMS.programs,
        (TestType::XfbClipAndCull, 8) => g::SIMPLE_XFB_CLIP_AND_CULL_8_PROGRAMS.programs,
        _ => unreachable!("no built-in shaders for this case"),
    }
}
