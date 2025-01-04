// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `simple.pointcoord*` cases of `builtin_var`: sixteen random points drawn with a VulkanDrawContext (the point size rides in
// the z component of the vertex, which the ShaderRenderCase harness cannot carry) and compared with a reference drawn by hand through a fuzzy compare. The shaders are in
// `shaders/manifest/shader_render_builtin_var.toml` (`pointcoord_default`, `pointcoord_uniform_frag`, `pointcoord_uniform_vert`). The image is cleared to black as the draw
// context does, where upstream's harness clears to its own colour; the reference is cleared the same way, so the verdict is not affected.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::shader_render_builtin_var::ALL_SHARED_PROGRAM;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::random::Random;
use crate::tcu::vector::Vec4;
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
use crate::vkt::{Context, TestCase, TestInstance};

const VIEWPORT_SIZE: u32 = 128;
const NUM_POINTS: usize = 16;

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum PointCoordVariant {
    Default,
    UniformVertex,
    UniformFragment,
}

/// `BuiltinGlPointCoordCase`
pub struct PointCoordCase {
    pub name: &'static str,
    pub variant: PointCoordVariant,
}

impl TestCase for PointCoordCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = match self.variant {
            PointCoordVariant::Default => "sr_builtin_var_pointcoord_default",
            PointCoordVariant::UniformFragment => "sr_builtin_var_pointcoord_uniform_frag",
            PointCoordVariant::UniformVertex => "sr_builtin_var_pointcoord_uniform_vert",
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PointCoordInstance {
            context,
            variant: self.variant,
        })
    }
}

/// `BuiltinGlPointCoordCaseInstance`
struct PointCoordInstance<'a> {
    context: &'a Context<'a>,
    variant: PointCoordVariant,
}

impl TestInstance for PointCoordInstance<'_> {
    /// `BuiltinGlPointCoordCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let width = VIEWPORT_SIZE as i32;
        let height = VIEWPORT_SIZE as i32;
        let threshold = 0.02f32;
        let scale = [1.0 / width as f32, 1.0 / height as f32, 1.0f32];

        // Compute coordinates.
        let mut rnd = Random::new(0x145fa);
        let mut coords = [[0.0f32; 3]; NUM_POINTS];
        {
            let limits = context.get_device_properties().limits;
            let min_point_size = limits.point_size_range[0];
            let max_point_size = limits.point_size_range[1];
            let point_size_delta_multiples =
                (((max_point_size - min_point_size) / limits.point_size_granularity).ceil() as i32).max(1);

            if min_point_size > max_point_size {
                return Err(TestError::Fail("minPointSize <= maxPointSize".to_string()));
            }

            for coord in coords.iter_mut() {
                coord[0] = rnd.get_float_range(-0.9, 0.9);
                coord[1] = rnd.get_float_range(-0.9, 0.9);
                coord[2] = max_point_size.min(
                    min_point_size + rnd.get_int(0, point_size_delta_multiples) as f32 * limits.point_size_granularity,
                );
            }
        }
        let vertices: Vec<Vec4> = coords.iter().map(|c| Vec4::new(c[0], c[1], c[2], 1.0)).collect();

        let uses_uniform = self.variant != PointCoordVariant::Default;
        let descriptor_set_layout = if uses_uniform {
            Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(
                        vk::DescriptorType::UNIFORM_BUFFER,
                        vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT,
                    )
                    .build(device)?,
            )
        } else {
            None
        };
        let descriptor_pool = if uses_uniform {
            Some(
                DescriptorPoolBuilder::new()
                    .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                    .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
            )
        } else {
            None
        };
        let uniform_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of::<[f32; 3]>() as vk::DeviceSize,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                scale.as_ptr().cast::<u8>(),
                uniform_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of::<[f32; 3]>(),
            )
        };
        flush_alloc(device, uniform_buffer.get_allocation())?;
        let descriptor_set = match (&descriptor_pool, &descriptor_set_layout) {
            (Some(pool), Some(layout)) => {
                let set = make_descriptor_set(device, **pool, **layout)?;
                let buffer_info = make_descriptor_buffer_info(uniform_buffer.get(), 0, vk::WHOLE_SIZE);
                DescriptorSetUpdateBuilder::new()
                    .write_single(
                        set.get(),
                        Location::binding(0),
                        vk::DescriptorType::UNIFORM_BUFFER,
                        &buffer_info,
                    )
                    .update(device);
                Some(set)
            }
            _ => None,
        };

        let binaries = context.get_binary_collection();
        let shaders = vec![
            VulkanShader {
                stage: vk::ShaderStageFlags::VERTEX,
                binary: binaries.get("vert")?,
            },
            VulkanShader {
                stage: vk::ShaderStageFlags::FRAGMENT,
                binary: binaries.get("frag")?,
            },
        ];
        let framebuffer_state = FrameBufferState::new(VIEWPORT_SIZE, VIEWPORT_SIZE);
        let pipeline_state = PipelineState::new(context.get_device_properties().limits.sub_pixel_precision_bits as i32);
        let draw_call_data = DrawCallData {
            topology: vk::PrimitiveTopology::POINT_LIST,
            vertices: &vertices,
        };
        let mut vulkan_program = VulkanProgram::new(shaders);
        if let (Some(layout), Some(set)) = (&descriptor_set_layout, &descriptor_set) {
            vulkan_program.descriptor_set_layout = **layout;
            vulkan_program.descriptor_set = set.get();
        }
        let mut draw_context = VulkanDrawContext::new(context, &framebuffer_state)?;
        draw_context.register_draw_object(&pipeline_state, &vulkan_program, &draw_call_data)?;
        draw_context.draw()?;
        let result = draw_context.get_color_pixels()?;

        // Draw reference
        let mut reference = TextureLevel::new(result.get_const_access().format(), VIEWPORT_SIZE, VIEWPORT_SIZE, 1)?;
        {
            let mut access = reference.get_access();
            for y in 0..VIEWPORT_SIZE {
                for x in 0..VIEWPORT_SIZE {
                    access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
                }
            }

            for point in &coords {
                let mut x = point[0];
                let mut y = point[1];
                if self.variant == PointCoordVariant::UniformVertex {
                    x *= scale[0];
                    y *= scale[1];
                }
                let center_x = width as f32 * (x * 0.5 + 0.5);
                let center_y = height as f32 * (y * 0.5 + 0.5);
                let size = point[2];
                let x0 = (center_x - size * 0.5).round() as i32;
                let y0 = (center_y - size * 0.5).round() as i32;
                let x1 = (center_x + size * 0.5).round() as i32;
                let y1 = (center_y + size * 0.5).round() as i32;
                let w = x1 - x0;
                let h = y1 - y0;

                for yo in 0..h {
                    for xo in 0..w {
                        let dx = x0 + xo;
                        let dy = y0 + yo;
                        let frag_x = dx as f32 + 0.5;
                        let frag_y = dy as f32 + 0.5;
                        let s = 0.5 + (frag_x - center_x) / size;
                        let t = 0.5 + (frag_y - center_y) / size;
                        let mut color = [s, t, 0.0f32, 1.0f32];

                        if self.variant == PointCoordVariant::UniformFragment {
                            color[0] *= scale[0];
                            color[1] *= scale[1];
                            color[2] *= scale[2];
                        }

                        if (0..width).contains(&dx) && (0..height).contains(&dy) {
                            access.set_pixel(color, dx as u32, dy as u32, 0);
                        }
                    }
                }
            }
        }

        match fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), threshold) {
            Some(true) => Ok(TestStatus::pass("Result image matches reference")),
            Some(false) => Ok(TestStatus::fail("Image mismatch")),
            None => Err(TestError::Fail("the result format cannot be compared".to_string())),
        }
    }
}
