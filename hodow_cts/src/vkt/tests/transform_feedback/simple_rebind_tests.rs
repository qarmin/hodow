// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp (`TEST_TYPE_SHADER_OBJECT_REBIND`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Mobica Limited.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `shader_object_rebind` of the `simple` group: four vertex shader objects, each writing
// its own `xfb_buffer`, bound one after the other between draws into one buffer cut in random parts. Upstream only adds it to the monolithic
// group. The shaders are the `rebind_vert*` ones of `shaders/manifest/transform_feedback_simple_streams.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtShaderObjectExtensionDeviceCommands, ExtTransformFeedbackExtensionDeviceCommands, Handle,
    InstanceV1_1,
};

use super::simple_tests::{IMAGE_SIZE, MINIMUM_TF_BUFFER_SIZE, make_pipeline_layout, validate_limits};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::draw::util::{end_rendering, rect_2d};
use crate::vkt::tests::shader_object::util::{
    ShaderObject, bind_graphics_shaders, create_shader, get_mesh_shader_features, make_shader_create_info,
    remove_unsupported_shader_object_extensions, set_default_shader_object_dynamic_states,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const BUFFER_SIZE: u32 = 256;
const PART_COUNT: u32 = 4;

struct ShaderObjectRebindCase;

impl TestCase for ShaderObjectRebindCase {
    fn name(&self) -> &str {
        "shader_object_rebind"
    }

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

        context.require_device_functionality("VK_EXT_shader_object")?;

        let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
        if PART_COUNT > xfb_properties.max_transform_feedback_buffers {
            return Err(TestError::NotSupported(format!(
                "Required transform feedback buffer count {PART_COUNT} greater than maxTransformFeedbackBuffers"
            )));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::transform_feedback_simple_streams::XFB_STREAM_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectRebindInstance { context })
    }
}

struct ShaderObjectRebindInstance<'a> {
    context: &'a Context<'a>,
}

/// `TransformFeedbackTestInstance::generateSizesList`: `chunk_count` parts of `buf_bytes` at random multiples of four bytes.
fn generate_sizes_list(rnd: &mut Random, buf_bytes: usize, chunk_count: usize) -> Vec<vk::DeviceSize> {
    let min_chunk_slot = 1i32;
    let max_chunk_slot = (buf_bytes / std::mem::size_of::<u32>()) as i32;
    let mut prev_offset_slot = 0i32;
    let mut offsets_set: std::collections::BTreeSet<i32> = std::collections::BTreeSet::new();
    let mut result: Vec<vk::DeviceSize> = Vec::new();

    debug_assert!(buf_bytes <= MINIMUM_TF_BUFFER_SIZE as usize);
    debug_assert!(8 * chunk_count <= max_chunk_slot as usize);

    offsets_set.insert(0);

    // Create a list of unique offsets first
    for _chunk_ndx in 1..chunk_count {
        let mut chunk_slot;

        loop {
            chunk_slot = rnd.get_int(min_chunk_slot, max_chunk_slot - 1);
            if !offsets_set.contains(&chunk_slot) {
                break;
            }
        }

        offsets_set.insert(chunk_slot);
    }
    offsets_set.insert(max_chunk_slot);

    // Calculate sizes of offsets list
    for &offset_slot in &offsets_set {
        if offset_slot == 0 {
            continue;
        }

        result.push(((offset_slot - prev_offset_slot) as usize * std::mem::size_of::<u32>()) as vk::DeviceSize);

        prev_offset_slot = offset_slot;
    }

    debug_assert!(result.len() == chunk_count);

    result
}

impl TestInstance for ShaderObjectRebindInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        validate_limits(context)?;

        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        let extensions = remove_unsupported_shader_object_extensions(context)?;
        let mesh_features = get_mesh_shader_features(context);

        let pipeline_layout = make_pipeline_layout(device)?;
        let push_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        };
        let binaries = context.get_binary_collection();
        let mut vertex_shaders: Vec<ShaderObject<'_>> = Vec::with_capacity(PART_COUNT as usize);
        for i in 0..PART_COUNT {
            let binary = binaries.get(&format!("rebind_vert{i}"))?;
            let create_info = make_shader_create_info(
                vk::ShaderStageFlags::VERTEX,
                &binary,
                false,
                false,
                None,
                Some(&push_range),
            );
            vertex_shaders.push(create_shader(device, &create_info)?);
        }

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();

        let tf_buf = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                BUFFER_SIZE as u64,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let mut rnd = Random::new(0);
        let tf_buf_binding_sizes = generate_sizes_list(&mut rnd, BUFFER_SIZE as usize, PART_COUNT as usize);
        let mut tf_buf_binding_offsets = Vec::with_capacity(tf_buf_binding_sizes.len());
        let mut offset = 0u64;
        for size in &tf_buf_binding_sizes {
            tf_buf_binding_offsets.push(offset);
            offset += size;
        }
        let tf_bufs = vec![tf_buf.get(); PART_COUNT as usize];

        begin_command_buffer(device, cmd)?;
        {
            let rendering_info = vk::RenderingInfo::builder()
                .render_area(rect_2d(IMAGE_SIZE, IMAGE_SIZE))
                .layer_count(1)
                .view_mask(0);
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
            {
                set_default_shader_object_dynamic_states(
                    device,
                    cmd,
                    &extensions,
                    vk::PrimitiveTopology::POINT_LIST,
                    false,
                    false,
                    IMAGE_SIZE,
                    IMAGE_SIZE,
                );
                let null = vk::ShaderEXT::null();
                bind_graphics_shaders(
                    device,
                    cmd,
                    null,
                    null,
                    null,
                    null,
                    null,
                    mesh_features.task_shader != vk::FALSE,
                    mesh_features.mesh_shader != vk::FALSE,
                );

                unsafe {
                    device.cmd_bind_transform_feedback_buffers_ext(
                        cmd,
                        0,
                        &tf_bufs,
                        &tf_buf_binding_offsets,
                        &tf_buf_binding_sizes,
                    );

                    for draw_ndx in 0..PART_COUNT as usize {
                        let start_value = (tf_buf_binding_offsets[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;
                        let num_points = (tf_buf_binding_sizes[draw_ndx] / std::mem::size_of::<u32>() as u64) as u32;

                        device.cmd_bind_shaders_ext(
                            cmd,
                            &[vk::ShaderStageFlags::VERTEX],
                            &[vertex_shaders[draw_ndx].get()],
                        );

                        device.cmd_push_constants(
                            cmd,
                            *pipeline_layout,
                            vk::ShaderStageFlags::VERTEX,
                            0,
                            &start_value.to_ne_bytes(),
                        );

                        (device.commands().cmd_begin_transform_feedback_ext)(
                            cmd,
                            0,
                            0,
                            std::ptr::null(),
                            std::ptr::null(),
                        );
                        device.cmd_draw(cmd, num_points, 1, 0, 0);
                        (device.commands().cmd_end_transform_feedback_ext)(
                            cmd,
                            0,
                            0,
                            std::ptr::null(),
                            std::ptr::null(),
                        );
                    }
                }
            }
            end_rendering(device, cmd);

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // verifyTransformFeedbackBuffer
        invalidate_alloc(device, tf_buf.get_allocation())?;
        let tf_data = unsafe {
            std::slice::from_raw_parts(
                tf_buf.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                BUFFER_SIZE as usize / std::mem::size_of::<u32>(),
            )
        };
        for (i, &received) in tf_data.iter().enumerate() {
            if received != i as u32 {
                return Err(TestError::Fail(format!(
                    "Failed at item {i} received:{received} expected:{i}"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `shader_object_rebind` block of `createTransformFeedbackSimpleTests`; upstream registers it for the monolithic construction only.
pub(super) fn add_rebind_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(ShaderObjectRebindCase) as Box<dyn TestCase>);
}
