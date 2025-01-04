// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderInvarianceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree (`invariance` and `precise`, the latter with `extended_instructions`) is the table
// `shader_render_invariance_cases.rs` that `scripts/gen_shader_render_invariance.py` writes together with the three shaders of every case (`vertex1`,
// `vertex2` and `fragment`, read out of the vendored C++), found by manifest key.
//
// The same 72 narrow and 72 ordinary triangles are drawn twice with the two vertex shaders, first in red and then in green; an invariant (or precise) position
// makes the second draw cover everything the first one did, so a red pixel left in the image is variance.

use vulkanalia::prelude::v1_0::*;

use super::shader_render_invariance_cases::INVARIANCE_CASES;
use crate::generated::shaders::shader_render_invariance::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, make_buffer_create_info, make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::util::draw_util::{
    DrawCallData, FrameBufferState, PipelineState, VulkanDrawContext, VulkanProgram, VulkanShader,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 256;
const NUM_TRIANGLES: usize = 72;

struct InvarianceCase {
    name: &'static str,
    key: &'static str,
}

impl TestCase for InvarianceCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InvarianceInstance { context })
    }
}

struct InvarianceInstance<'a> {
    context: &'a Context<'a>,
}

/// `genRandomVector`
fn gen_random_vector(rnd: &mut Random) -> [f32; 4] {
    let x = rnd.get_float_range(-1.0, 1.0);
    let y = rnd.get_float_range(-1.0, 1.0);
    let z = rnd.get_float_range(-1.0, 1.0);
    let w = rnd.get_float_range(0.2, 1.0);
    [x, y, z, w]
}

impl TestInstance for InvarianceInstance<'_> {
    /// `InvarianceTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let mut rnd = Random::new(123);
        let mut vertices = vec![[0.0f32; 4]; NUM_TRIANGLES * 3 * 2];

        // Narrow triangle pattern
        for tri_ndx in 0..NUM_TRIANGLES {
            let vertex1 = gen_random_vector(&mut rnd);
            let vertex2 = gen_random_vector(&mut rnd);
            let offset = gen_random_vector(&mut rnd);
            // Generate narrow triangles.
            let vertex3: [f32; 4] = std::array::from_fn(|c| vertex2[c] + offset[c] * 0.01);

            vertices[tri_ndx * 3] = vertex1;
            vertices[tri_ndx * 3 + 1] = vertex2;
            vertices[tri_ndx * 3 + 2] = vertex3;
        }

        // Normal triangle pattern
        for tri_ndx in 0..NUM_TRIANGLES {
            vertices[(NUM_TRIANGLES + tri_ndx) * 3] = gen_random_vector(&mut rnd);
            vertices[(NUM_TRIANGLES + tri_ndx) * 3 + 1] = gen_random_vector(&mut rnd);
            vertices[(NUM_TRIANGLES + tri_ndx) * 3 + 2] = gen_random_vector(&mut rnd);
        }

        // Descriptors: one uniform buffer with the colour per pass.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let colors: [[f32; 4]; 2] = [[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0]];
        let mut uniform_buffers = Vec::with_capacity(2);
        let mut descriptor_sets = Vec::with_capacity(2);
        for color in colors {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(
                    std::mem::size_of::<[f32; 4]>() as vk::DeviceSize,
                    vk::BufferUsageFlags::UNIFORM_BUFFER,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    color.as_ptr().cast::<u8>(),
                    buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of::<[f32; 4]>(),
                )
            };
            flush_alloc(device, buffer.get_allocation())?;

            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
            let buffer_info = make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    descriptor_set.get(),
                    Location::binding(0),
                    vk::DescriptorType::UNIFORM_BUFFER,
                    &buffer_info,
                )
                .update(device);
            uniform_buffers.push(buffer);
            descriptor_sets.push(descriptor_set);
        }

        // Pick the first available depth buffer format.
        let depth_format = [
            vk::Format::D32_SFLOAT,
            vk::Format::D24_UNORM_S8_UINT,
            vk::Format::X8_D24_UNORM_PACK32,
        ]
        .into_iter()
        .find(|&format| {
            let properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), format)
            };
            properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        });
        let Some(depth_format) = depth_format else {
            return Ok(TestStatus::fail(
                "There must be at least one depth depth format handled (Vulkan spec 37.3, table 65)",
            ));
        };

        let mut framebuffer_state = FrameBufferState::new(RENDER_SIZE, RENDER_SIZE);
        framebuffer_state.depth_format = depth_format;
        let pipeline_state = PipelineState::new(context.get_device_properties().limits.sub_pixel_precision_bits as i32);
        let draw_call_data = DrawCallData {
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            vertices: &vertices
                .iter()
                .map(|v| crate::tcu::vector::Vector::from_array(*v))
                .collect::<Vec<_>>(),
        };
        let mut draw_context = VulkanDrawContext::new(context, &framebuffer_state)?;

        let binaries = context.get_binary_collection();
        for (pass_ndx, vertex_shader_name) in ["vertex1", "vertex2"].into_iter().enumerate() {
            let mut program = VulkanProgram::new(vec![
                VulkanShader {
                    stage: vk::ShaderStageFlags::VERTEX,
                    binary: binaries.get(vertex_shader_name)?,
                },
                VulkanShader {
                    stage: vk::ShaderStageFlags::FRAGMENT,
                    binary: binaries.get("fragment")?,
                },
            ]);
            program.descriptor_set_layout = *descriptor_set_layout;
            program.descriptor_set = descriptor_sets[pass_ndx].get();
            draw_context.register_draw_object(&pipeline_state, &program, &draw_call_data)?;
        }
        draw_context.draw()?;

        let result = draw_context.get_color_pixels()?;
        let image = result.get_const_access();

        // The same triangles are drawn twice - first in red and then in green: no red may be left.
        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                if image.get_pixel_int(x, y, 0)[0] != 0 {
                    return Ok(TestStatus::fail("Detected variance between two invariant values"));
                }
            }
        }
        Ok(TestStatus::pass("Passed"))
    }
}

/// `createShaderInvarianceTests` and `createShaderPreciseTests`: the `invariance` and `precise` groups of `glsl`.
pub fn create_invariance_and_precise_tests() -> Vec<TestCaseGroup> {
    let mut roots: Vec<TestCaseGroup> = Vec::new();
    for &(path, name, key) in INVARIANCE_CASES.iter() {
        let segments: Vec<&str> = path.split('/').collect();
        if !roots.iter().any(|root| root.name() == segments[0]) {
            roots.push(TestCaseGroup::new(segments[0]));
        }
        let mut group = roots
            .iter_mut()
            .find(|root| root.name() == segments[0])
            .expect("just added");
        for segment in &segments[1..] {
            if group.group_mut(segment).is_none() {
                group.add_child(TestCaseGroup::new(*segment));
            }
            group = group.group_mut(segment).expect("just added");
        }
        group.add_child(Box::new(InvarianceCase { name, key }) as Box<dyn TestCase>);
    }
    roots
}
