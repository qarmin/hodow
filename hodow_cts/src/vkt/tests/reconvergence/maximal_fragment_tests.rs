// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/reconvergence/maximal/fragment/*.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the Amber graphics pipeline does for these scripts is done directly: a 16x16 R32G32B32A32_SFLOAT target cleared to zero, one
// draw of the three vertices of the script, the storage buffers `fragments` (binding 0) and `result` (binding 1, initially 99), and the check that `result` is 1. The scripts are
// read by `scripts/gen_reconvergence_fragment_amber.py`, which writes the shaders and `maximal_fragment_cases.rs`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::maximal_fragment_cases::MAXIMAL_FRAGMENT_CASES;
use crate::generated::shaders::reconvergence_fragment::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_create_info, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// One Amber script of `reconvergence.maximal.fragment`
pub struct MaximalFragmentCase {
    pub name: &'static str,
    pub key: &'static str,
    pub vertices: [f32; 6],
    /// The words of the `fragments` buffer: four fragment ids, or one
    pub fragments: &'static [u32],
    pub size: (u32, u32),
    /// The shader demotes (`GL_EXT_demote_to_helper_invocation`)
    pub demote: bool,
    /// The shader terminates (`GL_EXT_terminate_invocation`)
    pub terminate: bool,
}

const TARGET_FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;

struct MaximalFragmentTestCase {
    data: &'static MaximalFragmentCase,
}

impl TestCase for MaximalFragmentTestCase {
    fn name(&self) -> &str {
        self.data.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_shader_maximal_reconvergence")?;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut maximal = vk::PhysicalDeviceShaderMaximalReconvergenceFeaturesKHR::default();
        let mut demote = vk::PhysicalDeviceShaderDemoteToHelperInvocationFeatures::default();
        let mut terminate = vk::PhysicalDeviceShaderTerminateInvocationFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut maximal)
            .push_next(&mut demote)
            .push_next(&mut terminate);
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
        if maximal.shader_maximal_reconvergence == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderMaximalReconvergence not supported".to_string(),
            ));
        }
        if self.data.demote && demote.shader_demote_to_helper_invocation == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderDemoteToHelperInvocation not supported".to_string(),
            ));
        }
        if self.data.terminate && terminate.shader_terminate_invocation == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderTerminateInvocation not supported".to_string(),
            ));
        }
        if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }

        let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
        if !subgroup_properties
            .supported_stages
            .contains(vk::ShaderStageFlags::FRAGMENT)
            || !subgroup_properties
                .supported_operations
                .contains(vk::SubgroupFeatureFlags::BALLOT)
        {
            return Err(TestError::NotSupported(
                "fragment subgroup ballot operations are required".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.data.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaximalFragmentInstance {
            context,
            data: self.data,
        })
    }
}

struct MaximalFragmentInstance<'a> {
    context: &'a Context<'a>,
    data: &'static MaximalFragmentCase,
}

fn host_buffer_with<'a>(
    context: &'a Context<'_>,
    bytes: &[u8],
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(bytes.len() as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

impl TestInstance for MaximalFragmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let (width, height) = data.size;
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let target = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                crate::tcu::IVec2::new(width as i32, height as i32),
                TARGET_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        let target_view = make_image_view(device, target.get(), vk::ImageViewType::_2D, TARGET_FORMAT, range)?;
        let render_pass = make_render_pass(device, TARGET_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target_view], width, height, 1)?;

        let fragment_bytes: Vec<u8> = data.fragments.iter().flat_map(|word| word.to_ne_bytes()).collect();
        let fragments = host_buffer_with(context, &fragment_bytes, vk::BufferUsageFlags::STORAGE_BUFFER)?;
        let result = host_buffer_with(context, &99u32.to_ne_bytes(), vk::BufferUsageFlags::STORAGE_BUFFER)?;
        let vertex_bytes: Vec<u8> = data.vertices.iter().flat_map(|value| value.to_ne_bytes()).collect();
        let vertices = host_buffer_with(context, &vertex_bytes, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT, 1, 1)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let fragments_info = vk::DescriptorBufferInfo {
            buffer: fragments.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };
        let result_info = vk::DescriptorBufferInfo {
            buffer: result.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &fragments_info,
            )
            .write_single(
                descriptor_set.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_info,
            )
            .update(device);

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
        state.color_attachment_count = 1;
        state.bindings.push(vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        });
        state.attributes.push(vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        });

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        // CLEAR_COLOR mainPipeline 0 0 0 0
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, width, height),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertices.get()], &[0]);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        unsafe {
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, result.get_allocation())?;
        let value = unsafe { std::ptr::read(result.get_allocation().get_host_ptr().cast_const().cast::<u32>()) };
        // EXPECT result IDX 0 EQ 1
        if value != 1 {
            log::error!("result is {value}, expected 1");
            return Ok(TestStatus::fail("Probe failed"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `dEQP-VK.reconvergence.maximal`, with the `fragment` scripts
pub fn create_maximal_fragment_tests() -> TestCaseGroup {
    let mut fragment = TestCaseGroup::new("fragment");
    for data in MAXIMAL_FRAGMENT_CASES {
        fragment.add_child(Box::new(MaximalFragmentTestCase { data }) as Box<dyn TestCase>);
    }
    let mut maximal = TestCaseGroup::new("maximal");
    maximal.add_child(fragment);
    maximal
}
