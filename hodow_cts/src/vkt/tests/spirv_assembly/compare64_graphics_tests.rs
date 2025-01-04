// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm64bitCompareTests.cpp (T64bitCompareTestInstance, graphics stages)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The vertex and fragment cases of `64bit_compare` (the compute ones are in `instruction_tests.rs` and share
// its operand tables and result check): three storage buffers (left operands, right operands, 0xffffffff-filled results), one point drawn through a render pass with no
// attachments, the results compared as upstream does (a NaN operand only counts when the shader preserves NaNs). The manifest is
// `shaders/manifest/spirv_assembly_compare64_graphics.toml`, written by `scripts/gen_spirv_assembly_compare64_graphics_manifest.py`.

use vulkanalia::prelude::v1_0::*;

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase, VerifyIo};
use super::instruction_tests::compare64_io;
use crate::generated::shaders::spirv_assembly_compare64_graphics::ALL_COMPARE64_GRAPHICS_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one vertex or fragment case.
#[derive(Clone, Copy)]
pub struct Compare64GraphicsCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

struct Compare64GraphicsTest {
    name: String,
    kind: &'static str,
    is_frag: bool,
    nan_preserve: bool,
    programs: BinaryCollection,
}

fn requirements(test: &Compare64GraphicsTest) -> ComputeShaderSpec {
    ComputeShaderSpec {
        shader_int64: test.kind != "compare64_double",
        features: if test.kind == "compare64_double" {
            vec![RequiredFeature::ShaderFloat64]
        } else {
            Vec::new()
        },
        float_controls_property: test.nan_preserve.then_some((64, "SignedZeroInfNanPreserve")),
        ..Default::default()
    }
}

impl TestCase for Compare64GraphicsTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `T64bitCompareTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        SpvAsmComputeShaderCase {
            name: self.name.clone(),
            spec: requirements(self),
            programs: self.programs,
        }
        .check_support(context)?;
        let features = context.get_device_features();
        if self.is_frag {
            if features.fragment_stores_and_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Fragment shader does not support stores".to_string(),
                ));
            }
        } else if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Vertex shader does not support stores".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let (inputs, outputs, verify_io) = compare64_io(self.kind, &self.name);
        Box::new(Compare64GraphicsInstance {
            context,
            is_frag: self.is_frag,
            inputs,
            outputs,
            verify_io,
        })
    }
}

struct Compare64GraphicsInstance<'a> {
    context: &'a Context<'a>,
    is_frag: bool,
    inputs: Vec<Vec<u8>>,
    outputs: Vec<Vec<u8>>,
    verify_io: Option<VerifyIo>,
}

impl TestInstance for Compare64GraphicsInstance<'_> {
    /// `T64bitCompareTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let stage = if self.is_frag {
            vk::ShaderStageFlags::FRAGMENT
        } else {
            vk::ShaderStageFlags::VERTEX
        };
        let pipeline_stage = if self.is_frag {
            vk::PipelineStageFlags::FRAGMENT_SHADER
        } else {
            vk::PipelineStageFlags::VERTEX_SHADER
        };

        let mut buffers = Vec::new();
        for (bytes, fill_byte) in self
            .inputs
            .iter()
            .map(|input| (input, None))
            .chain(self.outputs.iter().map(|output| (output, Some(0xffu8))))
        {
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(bytes.len() as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            match fill_byte {
                Some(byte) => unsafe {
                    std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), byte, bytes.len());
                },
                None => unsafe {
                    std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len());
                },
            }
            flush_alloc(device, buffer.get_allocation())?;
            buffers.push((buffer, bytes.len() as vk::DeviceSize));
        }

        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        let mut pool_builder = DescriptorPoolBuilder::new();
        for _ in &buffers {
            layout_builder = layout_builder.add_single_binding(vk::DescriptorType::STORAGE_BUFFER, stage);
            pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_BUFFER, 1);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let infos: Vec<vk::DescriptorBufferInfo> = buffers
            .iter()
            .map(|(buffer, size)| vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: *size,
            })
            .collect();
        let writes: Vec<vk::WriteDescriptorSet> = infos
            .iter()
            .enumerate()
            .map(|(binding, info)| vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: binding as u32,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: std::ptr::from_ref(info),
                texel_buffer_view: std::ptr::null(),
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let host_to_device: Vec<vk::BufferMemoryBarrier> = buffers
            .iter()
            .map(|(buffer, _)| {
                make_buffer_memory_barrier(
                    vk::AccessFlags::HOST_WRITE,
                    vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                    buffer.get(),
                    0,
                    vk::WHOLE_SIZE,
                )
            })
            .collect();
        let device_to_host: Vec<vk::BufferMemoryBarrier> = buffers
            .iter()
            .map(|(buffer, _)| {
                make_buffer_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    buffer.get(),
                    0,
                    vk::WHOLE_SIZE,
                )
            })
            .collect();

        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = if self.is_frag {
            Some(create_shader_module(device, binaries.get("frag")?)?)
        } else {
            None
        };
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let Some(frag) = &frag_module {
            stages.push((vk::ShaderStageFlags::FRAGMENT, **frag));
        }

        let render_pass = make_render_pass_without_attachments(device)?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST).with_full_viewport(1, 1);
        state.color_attachment_count = 0;
        state.rasterization.rasterizer_discard_enable = if self.is_frag { vk::FALSE } else { vk::TRUE };
        state.rasterization.depth_bias_enable = vk::FALSE;
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[], 1, 1, 1)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::HOST,
                pipeline_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &host_to_device,
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, 1, 1),
            clear_value_color([0.0, 0.0, 0.0, 0.0]),
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 1, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                pipeline_stage,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &device_to_host,
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let mut results = Vec::new();
        for ((buffer, size), expected) in buffers.iter().skip(self.inputs.len()).zip(&self.outputs) {
            invalidate_alloc(device, buffer.get_allocation())?;
            debug_assert_eq!(*size as usize, expected.len());
            results.push(
                unsafe {
                    std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), expected.len())
                }
                .to_vec(),
            );
        }
        let matches = match self.verify_io {
            Some(verify) => verify(&self.inputs, &results, &self.outputs),
            None => results == self.outputs,
        };
        if matches {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Invalid result found"))
        }
    }
}

/// The vertex and fragment `64bit_compare` cases as the groups of each case path below `graphics` and the test case.
pub fn create_compare64_graphics_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_COMPARE64_GRAPHICS_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            let kind = match segments.last().copied() {
                Some("double") => "compare64_double",
                Some("int64") => "compare64_int64",
                _ => "compare64_uint64",
            };
            let test: Box<dyn TestCase> = Box::new(Compare64GraphicsTest {
                name: leaf.to_string(),
                kind,
                is_frag: leaf.starts_with("frag_"),
                nan_preserve: leaf.contains("_withnan_"),
                programs: case.programs,
            });
            (segments, test)
        })
        .collect()
}

/// `makeRenderPassWithoutAttachments` (kept in `vkt::tests::tessellation::util`, which lives in another crate)
fn make_render_pass_without_attachments(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}
