// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateComputeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. A dynamic state is its own enum here, since vulkanalia's
// `DynamicState` has one constant per alias; the group names are the canonical (core) names upstream prints. The two NV shading
// rate image states run on a custom device with only that extension enabled, like upstream's `ShadingRateImageDeviceHelper`.
//
// `compute_transfer`: dynamic state commands recorded before or after a compute dispatch or a buffer copy must neither fail nor
// disturb the operation.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtDiscardRectanglesExtensionDeviceCommands, ExtExtendedDynamicStateExtensionDeviceCommands,
    ExtLineRasterizationExtensionDeviceCommands, ExtSampleLocationsExtensionDeviceCommands, InstanceV1_1,
    KhrFragmentShadingRateExtensionDeviceCommands, KhrLineRasterizationExtensionDeviceCommands,
    KhrRayTracingPipelineExtensionDeviceCommands, NvClipSpaceWScalingExtensionDeviceCommands,
    NvScissorExclusiveExtensionDeviceCommands, NvShadingRateImageExtensionDeviceCommands,
};

use crate::generated::shaders::dynamic_state_compute::{
    COMPUTE_TRANSFER_COMP, COMPUTE_TRANSFER_COMP_VERT, COMPUTE_TRANSFER_VERT,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// The entries of `dynamicStateList`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum State {
    Viewport,
    Scissor,
    LineWidth,
    DepthBias,
    BlendConstants,
    DepthBounds,
    StencilCompareMask,
    StencilWriteMask,
    StencilReference,
    DiscardRectangle,
    SampleLocations,
    RayTracingPipelineStackSize,
    FragmentShadingRate,
    LineStipple,
    CullMode,
    FrontFace,
    PrimitiveTopology,
    ViewportWithCount,
    ScissorWithCount,
    VertexInputBindingStride,
    DepthTestEnable,
    DepthWriteEnable,
    DepthCompareOp,
    DepthBoundsTestEnable,
    StencilTestEnable,
    StencilOp,
    ViewportWScaling,
    ViewportShadingRatePalette,
    ViewportCoarseSampleOrder,
    ExclusiveScissor,
}

/// `dynamicStateList`, with `getDynamicStateBriefName` of each.
const DYNAMIC_STATE_LIST: [(State, &str); 30] = [
    (State::Viewport, "viewport"),
    (State::Scissor, "scissor"),
    (State::LineWidth, "line_width"),
    (State::DepthBias, "depth_bias"),
    (State::BlendConstants, "blend_constants"),
    (State::DepthBounds, "depth_bounds"),
    (State::StencilCompareMask, "stencil_compare_mask"),
    (State::StencilWriteMask, "stencil_write_mask"),
    (State::StencilReference, "stencil_reference"),
    (State::DiscardRectangle, "discard_rectangle_ext"),
    (State::SampleLocations, "sample_locations_ext"),
    (
        State::RayTracingPipelineStackSize,
        "ray_tracing_pipeline_stack_size_khr",
    ),
    (State::FragmentShadingRate, "fragment_shading_rate_khr"),
    (State::LineStipple, "line_stipple"),
    (State::CullMode, "cull_mode"),
    (State::FrontFace, "front_face"),
    (State::PrimitiveTopology, "primitive_topology"),
    (State::ViewportWithCount, "viewport_with_count"),
    (State::ScissorWithCount, "scissor_with_count"),
    (State::VertexInputBindingStride, "vertex_input_binding_stride"),
    (State::DepthTestEnable, "depth_test_enable"),
    (State::DepthWriteEnable, "depth_write_enable"),
    (State::DepthCompareOp, "depth_compare_op"),
    (State::DepthBoundsTestEnable, "depth_bounds_test_enable"),
    (State::StencilTestEnable, "stencil_test_enable"),
    (State::StencilOp, "stencil_op"),
    (State::ViewportWScaling, "viewport_w_scaling_nv"),
    (State::ViewportShadingRatePalette, "viewport_shading_rate_palette_nv"),
    (State::ViewportCoarseSampleOrder, "viewport_coarse_sample_order_nv"),
    (State::ExclusiveScissor, "exclusive_scissor_nv"),
];

impl State {
    /// `StateInfo::requirements`
    fn requirements(self) -> &'static [&'static str] {
        match self {
            State::Viewport
            | State::Scissor
            | State::LineWidth
            | State::DepthBias
            | State::BlendConstants
            | State::DepthBounds
            | State::StencilCompareMask
            | State::StencilWriteMask
            | State::StencilReference => &[],
            State::DiscardRectangle => &["VK_EXT_discard_rectangles"],
            State::SampleLocations => &["VK_EXT_sample_locations"],
            State::RayTracingPipelineStackSize => &["VK_KHR_ray_tracing_pipeline"],
            State::FragmentShadingRate => &["VK_KHR_fragment_shading_rate"],
            State::LineStipple => &["VK_KHR_or_EXT_line_rasterization"],
            State::CullMode
            | State::FrontFace
            | State::PrimitiveTopology
            | State::ViewportWithCount
            | State::ScissorWithCount
            | State::VertexInputBindingStride
            | State::DepthTestEnable
            | State::DepthWriteEnable
            | State::DepthCompareOp
            | State::DepthBoundsTestEnable
            | State::StencilTestEnable
            | State::StencilOp => &["VK_EXT_extended_dynamic_state"],
            State::ViewportWScaling => &["VK_NV_clip_space_w_scaling"],
            State::ViewportShadingRatePalette | State::ViewportCoarseSampleOrder => &["VK_NV_shading_rate_image"],
            State::ExclusiveScissor => &["VK_NV_scissor_exclusive"],
        }
    }

    fn needs_shading_rate_image_device(self) -> bool {
        self.requirements().contains(&"VK_NV_shading_rate_image")
    }
}

/// A device that is not the context's own, which `getDeviceHelper` returns for the states that need one.
struct CustomDevice {
    device: Device,
    allocator: SimpleAllocator,
    queue: vk::Queue,
}

impl Drop for CustomDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

/// `DeviceHelper`: either the default device of the context or a custom one.
struct DeviceHelper<'a> {
    context: &'a Context<'a>,
    custom: Option<CustomDevice>,
}

impl<'a> DeviceHelper<'a> {
    /// `getDeviceHelper`
    fn new(context: &'a Context<'a>, state: State) -> Result<Self, TestError> {
        if !state.needs_shading_rate_image_device() {
            return Ok(Self { context, custom: None });
        }

        // `ShadingRateImageDeviceHelper`
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue_priorities = [1.0f32];
        let queue_infos = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(queue_family_index)
            .queue_priorities(&queue_priorities)
            .build()];

        let extensions = [c"VK_NV_shading_rate_image".as_ptr()];

        let mut shading_rate_image_features = vk::PhysicalDeviceShadingRateImageFeaturesNV::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut shading_rate_image_features);
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

        let device_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&extensions)
            .push_next(&mut features2);
        let device =
            unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?;
        let queue = unsafe { device.get_device_queue(queue_family_index, 0) };
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };

        Ok(Self {
            context,
            custom: Some(CustomDevice {
                device,
                allocator: SimpleAllocator::new(memory_properties),
                queue,
            }),
        })
    }

    fn device(&self) -> &Device {
        match &self.custom {
            Some(custom) => &custom.device,
            None => self.context.get_device(),
        }
    }

    fn queue(&self) -> vk::Queue {
        match &self.custom {
            Some(custom) => custom.queue,
            None => self.context.get_universal_queue(),
        }
    }

    fn allocator(&self) -> &SimpleAllocator {
        match &self.custom {
            Some(custom) => &custom.allocator,
            None => self.context.get_default_allocator(),
        }
    }
}

/// `BindVertexBuffersData`: a vertex buffer and graphics pipeline are needed for vkCmdBindVertexBuffers2EXT().
struct BindVertexBuffersData<'d> {
    vertex_buffer: BufferWithMemory<'d>,
    data_size: vk::DeviceSize,
    pipeline: Unique<'d, vk::Pipeline>,
    _vertex_shader: Unique<'d, vk::ShaderModule>,
    _pipeline_layout: Unique<'d, vk::PipelineLayout>,
    _render_pass: Unique<'d, vk::RenderPass>,
}

const BIND_VERTEX_BUFFERS_WIDTH: u32 = 16;
const BIND_VERTEX_BUFFERS_HEIGHT: u32 = 16;

impl<'d> BindVertexBuffersData<'d> {
    fn new(context: &Context<'_>, helper: &'d DeviceHelper<'_>) -> Result<Self, TestError> {
        let device = helper.device();

        // Vertex buffer.
        let vertex: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
        let data_size = std::mem::size_of_val(&vertex) as vk::DeviceSize;
        let atom_size = context.get_device_properties().limits.non_coherent_atom_size;
        let vertex_buffer_size = data_size.div_ceil(atom_size) * atom_size;
        let buffer_info = make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER);

        let vertex_buffer =
            BufferWithMemory::new(device, helper.allocator(), buffer_info, MemoryRequirement::HOST_VISIBLE)?;
        let buffer_alloc = vertex_buffer.get_allocation();

        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex.as_ptr().cast::<u8>(),
                buffer_alloc.get_host_ptr(),
                data_size as usize,
            )
        };
        flush_alloc(device, buffer_alloc)?;

        // Empty render pass.
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // Empty pipeline layout.
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Passthrough vertex shader.
        let binaries = context.get_binary_collection();
        let vertex_shader = create_shader_module(device, binaries.get("vert")?)?;

        // Graphics pipeline.
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(BIND_VERTEX_BUFFERS_WIDTH, BIND_VERTEX_BUFFERS_HEIGHT);
        state.color_attachment_count = 0;
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE];
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[(vk::ShaderStageFlags::VERTEX, *vertex_shader)],
            &state,
        )?;

        Ok(Self {
            vertex_buffer,
            data_size,
            pipeline,
            _vertex_shader: vertex_shader,
            _pipeline_layout: pipeline_layout,
            _render_pass: render_pass,
        })
    }
}

/// The setters of `getDynamicStateInfo(state).recorder`.
fn record_state(
    device: &Device,
    cmd: vk::CommandBuffer,
    state: State,
    data: Option<&BindVertexBuffersData<'_>>,
    use_khr_line_stipple: bool,
) {
    let unit_rect = vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D { width: 1, height: 1 },
    };
    let unit_viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: 1.0,
        height: 1.0,
        min_depth: 0.0,
        max_depth: 1.0,
    };

    unsafe {
        match state {
            State::Viewport => device.cmd_set_viewport(cmd, 0, &[unit_viewport]),
            State::Scissor => device.cmd_set_scissor(cmd, 0, &[unit_rect]),
            State::LineWidth => device.cmd_set_line_width(cmd, 1.0),
            State::DepthBias => device.cmd_set_depth_bias(cmd, 0.0, 0.0, 0.0),
            State::BlendConstants => device.cmd_set_blend_constants(cmd, [0.0, 0.0, 0.0, 0.0]),
            State::DepthBounds => device.cmd_set_depth_bounds(cmd, 0.0, 1.0),
            State::StencilCompareMask => {
                device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFF)
            }
            State::StencilWriteMask => {
                device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFF)
            }
            State::StencilReference => {
                device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFF)
            }
            State::DiscardRectangle => device.cmd_set_discard_rectangle_ext(cmd, 0, &[unit_rect]),
            State::SampleLocations => {
                let locations = [
                    vk::SampleLocationEXT { x: 0.5, y: 0.5 },
                    vk::SampleLocationEXT { x: 0.5, y: 1.5 },
                    vk::SampleLocationEXT { x: 1.5, y: 0.5 },
                    vk::SampleLocationEXT { x: 1.5, y: 1.5 },
                ];
                let info = vk::SampleLocationsInfoEXT {
                    s_type: vk::StructureType::SAMPLE_LOCATIONS_INFO_EXT,
                    next: std::ptr::null(),
                    sample_locations_per_pixel: vk::SampleCountFlags::_4,
                    sample_location_grid_size: vk::Extent2D { width: 1, height: 1 },
                    sample_locations_count: locations.len() as u32,
                    sample_locations: locations.as_ptr(),
                };
                device.cmd_set_sample_locations_ext(cmd, &info);
            }
            State::RayTracingPipelineStackSize => device.cmd_set_ray_tracing_pipeline_stack_size_khr(cmd, 4096),
            State::FragmentShadingRate => {
                let fragment_size = vk::Extent2D { width: 1, height: 1 };
                device.cmd_set_fragment_shading_rate_khr(
                    cmd,
                    &fragment_size,
                    [
                        vk::FragmentShadingRateCombinerOpKHR::KEEP,
                        vk::FragmentShadingRateCombinerOpKHR::KEEP,
                    ],
                );
            }
            State::LineStipple => {
                if use_khr_line_stipple {
                    device.cmd_set_line_stipple_khr(cmd, 1, 1);
                } else {
                    device.cmd_set_line_stipple_ext(cmd, 1, 1);
                }
            }
            State::CullMode => device.cmd_set_cull_mode_ext(cmd, vk::CullModeFlags::FRONT_AND_BACK),
            State::FrontFace => device.cmd_set_front_face_ext(cmd, vk::FrontFace::COUNTER_CLOCKWISE),
            State::PrimitiveTopology => {
                device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP)
            }
            State::ViewportWithCount => device.cmd_set_viewport_with_count_ext(cmd, &[unit_viewport]),
            State::ScissorWithCount => device.cmd_set_scissor_with_count_ext(cmd, &[unit_rect]),
            State::VertexInputBindingStride => {
                let bind_data = data.expect("bind vertex buffers data");
                let vertex_buffer = bind_data.vertex_buffer.get();
                let data_size = bind_data.data_size;
                let buffer_offset = bind_data.vertex_buffer.get_allocation().get_offset();
                let stride: vk::DeviceSize = 0;

                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, bind_data.pipeline.get());
                device.cmd_bind_vertex_buffers2_ext(
                    cmd,
                    0,
                    &[vertex_buffer],
                    &[buffer_offset],
                    &[data_size],
                    &[stride],
                );
            }
            State::DepthTestEnable => device.cmd_set_depth_test_enable_ext(cmd, true),
            State::DepthWriteEnable => device.cmd_set_depth_write_enable_ext(cmd, true),
            State::DepthCompareOp => device.cmd_set_depth_compare_op_ext(cmd, vk::CompareOp::LESS),
            State::DepthBoundsTestEnable => device.cmd_set_depth_bounds_test_enable_ext(cmd, true),
            State::StencilTestEnable => device.cmd_set_stencil_test_enable_ext(cmd, true),
            State::StencilOp => device.cmd_set_stencil_op_ext(
                cmd,
                vk::StencilFaceFlags::FRONT_AND_BACK,
                vk::StencilOp::ZERO,
                vk::StencilOp::INCREMENT_AND_CLAMP,
                vk::StencilOp::KEEP,
                vk::CompareOp::ALWAYS,
            ),
            State::ViewportWScaling => device.cmd_set_viewport_w_scaling_nv(
                cmd,
                0,
                &[vk::ViewportWScalingNV {
                    xcoeff: 1.0,
                    ycoeff: 1.0,
                }],
            ),
            State::ViewportShadingRatePalette => {
                let entry = vk::ShadingRatePaletteEntryNV::NO_INVOCATIONS;
                let palette = vk::ShadingRatePaletteNV {
                    shading_rate_palette_entry_count: 1,
                    shading_rate_palette_entries: &entry,
                };
                device.cmd_set_viewport_shading_rate_palette_nv(cmd, 0, &[palette]);
            }
            State::ViewportCoarseSampleOrder => {
                let locations = [
                    vk::CoarseSampleLocationNV {
                        pixel_x: 0,
                        pixel_y: 0,
                        sample: 0,
                    },
                    vk::CoarseSampleLocationNV {
                        pixel_x: 0,
                        pixel_y: 1,
                        sample: 0,
                    },
                ];
                let order = vk::CoarseSampleOrderCustomNV {
                    shading_rate: vk::ShadingRatePaletteEntryNV::_1_INVOCATION_PER_1X2_PIXELS,
                    sample_count: 1,
                    sample_location_count: locations.len() as u32,
                    sample_locations: locations.as_ptr(),
                };
                device.cmd_set_coarse_sample_order_nv(cmd, vk::CoarseSampleOrderTypeNV::CUSTOM, &[order]);
            }
            State::ExclusiveScissor => device.cmd_set_exclusive_scissor_nv(cmd, 0, &[unit_rect]),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum OperType {
    Compute,
    Transfer,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum WhenToSet {
    Before,
    After,
}

/// Set dynamic state before or after attempting to run a compute or transfer operation.
#[derive(Clone)]
struct TestParams {
    operation_type: OperType,
    when_to_set: WhenToSet,
    states: Vec<State>,
}

struct DynamicStateComputeCase {
    name: String,
    params: TestParams,
}

impl TestCase for DynamicStateComputeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DynamicStateComputeCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Check required functionalities.
        for &state in &self.params.states {
            for &functionality in state.requirements() {
                if functionality == "VK_KHR_or_EXT_line_rasterization" {
                    if !context.is_device_functionality_supported("VK_KHR_line_rasterization")
                        && !context.is_device_functionality_supported("VK_EXT_line_rasterization")
                    {
                        return Err(TestError::NotSupported(
                            "VK_KHR_line_rasterization and VK_EXT_line_rasterization are not supported".to_string(),
                        ));
                    }
                } else {
                    context.require_device_functionality(functionality)?;
                }
            }

            // VUID-vkCmdSetDepthBoundsTestEnable-depthBounds-10010
            if state == State::DepthBoundsTestEnable && context.get_device_features().depth_bounds == vk::FALSE {
                return Err(TestError::NotSupported("depthBounds not supported".to_string()));
            }
        }
        Ok(())
    }

    /// `DynamicStateComputeCase::initPrograms`
    fn programs(&self) -> BinaryCollection {
        let compute = self.params.operation_type == OperType::Compute;
        let stride = self.params.states.contains(&State::VertexInputBindingStride);
        match (compute, stride) {
            (true, true) => COMPUTE_TRANSFER_COMP_VERT.programs,
            (true, false) => COMPUTE_TRANSFER_COMP.programs,
            (false, true) => COMPUTE_TRANSFER_VERT.programs,
            (false, false) => NO_PROGRAMS,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicStateComputeInstance {
            context,
            params: &self.params,
        })
    }
}

struct DynamicStateComputeInstance<'a> {
    context: &'a Context<'a>,
    params: &'a TestParams,
}

/// `fillBuffer`
fn fill_buffer(device: &Device, buffer: &BufferWithMemory<'_>, values: &[u32]) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            values.as_ptr().cast::<u8>(),
            alloc.get_host_ptr(),
            std::mem::size_of_val(values),
        )
    };
    flush_alloc(device, alloc)
}

impl DynamicStateComputeInstance<'_> {
    fn use_khr_line_stipple(&self) -> bool {
        self.context
            .is_device_functionality_supported("VK_KHR_line_rasterization")
    }

    /// `iterateTransfer`
    fn iterate_transfer(&self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let helper = DeviceHelper::new(context, params.states[0])?;
        let device = helper.device();
        let queue = helper.queue();
        let alloc = helper.allocator();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Prepare two host-visible buffers for a transfer operation, with one element per dynamic state.
        let seq_start = 1611747605u32;

        let src_values: Vec<u32> = (0..params.states.len() as u32).map(|i| seq_start + i).collect();
        let dst_values = vec![0u32; src_values.len()];

        let elem_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let data_size = std::mem::size_of_val(src_values.as_slice()) as vk::DeviceSize;
        let atom_size = context.get_device_properties().limits.non_coherent_atom_size;
        let buffer_size = data_size.div_ceil(atom_size) * atom_size;
        let src_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC);
        let dst_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST);
        let src_buffer = BufferWithMemory::new(device, alloc, src_info, MemoryRequirement::HOST_VISIBLE)?;
        let dst_buffer = BufferWithMemory::new(device, alloc, dst_info, MemoryRequirement::HOST_VISIBLE)?;

        // Fill source and destination buffer.
        fill_buffer(device, &src_buffer, &src_values)?;
        fill_buffer(device, &dst_buffer, &dst_values)?;

        begin_command_buffer(device, cmd)?;

        // We need to preserve dynamic state data until the command buffer has run.
        let mut states_data: Vec<Option<BindVertexBuffersData<'_>>> = Vec::new();
        let use_khr_line_stipple = self.use_khr_line_stipple();

        for (state_idx, &state) in params.states.iter().enumerate() {
            // Get extra data needed for using the dynamic state.
            let offset = elem_size * state_idx as vk::DeviceSize;
            states_data.push(if state == State::VertexInputBindingStride {
                Some(BindVertexBuffersData::new(context, &helper)?)
            } else {
                None
            });
            let data = states_data.last().and_then(|d| d.as_ref());

            // Record command if before.
            if params.when_to_set == WhenToSet::Before {
                record_state(device, cmd, state, data, use_khr_line_stipple);
            }

            // Transfer op (copy one buffer element per dynamic state).
            let region = vk::BufferCopy {
                src_offset: offset,
                dst_offset: offset,
                size: elem_size,
            };
            unsafe { device.cmd_copy_buffer(cmd, src_buffer.get(), dst_buffer.get(), &[region]) };

            // Record command if after.
            if params.when_to_set == WhenToSet::After {
                record_state(device, cmd, state, data, use_khr_line_stipple);
            }
        }

        let barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Invalidate alloc and check destination buffer.
        let dst_buffer_alloc = dst_buffer.get_allocation();
        invalidate_alloc(device, dst_buffer_alloc)?;

        let results =
            unsafe { std::slice::from_raw_parts(dst_buffer_alloc.get_host_ptr().cast::<u32>(), src_values.len()) };

        for (value_idx, (&orig, &res)) in src_values.iter().zip(results).enumerate() {
            if orig != res {
                return Err(TestError::Fail(format!(
                    "Unexpected value found in destination buffer at position {value_idx} (found={res} expected={orig})"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `iterateCompute`
    fn iterate_compute(&self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let helper = DeviceHelper::new(context, params.states[0])?;
        let device = helper.device();
        let queue = helper.queue();
        let alloc = helper.allocator();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // Push constants.
        let pc_size = std::mem::size_of::<u32>() as u32;
        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: pc_size,
        };

        // Pipeline.
        let set_layouts = [*set_layout];
        let pc_ranges = [pc_range];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("comp")?)?;

        let shader_stage_info = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(shader_stage_info)
            .layout(*pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // Output buffer with one value per state.
        let mut buffer_data = vec![0u32; params.states.len()];
        let data_size = std::mem::size_of_val(buffer_data.as_slice());
        let atom_size = context.get_device_properties().limits.non_coherent_atom_size;
        let output_buffer_size = (data_size as vk::DeviceSize).div_ceil(atom_size) * atom_size;
        let buffer_create_info = make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER);

        let output_buffer = BufferWithMemory::new(device, alloc, buffer_create_info, MemoryRequirement::HOST_VISIBLE)?;
        let output_buffer_alloc = output_buffer.get_allocation();
        let output_buffer_ptr = output_buffer_alloc.get_host_ptr();

        unsafe { std::ptr::copy_nonoverlapping(buffer_data.as_ptr().cast::<u8>(), output_buffer_ptr, data_size) };
        flush_alloc(device, output_buffer_alloc)?;

        // Descriptor set.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let buffer_info = [vk::DescriptorBufferInfo::builder()
            .buffer(output_buffer.get())
            .offset(0)
            .range(output_buffer_size)
            .build()];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&buffer_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // Record and submit.
        begin_command_buffer(device, cmd)?;

        // We need to preserve dynamic state data until the command buffer has run.
        let mut states_data: Vec<Option<BindVertexBuffersData<'_>>> = Vec::new();
        let use_khr_line_stipple = self.use_khr_line_stipple();

        for (state_idx, &state) in params.states.iter().enumerate() {
            states_data.push(if state == State::VertexInputBindingStride {
                Some(BindVertexBuffersData::new(context, &helper)?)
            } else {
                None
            });
            let data = states_data.last().and_then(|d| d.as_ref());

            if params.when_to_set == WhenToSet::Before {
                record_state(device, cmd, state, data, use_khr_line_stipple);
            }

            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get());
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );

                // Each state will write to a different buffer position.
                let pc_data = state_idx as u32;
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout,
                    vk::ShaderStageFlags::COMPUTE,
                    0,
                    &pc_data.to_ne_bytes(),
                );
                device.cmd_dispatch(cmd, 1, 1, 1);
            }

            if params.when_to_set == WhenToSet::After {
                record_state(device, cmd, state, data, use_khr_line_stipple);
            }
        }

        // Barrier to read buffer contents.
        let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Read and verify buffer contents.
        invalidate_alloc(device, output_buffer_alloc)?;
        unsafe { std::ptr::copy_nonoverlapping(output_buffer_ptr, buffer_data.as_mut_ptr().cast::<u8>(), data_size) };

        for (idx, &value) in buffer_data.iter().enumerate() {
            if value != 1 {
                return Err(TestError::Fail(format!(
                    "Unexpected value found at buffer position {idx}: {value}"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for DynamicStateComputeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.params.operation_type == OperType::Compute {
            self.iterate_compute()
        } else {
            self.iterate_transfer()
        }
    }
}

/// `createDynamicStateComputeTests`
pub fn create_dynamic_state_compute_tests() -> TestCaseGroup {
    // Dynamic state mixed with compute and transfer operations
    let mut main_group = TestCaseGroup::new("compute_transfer");

    let operations = [(OperType::Compute, "compute"), (OperType::Transfer, "transfer")];
    let moments = [(WhenToSet::Before, "before"), (WhenToSet::After, "after")];

    // Tests with a single dynamic state.
    {
        let mut single_state_group = TestCaseGroup::new("single");

        for (operation_type, operation_name) in operations {
            let mut operation_group = TestCaseGroup::new(operation_name);

            for (state, state_name) in DYNAMIC_STATE_LIST {
                let mut state_group = TestCaseGroup::new(state_name);

                for (when_to_set, moment_name) in moments {
                    let params = TestParams {
                        operation_type,
                        when_to_set,
                        states: vec![state],
                    };
                    state_group.add_child(Box::new(DynamicStateComputeCase {
                        name: moment_name.to_string(),
                        params,
                    }) as Box<dyn TestCase>);
                }

                operation_group.add_child(state_group);
            }

            single_state_group.add_child(operation_group);
        }

        main_group.add_child(single_state_group);
    }

    // A few tests with several dynamic states.
    {
        let mut multi_state_group = TestCaseGroup::new("multi");

        for (operation_type, operation_name) in operations {
            let mut operation_group = TestCaseGroup::new(operation_name);

            for (when_to_set, moment_name) in moments {
                let mut params = TestParams {
                    operation_type,
                    when_to_set,
                    states: Vec::new(),
                };

                // Use the basic states so as not to introduce extra requirements.
                for (state, _) in DYNAMIC_STATE_LIST {
                    params.states.push(state);
                    if state == State::StencilReference {
                        break;
                    }
                }

                operation_group.add_child(Box::new(DynamicStateComputeCase {
                    name: moment_name.to_string(),
                    params,
                }) as Box<dyn TestCase>);
            }

            multi_state_group.add_child(operation_group);
        }

        main_group.add_child(multi_state_group);
    }

    main_group
}
