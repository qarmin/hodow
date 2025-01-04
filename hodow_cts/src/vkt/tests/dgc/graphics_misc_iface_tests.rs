// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_iface.toml` (`scripts/gen_dgc_iface_manifest.py`);
// the four interfaces of `MultiIfaceCase::initPrograms` are written out there. The pipelines are made by `build_draw_pipeline`.
//
// Here: `interface_matching`, `ies_replace` and `ies_add`, each with and without shader objects, of `dgc.ext.graphics.misc`
// (IfaceMatchingInstance, IESReplaceInstance, IESAdditionInstance): four quadrants drawn with four shader sets of different interfaces from
// one execution set, in one execution, one execution per quadrant replacing the first set entry, or one per quadrant adding entries
// without waiting in between.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_iface::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, PipelineOptions, StageModules, bind_shader_object_state, bind_shaders_with_nulls,
    build_draw_pipeline, copy_image_to_buffer, float_threshold_compare, make_address_buffer, push_back_element,
};
use crate::vkt::tests::dgc::graphics_misc_tests::write_buffer_bytes;
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, create_dgc_shader,
};
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, end_rendering};
use crate::vkt::tests::shader_object::util::ShaderObject;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const QUADRANTS: u32 = 4;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: Vec4 = [0.0, 0.0, 0.0, 1.0];
const QUADRANT_EXTENT: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    /// Prepare the IES with multiple pipelines/shaders and interfaces, execute once.
    SingleExec,
    /// Use a single IES entry, replacing it between multiple executions.
    Replace,
    /// Multiple IES entries, multiple executions without synchronization.
    Addition,
}

#[derive(Clone, Copy)]
struct Params {
    test_type: TestType,
    use_shader_objects: bool,
}

struct MultiIfaceCase {
    name: String,
    params: Params,
}

impl TestCase for MultiIfaceCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let use_shader_objects = self.params.use_shader_objects;
        check_dgc_ext_support(
            context,
            stages,
            if use_shader_objects {
                vk::ShaderStageFlags::empty()
            } else {
                stages
            },
            if use_shader_objects {
                stages
            } else {
                vk::ShaderStageFlags::empty()
            },
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        if use_shader_objects {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "iface")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IfaceMatchingInstance {
            context,
            params: self.params,
        })
    }
}

struct IfaceMatchingInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// `checkResults`: the result image matches the interfaces and values of the shaders.
fn check_results(result: &[u8]) -> bool {
    let quadrant = QUADRANT_EXTENT as usize;
    let extent = quadrant * 2;
    let norm = |v: usize| (v as f32 + 0.5) / quadrant as f32;
    let mut reference: Vec<Vec4> = vec![CLEAR_COLOR; extent * extent];
    for y in 0..quadrant {
        for x in 0..quadrant {
            reference[y * extent + x] = [norm(x), 0.0, 0.0, 1.0];
            reference[y * extent + x + quadrant] = [1.0, norm(x), 0.5, norm(y)];
            reference[(y + quadrant) * extent + x] = [0.5, 1.0, norm(x), 1.0];
            reference[(y + quadrant) * extent + x + quadrant] = [norm(y), norm(x), 1.0, 1.0];
        }
    }
    let threshold = 0.005f32; // 1/255 < 0.005 < 2/255
    float_threshold_compare(result, &reference, [threshold; 4])
}

/// Clears and transitions the image to COLOR_ATTACHMENT_OPTIMAL outside the render pass.
fn clear_and_transition(device: &Device, cmd_buffer: vk::CommandBuffer, image: vk::Image) {
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let pre_clear_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        color_srr,
    );
    let post_clear_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        image,
        color_srr,
    );
    let clear_color = vk::ClearColorValue { float32: CLEAR_COLOR };
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_clear_barrier],
        );
        device.cmd_clear_color_image(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_color,
            &[color_srr],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_clear_barrier],
        );
    }
}

/// A render pass with one colour attachment that keeps the contents of the image (it was cleared before) and leaves it in
/// COLOR_ATTACHMENT_OPTIMAL.
fn make_load_render_pass(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let color_refs = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// What the three `submitWork` variants share.
struct Work<'a, 'b> {
    context: &'a Context<'a>,
    params: Params,
    vert_shaders: &'b [ShaderObject<'a>],
    frag_shaders: &'b [ShaderObject<'a>],
    pipelines: &'b [crate::vkt::tests::dgc::graphics_draw_tests::DrawPipeline<'a>],
    pc_range: vk::PushConstantRange,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    fb_extent: u32,
    cmds_layout: vk::IndirectCommandsLayoutEXT,
    dgc_buffer: &'b DgcBuffer<'a>,
    dgc_stride: u32,
    vertex_buffer: vk::Buffer,
    color_buffer: &'b ImageWithBuffer<'a>,
}

impl<'a> Work<'a, '_> {
    /// The execution set with the first shaders or pipeline.
    fn make_ies(&self) -> Result<ExecutionSetManagerExt<'a>, TestError> {
        let device = self.context.get_device();
        if self.params.use_shader_objects {
            let no_layouts: Vec<vk::DescriptorSetLayout> = Vec::new();
            let stages = [
                (self.vert_shaders[0].get(), no_layouts.clone()),
                (self.frag_shaders[0].get(), no_layouts),
            ];
            ExecutionSetManagerExt::new_shader(device, &stages, &[self.pc_range], QUADRANTS * 2)
        } else {
            ExecutionSetManagerExt::new_pipeline(device, *self.pipelines[0], QUADRANTS)
        }
    }

    /// Adds the shaders or pipeline of quadrant `quadrant` at the given execution set index (the first of the pair for shader objects).
    fn add_to_ies(&self, manager: &mut ExecutionSetManagerExt<'a>, index: u32, quadrant: usize) {
        if self.params.use_shader_objects {
            manager.add_shader(index, self.vert_shaders[quadrant].get());
            manager.add_shader(index + 1, self.frag_shaders[quadrant].get());
        } else {
            manager.add_pipeline(index, *self.pipelines[quadrant]);
        }
    }

    /// Begins rendering and binds the initial state and the vertex buffer: the first shaders or pipeline.
    fn begin_and_bind(&self, cmd_buffer: vk::CommandBuffer) {
        let device = self.context.get_device();
        let render_area = make_rect_2d(0, 0, self.fb_extent, self.fb_extent);
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: CLEAR_COLOR },
        };
        if self.params.use_shader_objects {
            begin_rendering(
                device,
                cmd_buffer,
                *self.color_buffer.view,
                render_area,
                clear_value,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::LOAD,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
            bind_shaders_with_nulls(
                self.context,
                cmd_buffer,
                &[
                    (vk::ShaderStageFlags::VERTEX, self.vert_shaders[0].get()),
                    (vk::ShaderStageFlags::FRAGMENT, self.frag_shaders[0].get()),
                ],
            );
            let vertex_bindings = [vk::VertexInputBindingDescription2EXT {
                binding: 0,
                stride: std::mem::size_of::<Vec4>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            }];
            let vertex_attributes = [vk::VertexInputAttributeDescription2EXT {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
                ..Default::default()
            }];
            bind_shader_object_state(
                self.context,
                cmd_buffer,
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                0,
                (self.fb_extent, self.fb_extent),
                Some((&vertex_bindings[..], &vertex_attributes[..])),
            );
        } else {
            begin_render_pass(
                device,
                cmd_buffer,
                self.render_pass,
                self.framebuffer,
                render_area,
                clear_value,
            );
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *self.pipelines[0]) };
        }
        unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[self.vertex_buffer], &[0]) };
    }

    fn end_rendering(&self, cmd_buffer: vk::CommandBuffer) {
        let device = self.context.get_device();
        if self.params.use_shader_objects {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }
    }

    fn copy_result(&self, cmd_buffer: vk::CommandBuffer) {
        copy_image_to_buffer(
            self.context.get_device(),
            cmd_buffer,
            self.color_buffer.image.get(),
            self.color_buffer.buffer.get(),
            self.fb_extent,
            self.fb_extent,
            1,
        );
    }

    /// `IfaceMatchingInstance::submitWork`: everything in one execution.
    fn submit_single(&self) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        let mut manager = self.make_ies()?;
        for quadrant in 0..QUADRANTS as usize {
            // Indices must match what we store in the DGC data.
            let index = if self.params.use_shader_objects {
                2 * quadrant as u32
            } else {
                quadrant as u32
            };
            self.add_to_ies(&mut manager, index, quadrant);
        }
        manager.update();
        let ies = manager.get();

        let preprocess_buffer =
            PreprocessBufferExt::new(context, ies, self.cmds_layout, QUADRANTS, 0, vk::Pipeline::null(), 0)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        clear_and_transition(device, cmd_buffer, self.color_buffer.image.get());
        self.begin_and_bind(cmd_buffer);
        let cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            ies,
            self.cmds_layout,
            self.dgc_buffer.get_device_address(),
            self.dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            QUADRANTS,
            0,
            0,
            vk::Pipeline::null(),
        );
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        self.end_rendering(cmd_buffer);
        self.copy_result(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)
    }

    /// `IESReplaceInstance::submitWork` (`replace`) and `IESAdditionInstance::submitWork` (not `replace`): one execution per quadrant.
    fn submit_per_quadrant(&self, replace: bool) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        let mut manager = self.make_ies()?;
        let ies = manager.get();

        // One preprocess buffer reused between executions when replacing; as there may be multiple parallel executions when adding, one
        // for each of them then.
        let max_sequences = 1;
        let mut preprocess_buffers = Vec::new();
        for _ in 0..(if replace { 1 } else { QUADRANTS }) {
            preprocess_buffers.push(PreprocessBufferExt::new(
                context,
                ies,
                self.cmds_layout,
                max_sequences,
                0,
                vk::Pipeline::null(),
                0,
            )?);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        // Clear and transition image outside the render pass.
        {
            let owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = owner.get();
            begin_command_buffer(device, cmd_buffer)?;
            clear_and_transition(device, cmd_buffer, self.color_buffer.image.get());
            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, queue, cmd_buffer)?;
        }

        // The command buffers cannot be destroyed while in flight when not waiting.
        let mut cmd_buffer_owners = Vec::new();
        let mut fences: Vec<vk::Fence> = Vec::new();
        for quadrant in 0..QUADRANTS as usize {
            let owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = owner.get();
            cmd_buffer_owners.push(owner);

            // Update the IES replacing the first elements of it, or adding elements to it.
            let index = match (replace, self.params.use_shader_objects) {
                (true, _) => 0,
                (false, true) => 2 * quadrant as u32,
                (false, false) => quadrant as u32,
            };
            self.add_to_ies(&mut manager, index, quadrant);
            manager.update();

            begin_command_buffer(device, cmd_buffer)?;
            self.begin_and_bind(cmd_buffer);

            // Run single sequence `quadrant`.
            let preprocess_buffer = &preprocess_buffers[if replace { 0 } else { quadrant }];
            let cmds_info = DgcGenCmdsInfo::new(
                shader_stages,
                ies,
                self.cmds_layout,
                self.dgc_buffer.get_device_address() + u64::from(self.dgc_stride) * quadrant as u64,
                vk::DeviceSize::from(self.dgc_stride),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                max_sequences,
                0,
                0,
                vk::Pipeline::null(),
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
            self.end_rendering(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;

            if replace {
                submit_commands_and_wait(device, queue, cmd_buffer)?;
            } else {
                // Submit *without* wait.
                let fence =
                    unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
                fences.push(fence);
                let cmd_buffers = [cmd_buffer];
                let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
                unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;
            }
        }

        if !fences.is_empty() {
            let result = unsafe { device.wait_for_fences(&fences, true, u64::MAX) }.vk_check("vkWaitForFences");
            for fence in fences {
                unsafe { device.destroy_fence(fence, None) };
            }
            result?;
        }

        // Finally copy the image to the output buffer.
        let owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = owner.get();
        begin_command_buffer(device, cmd_buffer)?;
        self.copy_result(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)
    }
}

impl TestInstance for IfaceMatchingInstance<'_> {
    /// `IfaceMatchingInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let fb_extent = QUADRANT_EXTENT * 2;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let use_shader_objects = params.use_shader_objects;

        // We'll use a quad covering (0,0) to (1,1) and pass offsets in each draw as push constants.
        let vertices: Vec<Vec4> = vec![
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let (vertex_buffer, _) = make_address_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let draw_cmd = vk::DrawIndirectCommand {
            vertex_count: vertices.len() as u32,
            instance_count: 1,
            first_vertex: 0,
            first_instance: 0,
        };

        // Color buffer.
        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, FORMAT, color_usage, 4)?;

        let pc_range = vk::PushConstantRange {
            stage_flags: shader_stages,
            offset: 0,
            size: (std::mem::size_of::<Vec4>() * 2) as u32,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;

        // Push constants: the scale is fixed, the offset moves the quad to each quadrant.
        let offsets: [Vec4; 4] = [
            [-1.0, -1.0, 0.0, 0.0],
            [0.0, -1.0, 0.0, 0.0],
            [-1.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
        ];
        let push_constants: Vec<[f32; 8]> = offsets
            .iter()
            .map(|offset| [1.0, 1.0, 1.0, 1.0, offset[0], offset[1], offset[2], offset[3]])
            .collect();

        let ies_type = if use_shader_objects {
            vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
        } else {
            vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
        };
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stages,
            *pipeline_layout,
        );
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_execution_set_token(offset, ies_type, shader_stages);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Increasing indices for pipelines and increasing double indices for shader objects; the replacement case always uses the same
        // elements.
        let ies_indices: Vec<u32> = (0..QUADRANTS)
            .flat_map(|i| match (params.test_type, use_shader_objects) {
                (TestType::Replace, true) => vec![0, 1],
                (TestType::Replace, false) => vec![0],
                (_, true) => vec![2 * i, 2 * i + 1],
                (_, false) => vec![i],
            })
            .collect();

        let per_quadrant = if use_shader_objects { 2 } else { 1 };
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..QUADRANTS as usize {
            // IES indices (pipeline or shaders).
            for j in 0..per_quadrant {
                dgc_data.push(ies_indices[per_quadrant * i + j]);
            }
            push_back_element(&mut dgc_data, &push_constants[i]);
            push_back_element(&mut dgc_data, &draw_cmd);
        }
        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: a u32 slice viewed as bytes.
        let dgc_bytes = unsafe { std::slice::from_raw_parts(dgc_data.as_ptr().cast::<u8>(), dgc_buffer_size as usize) };
        write_buffer_bytes(device, dgc_buffer.get_allocation(), dgc_bytes)?;
        flush_alloc(device, dgc_buffer.get_allocation())?;

        let binaries = context.get_binary_collection();
        let features = context.get_device_features();
        let tess_feature = features.tessellation_shader != vk::FALSE;
        let geom_feature = features.geometry_shader != vk::FALSE;
        let mut vert_modules = Vec::new();
        let mut frag_modules = Vec::new();
        let mut vert_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut frag_shaders: Vec<ShaderObject<'_>> = Vec::new();
        for i in 0..QUADRANTS {
            let vert_binary = binaries.get(&format!("vert{i}"))?;
            let frag_binary = binaries.get(&format!("frag{i}"))?;
            if use_shader_objects {
                vert_shaders.push(create_dgc_shader(
                    device,
                    vk::ShaderStageFlags::VERTEX,
                    &vert_binary,
                    &[],
                    &[pc_range],
                    tess_feature,
                    geom_feature,
                )?);
                frag_shaders.push(create_dgc_shader(
                    device,
                    vk::ShaderStageFlags::FRAGMENT,
                    &frag_binary,
                    &[],
                    &[pc_range],
                    tess_feature,
                    geom_feature,
                )?);
            } else {
                vert_modules.push(create_shader_module(device, vert_binary)?);
                frag_modules.push(create_shader_module(device, frag_binary)?);
            }
        }

        let render_pass = make_load_render_pass(device)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        let mut pipelines = Vec::new();
        if !use_shader_objects {
            for i in 0..QUADRANTS as usize {
                pipelines.push(build_draw_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    &StageModules {
                        vert: *vert_modules[i],
                        tesc: None,
                        tese: None,
                        geom: None,
                        frag: *frag_modules[i],
                    },
                    &PipelineOptions {
                        extent: (fb_extent, fb_extent),
                        topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                        patch_control_points: 0,
                        dynamic_stride: false,
                        dynamic_patch_control_points: false,
                        no_vertex_input: false,
                        extra_attribute: false,
                        indirect_bindable: true,
                        construction: Construction::Monolithic,
                        depth_test: false,
                        rendering: None,
                    },
                )?);
            }
        }

        // Different variants submit work in different ways, but all should produce the same results.
        let work = Work {
            context,
            params,
            vert_shaders: &vert_shaders,
            frag_shaders: &frag_shaders,
            pipelines: &pipelines,
            pc_range,
            render_pass: *render_pass,
            framebuffer: *framebuffer,
            fb_extent,
            cmds_layout: cmds_layout.get(),
            dgc_buffer: &dgc_buffer,
            dgc_stride: cmds_layout_builder.get_stream_stride(),
            vertex_buffer: vertex_buffer.get(),
            color_buffer: &color_buffer,
        };
        match params.test_type {
            TestType::SingleExec => work.submit_single()?,
            TestType::Replace => work.submit_per_quadrant(true)?,
            TestType::Addition => work.submit_per_quadrant(false)?,
        }

        let result = color_buffer.read_bytes(device)?;
        if !check_results(result) {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `interface_matching`, `ies_replace` and `ies_add` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_iface_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (test_type, base) in [
        (TestType::SingleExec, "interface_matching"),
        (TestType::Replace, "ies_replace"),
        (TestType::Addition, "ies_add"),
    ] {
        for use_shader_objects in [false, true] {
            let name = format!("{base}{}", if use_shader_objects { "_shader_objects" } else { "" });
            cases.push((
                format!("ext.graphics.misc.{name}"),
                Box::new(MultiIfaceCase {
                    name,
                    params: Params {
                        test_type,
                        use_shader_objects,
                    },
                }),
            ));
        }
    }
    cases
}
