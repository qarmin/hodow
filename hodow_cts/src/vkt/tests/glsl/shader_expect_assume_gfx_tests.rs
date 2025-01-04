// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderExpectAssumeTests.cpp (the vertex and fragment stages of `ShaderExpectAssumeTestInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders and the case table (`shader_expect_assume_gfx_cases.rs`) are written by
// `scripts/gen_shader_expect_assume_gfx_manifest.py`, the data of the storage buffer cases is the one of the compute cases (`input_data`).
//
// Six vertices (two triangles over the 32x1 target) are drawn with dynamic rendering into an R32G32_UINT attachment that holds (x, result) per pixel; the
// vertex cases hand the result to the fragment stage through a flat varying. Every pixel has to hold (x, 1).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::shader_expect_assume_gfx_cases::GFX_CASES;
use super::shader_expect_assume_tests::{NUM_ELEMENTS, field, input_data};
use crate::generated::shaders::shader_expect_assume_gfx::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_dynamic_rendering, end_dynamic_rendering,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R32G32_UINT;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Vertex,
    Fragment,
}

impl Stage {
    fn flags(self) -> vk::ShaderStageFlags {
        match self {
            Self::Vertex => vk::ShaderStageFlags::VERTEX,
            Self::Fragment => vk::ShaderStageFlags::FRAGMENT,
        }
    }
}

struct ExpectAssumeGfxCase {
    name: &'static str,
    stage: Stage,
    spec: &'static str,
    key: &'static str,
}

impl TestCase for ExpectAssumeGfxCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `ShaderExpectAssumeCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_shader_expect_assume")?;
        context.require_device_functionality("VK_KHR_dynamic_rendering")?;

        match field(self.spec, "type") {
            "int64" => {
                if context.get_device_features().shader_int64 == vk::FALSE {
                    return Err(TestError::NotSupported("64-bit integers not supported".to_string()));
                }
            }
            "int16" => {
                context.require_device_functionality("VK_KHR_16bit_storage")?;
                if context.get_device_features().shader_int16 == vk::FALSE {
                    return Err(TestError::NotSupported("16-bit integers not supported".to_string()));
                }
                let mut storage16 = vk::PhysicalDevice16BitStorageFeatures::default();
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut storage16);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
                if storage16.storage_buffer_16bit_access == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "16-bit storage buffer access not supported".to_string(),
                    ));
                }
                // VUID-RuntimeSpirv-uniformAndStorageBuffer16BitAccess-06332
                if storage16.uniform_and_storage_buffer_16bit_access == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "16-bit uniform and storage buffer access not supported".to_string(),
                    ));
                }
            }
            "int8" => {
                context.require_device_functionality("VK_KHR_shader_float16_int8")?;
                context.require_device_functionality("VK_KHR_8bit_storage")?;
                let mut float16_int8 = vk::PhysicalDeviceShaderFloat16Int8Features::default();
                let mut storage8 = vk::PhysicalDevice8BitStorageFeatures::default();
                let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                    .push_next(&mut float16_int8)
                    .push_next(&mut storage8);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
                if float16_int8.shader_int8 == vk::FALSE {
                    return Err(TestError::NotSupported("8-bit integers not supported".to_string()));
                }
                if storage8.storage_buffer_8bit_access == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "8-bit storage buffer access not supported".to_string(),
                    ));
                }
                if storage8.uniform_and_storage_buffer_8bit_access == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "8-bit Uniform storage buffer access not supported".to_string(),
                    ));
                }
            }
            _ => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExpectAssumeGfxInstance {
            context,
            stage: self.stage,
            spec: self.spec,
        })
    }
}

struct ExpectAssumeGfxInstance<'a> {
    context: &'a Context<'a>,
    stage: Stage,
    spec: &'static str,
}

fn host_buffer<'a>(
    context: &'a Context<'a>,
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

impl TestInstance for ExpectAssumeGfxInstance<'_> {
    /// `ShaderExpectAssumeTestInstance::iterate` and `render`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let data_class = field(self.spec, "class");
        let data_type = field(self.spec, "type");
        let channels: u32 = field(self.spec, "chan").parse().expect("a channel count");
        let wrong = field(self.spec, "wrong") == "1";

        // The attachment, a row of `NUM_ELEMENTS` texels.
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            make_image_create_info(
                crate::tcu::IVec2::new(NUM_ELEMENTS as i32, 1),
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_range,
        )?;

        // `generateVertexBuffer`: two triangles over the whole target.
        let positions: [[f32; 2]; 6] = [
            [-1.0, -1.0],
            [1.0, 1.0],
            [-1.0, 1.0],
            [-1.0, -1.0],
            [1.0, -1.0],
            [1.0, 1.0],
        ];
        let position_bytes: Vec<u8> = positions
            .iter()
            .flatten()
            .flat_map(|value| value.to_ne_bytes())
            .collect();
        let vertex_buffer = host_buffer(context, &position_bytes, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // `generateStorageBuffers`: the input buffer is the largest the 64-bit four component case needs.
        let output_size = (NUM_ELEMENTS * 2 * 4) as vk::DeviceSize;
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(output_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let input_data = if data_class == "storage" {
            input_data(data_type, channels, wrong)
        } else {
            vec![0u8; NUM_ELEMENTS as usize * 8 * 4]
        };
        let input_buffer = host_buffer(context, &input_data, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Pipeline layout: the storage buffer at binding 0, or a push constant of one VkBool32.
        let stage_flags = self.stage.flags();
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, stage_flags)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: std::mem::size_of::<vk::Bool32>() as u32,
        }];
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout = match data_class {
            "storage" => make_pipeline_layout(device, &set_layouts)?,
            "push" => {
                let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
                crate::vk::ref_util::Unique::new(
                    device,
                    unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
                )
            }
            _ => make_pipeline_layout(device, &[])?,
        };
        let descriptor_set = if data_class == "storage" {
            let set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
            let buffer_info = make_descriptor_buffer_info(input_buffer.get(), 0, vk::WHOLE_SIZE);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    set.get(),
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &buffer_info,
                )
                .update(device);
            Some(set)
        } else {
            None
        };

        // Pipeline: only the R and G channels are written, the specialization constant is true when the case has one.
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(NUM_ELEMENTS, 1);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 2]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        state.color_attachment_count = 1;
        state.rendering_format = Some(COLOR_FORMAT);
        state.color_blend_attachment = Some(vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::ONE,
            dst_color_blend_factor: vk::BlendFactor::ONE,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ONE,
            dst_alpha_blend_factor: vk::BlendFactor::ONE,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::R | vk::ColorComponentFlags::G,
        });
        if data_class == "specialization" {
            state.all_stages_specialization_u32 = Some(1);
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            vk::RenderPass::null(),
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        // `render`
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            let to_color = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                color_image.get(),
                color_range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_color],
            );
        }
        begin_dynamic_rendering(
            device,
            cmd,
            rect_2d(NUM_ELEMENTS, 1),
            &[RenderingAttachment {
                view: *color_view,
                layout: vk::ImageLayout::GENERAL,
                clear_value: vk::ClearValue {
                    color: vk::ClearColorValue { uint32: [0; 4] },
                },
            }],
            None,
            None,
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if data_class == "push" {
                let value: vk::Bool32 = vk::TRUE;
                device.cmd_push_constants(cmd, *pipeline_layout, stage_flags, 0, &value.to_ne_bytes());
            } else if let Some(set) = &descriptor_set {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[set.get()],
                    &[] as &[u32],
                );
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, 6, 1, 0, 0);
        }
        end_dynamic_rendering(device, cmd);
        unsafe {
            let memory_barrier = vk::MemoryBarrier {
                s_type: vk::StructureType::MEMORY_BARRIER,
                next: std::ptr::null(),
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::TRANSFER_READ,
            };
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            let region = make_buffer_image_copy(
                vk::Extent3D {
                    width: NUM_ELEMENTS,
                    height: 1,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::GENERAL,
                output_buffer.get(),
                &[region],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // `validateOutput`: (x, verification result) per pixel.
        invalidate_alloc(device, output_buffer.get_allocation())?;
        let output = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast::<u32>().cast_const(),
                NUM_ELEMENTS as usize * 2,
            )
        };
        for i in 0..NUM_ELEMENTS as usize {
            if output[i * 2] != i as u32 || output[i * 2 + 1] != 1 {
                return Ok(TestStatus::fail("Result comparison failed"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `addShaderExpectAssumeTests` for the vertex and the fragment stage: the `vertex` and `fragment` groups, each with `expect` and `assume`.
pub fn create_vertex_and_fragment_groups() -> Vec<TestCaseGroup> {
    let mut groups = Vec::new();
    for (stage_name, stage) in [("vertex", Stage::Vertex), ("fragment", Stage::Fragment)] {
        let mut expect = TestCaseGroup::new("expect");
        let mut assume = TestCaseGroup::new("assume");
        for &(case_stage, op, name, spec, key) in GFX_CASES.iter() {
            if case_stage != stage_name {
                continue;
            }
            let case = Box::new(ExpectAssumeGfxCase { name, stage, spec, key }) as Box<dyn TestCase>;
            if op == "expect" {
                expect.add_child(case);
            } else {
                assume.add_child(case);
            }
        }
        let mut group = TestCaseGroup::new(stage_name);
        group.add_child(expect);
        group.add_child(assume);
        groups.push(group);
    }
    groups
}
