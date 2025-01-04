// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderPropertyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are the task and mesh templates of each case specialized by
// scripts/gen_mesh_shader_nv_property.py into shaders/manifest/mesh_shader_nv_property.toml; the work group size cases use
// the programs of the work group invocations ones, as they inherit `initPrograms` upstream.
//
// The VK_NV_mesh_shader limits: each is pushed to the minimum the specification requires and the shader writes the
// invocation or work group index into a storage buffer that the test checks.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::NvMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_nv_property::{
    NV_PROPERTY_MAX_DRAW_MESH_TASKS_COUNT_WITH_MESH, NV_PROPERTY_MAX_DRAW_MESH_TASKS_COUNT_WITH_TASK,
    NV_PROPERTY_MAX_MESH_TOTAL_MEMORY_SIZE, NV_PROPERTY_MAX_MESH_WORK_GROUP_INVOCATIONS,
    NV_PROPERTY_MAX_TASK_OUTPUT_COUNT, NV_PROPERTY_MAX_TASK_TOTAL_MEMORY_SIZE,
    NV_PROPERTY_MAX_TASK_WORK_GROUP_INVOCATIONS,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::mesh_shader::util::{check_task_mesh_shader_support_nv, mesh_shader_properties_nv};
use crate::vkt::tests::pipeline::pipeline_util::make_color_depth_render_pass;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `genericCheckSupport`
fn generic_check_support(context: &Context<'_>, task_shader_needed: bool) -> Result<(), TestError> {
    check_task_mesh_shader_support_nv(context, task_shader_needed, true)?;

    if context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE {
        return Err(TestError::NotSupported(
            "Requested core feature is not supported: vertexPipelineStoresAndAtomics".to_string(),
        ));
    }

    Ok(())
}

/// `InstanceParams`
#[derive(Clone, Copy)]
struct InstanceParams {
    buffer_elements: u32,
    task_count: u32,
}

struct MeshShaderPropertyInstance<'a> {
    context: &'a Context<'a>,
    params: InstanceParams,
}

impl TestInstance for MeshShaderPropertyInstance<'_> {
    /// `MeshShaderPropertyInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vkd = context.get_device();
        let alloc = context.get_default_allocator();
        let queue_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let binaries = context.get_binary_collection();
        let extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let use_task = binaries.contains("task");

        let storage_buffer_size =
            vk::DeviceSize::from(self.params.buffer_elements) * std::mem::size_of::<u32>() as vk::DeviceSize;
        let storage_buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER;
        let storage_buffer_type = vk::DescriptorType::STORAGE_BUFFER;
        let storage_buffer_stages = vk::ShaderStageFlags::MESH_EXT
            | if use_task {
                vk::ShaderStageFlags::TASK_EXT
            } else {
                vk::ShaderStageFlags::empty()
            };

        // Create storage buffer with the required space.
        let storage_buffer = BufferWithMemory::new(
            vkd,
            alloc,
            make_buffer_create_info(storage_buffer_size, storage_buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let storage_buffer_alloc = storage_buffer.get_allocation();
        let storage_buffer_data_ptr = storage_buffer_alloc.get_host_ptr();
        let storage_buffer_desc_info = make_descriptor_buffer_info(storage_buffer.get(), 0, storage_buffer_size);

        unsafe { std::ptr::write_bytes(storage_buffer_data_ptr, 0xFF, storage_buffer_size as usize) };
        flush_alloc(vkd, storage_buffer_alloc)?;

        // Descriptor pool.
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(storage_buffer_type, 1).build(
            vkd,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;

        // Descriptor set layout and pipeline layout.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(storage_buffer_type, storage_buffer_stages)
            .build(vkd)?;
        let pipeline_layout = make_pipeline_layout(vkd, &[set_layout.get()])?;

        // Allocate and prepare descriptor set.
        let descriptor_set = make_descriptor_set(vkd, *descriptor_pool, set_layout.get())?;

        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                storage_buffer_type,
                &storage_buffer_desc_info,
            )
            .update(vkd);

        // Create empty render pass and framebuffer.
        let render_pass = make_color_depth_render_pass(
            vkd,
            vk::Format::UNDEFINED,
            vk::Format::UNDEFINED,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(vkd, *render_pass, &[], extent.width, extent.height, 1)?;

        // Shader modules and pipeline. There is no fragment shader.
        let task_module = if use_task {
            Some(create_shader_module(vkd, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(vkd, binaries.get("mesh")?)?;

        let mut stages = Vec::new();
        if let Some(task_module) = &task_module {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task_module));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(extent.width, extent.height);
        state.color_attachment_count = 0;
        let pipeline = create_draw_pipeline(vkd, *pipeline_layout, *render_pass, &stages, &state)?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(vkd, queue_index)?;
        let cmd_buffer_ptr = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;

        // Run the pipeline.
        begin_command_buffer(vkd, cmd_buffer)?;

        let render_pass_begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, extent.width, extent.height));
        unsafe {
            vkd.cmd_begin_render_pass(cmd_buffer, &render_pass_begin, vk::SubpassContents::INLINE);
            vkd.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            vkd.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
            vkd.cmd_draw_mesh_tasks_nv(cmd_buffer, self.params.task_count, 0);
            vkd.cmd_end_render_pass(cmd_buffer);

            let shader_to_host_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[shader_to_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vkd, cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, cmd_buffer)?;

        // Verify the storage buffer has the expected results.
        invalidate_alloc(vkd, storage_buffer_alloc)?;

        let buffer_data = unsafe {
            std::slice::from_raw_parts(
                storage_buffer_data_ptr.cast_const().cast::<u32>(),
                self.params.buffer_elements as usize,
            )
        };

        for (idx, &buffer_value) in buffer_data.iter().enumerate() {
            let expected = idx as u32;

            if buffer_value != expected {
                return Err(TestError::Fail(format!(
                    "Unexpected value found in buffer position {idx}: {buffer_value}"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum MaxDrawMeshTasksCountType {
    Task,
    Mesh,
}

/// `MaxDrawMeshTasksCountCase`
struct MaxDrawMeshTasksCountCase {
    name: String,
    test_type: MaxDrawMeshTasksCountType,
}

impl MaxDrawMeshTasksCountCase {
    const MIN_LIMIT: u32 = 65535;
}

impl TestCase for MaxDrawMeshTasksCountCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        generic_check_support(context, self.test_type == MaxDrawMeshTasksCountType::Task)?;

        let properties = mesh_shader_properties_nv(context);
        if properties.max_draw_mesh_tasks_count < Self::MIN_LIMIT {
            return Err(TestError::Fail(
                "maxDrawMeshTasksCount property below the minimum limit".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.test_type {
            MaxDrawMeshTasksCountType::Task => NV_PROPERTY_MAX_DRAW_MESH_TASKS_COUNT_WITH_TASK.programs,
            MaxDrawMeshTasksCountType::Mesh => NV_PROPERTY_MAX_DRAW_MESH_TASKS_COUNT_WITH_MESH.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let params = InstanceParams {
            buffer_elements: Self::MIN_LIMIT,
            task_count: Self::MIN_LIMIT,
        };
        Box::new(MeshShaderPropertyInstance { context, params })
    }
}

/// `MaxTaskWorkGroupInvocationsCase` and, through `is_size_case`, `MaxTaskWorkGroupSizeCase` which inherits its programs and instance
struct MaxTaskWorkGroupInvocationsCase {
    name: String,
    is_size_case: bool,
}

impl MaxTaskWorkGroupInvocationsCase {
    const MIN_LIMIT: u32 = 32;
    const MIN_SIZE_X: u32 = 32;
    const MIN_SIZE_Y: u32 = 1;
    const MIN_SIZE_Z: u32 = 1;
}

impl TestCase for MaxTaskWorkGroupInvocationsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        generic_check_support(context, true)?;

        let properties = mesh_shader_properties_nv(context);
        if self.is_size_case {
            if properties.max_task_work_group_size[0] < Self::MIN_SIZE_X
                || properties.max_task_work_group_size[1] < Self::MIN_SIZE_Y
                || properties.max_task_work_group_size[2] < Self::MIN_SIZE_Z
            {
                return Err(TestError::Fail(
                    "maxTaskWorkGroupSize property below the minimum limit".to_string(),
                ));
            }
        } else if properties.max_task_work_group_invocations < Self::MIN_LIMIT {
            return Err(TestError::Fail(
                "maxTaskWorkGroupInvocations property below the minimum limit".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NV_PROPERTY_MAX_TASK_WORK_GROUP_INVOCATIONS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let params = InstanceParams {
            buffer_elements: Self::MIN_LIMIT,
            task_count: 1,
        };
        Box::new(MeshShaderPropertyInstance { context, params })
    }
}

/// `MaxTaskOutputCountCase`
struct MaxTaskOutputCountCase {
    name: String,
}

impl MaxTaskOutputCountCase {
    const MIN_LIMIT: u32 = 65535;
}

impl TestCase for MaxTaskOutputCountCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        generic_check_support(context, true)?;

        let properties = mesh_shader_properties_nv(context);
        if properties.max_task_output_count < Self::MIN_LIMIT {
            return Err(TestError::Fail(
                "maxTaskOutputCount property below the minimum limit".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NV_PROPERTY_MAX_TASK_OUTPUT_COUNT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let params = InstanceParams {
            buffer_elements: Self::MIN_LIMIT,
            task_count: 1,
        };
        Box::new(MeshShaderPropertyInstance { context, params })
    }
}

/// `MaxMeshWorkGroupInvocationsCase` and, through `is_size_case`, `MaxMeshWorkGroupSizeCase`
struct MaxMeshWorkGroupInvocationsCase {
    name: String,
    is_size_case: bool,
}

impl MaxMeshWorkGroupInvocationsCase {
    const MIN_LIMIT: u32 = 32;
    const MIN_SIZE_X: u32 = 32;
    const MIN_SIZE_Y: u32 = 1;
    const MIN_SIZE_Z: u32 = 1;
}

impl TestCase for MaxMeshWorkGroupInvocationsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        generic_check_support(context, false)?;

        let properties = mesh_shader_properties_nv(context);
        if self.is_size_case {
            if properties.max_mesh_work_group_size[0] < Self::MIN_SIZE_X
                || properties.max_mesh_work_group_size[1] < Self::MIN_SIZE_Y
                || properties.max_mesh_work_group_size[2] < Self::MIN_SIZE_Z
            {
                return Err(TestError::Fail(
                    "maxMeshWorkGroupSize property below the minimum limit".to_string(),
                ));
            }
        } else if properties.max_mesh_work_group_invocations < Self::MIN_LIMIT {
            return Err(TestError::Fail(
                "maxMeshWorkGroupInvocations property below the minimum limit".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NV_PROPERTY_MAX_MESH_WORK_GROUP_INVOCATIONS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let params = InstanceParams {
            buffer_elements: Self::MIN_LIMIT,
            task_count: 1,
        };
        Box::new(MeshShaderPropertyInstance { context, params })
    }
}

const TOTAL_MEMORY_LOCAL_SIZE: u32 = 32;
const TOTAL_MEMORY_MIN_LIMIT: u32 = 16384;

/// `MaxTaskTotalMemorySizeCase`
struct MaxTaskTotalMemorySizeCase {
    name: String,
}

impl TestCase for MaxTaskTotalMemorySizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        generic_check_support(context, true)?;

        let properties = mesh_shader_properties_nv(context);
        if properties.max_task_total_memory_size < TOTAL_MEMORY_MIN_LIMIT {
            return Err(TestError::Fail(
                "maxTaskTotalMemorySize property below the minimum limit".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NV_PROPERTY_MAX_TASK_TOTAL_MEMORY_SIZE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let params = InstanceParams {
            buffer_elements: TOTAL_MEMORY_LOCAL_SIZE,
            task_count: 1,
        };
        Box::new(MeshShaderPropertyInstance { context, params })
    }
}

/// `MaxMeshTotalMemorySizeCase`
struct MaxMeshTotalMemorySizeCase {
    name: String,
}

impl TestCase for MaxMeshTotalMemorySizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        generic_check_support(context, false)?;

        let properties = mesh_shader_properties_nv(context);
        if properties.max_mesh_total_memory_size < TOTAL_MEMORY_MIN_LIMIT {
            return Err(TestError::Fail(
                "maxMeshTotalMemorySize property below the minimum limit".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NV_PROPERTY_MAX_MESH_TOTAL_MEMORY_SIZE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let params = InstanceParams {
            buffer_elements: TOTAL_MEMORY_LOCAL_SIZE,
            task_count: 1,
        };
        Box::new(MeshShaderPropertyInstance { context, params })
    }
}

/// `createMeshShaderPropertyTests`
pub fn create_mesh_shader_property_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("property");

    main_group.add_child(Box::new(MaxDrawMeshTasksCountCase {
        name: "max_draw_mesh_tasks_count_with_task".to_string(),
        test_type: MaxDrawMeshTasksCountType::Task,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxDrawMeshTasksCountCase {
        name: "max_draw_mesh_tasks_count_with_mesh".to_string(),
        test_type: MaxDrawMeshTasksCountType::Mesh,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxTaskWorkGroupInvocationsCase {
        name: "max_task_work_group_invocations".to_string(),
        is_size_case: false,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxTaskWorkGroupInvocationsCase {
        name: "max_task_work_group_size".to_string(),
        is_size_case: true,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxTaskOutputCountCase {
        name: "max_task_output_count".to_string(),
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxMeshWorkGroupInvocationsCase {
        name: "max_mesh_work_group_invocations".to_string(),
        is_size_case: false,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxMeshWorkGroupInvocationsCase {
        name: "max_mesh_work_group_size".to_string(),
        is_size_case: true,
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxTaskTotalMemorySizeCase {
        name: "max_task_total_memory_size".to_string(),
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxMeshTotalMemorySizeCase {
        name: "max_mesh_total_memory_size".to_string(),
    }) as Box<dyn TestCase>);

    main_group
}
