// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineSpecConstantTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The case tables of upstream (`CaseDefinition`s) are
// in `scripts/gen_spec_constant_manifest.py`: the GLSL goes into the shader manifest, and what the host needs rides along as the
// parameters of `SpecConstantPrograms` - the specialization constants as `id,size,forceUse,hexValue` entries, the expected values
// as `size,offset,hexValue` entries - which this module parses. The tree of groups is built from the case names, which are the
// test paths joined by `__`.
//
// `unaligned_spec_constant` and `same_id`, which build their own compute shaders and pipelines, are `spec_constant_asm_tests`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_spec_constant::ALL_SPEC_CONSTANT_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages_specialized};
use crate::vkt::tests::pipeline::spec_constant_asm_tests::SpecConstantAsmCase;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries: one test case of `spec_constant`.
#[derive(Clone, Copy)]
pub struct SpecConstantPrograms {
    pub name: &'static str,
    pub stage: &'static str,
    pub spec_constants: &'static str,
    pub ssbo_size: u32,
    pub expected: &'static str,
    pub requirements: &'static str,
    pub pack_data: bool,
    pub programs: BinaryCollection,
}

/// `SpecConstant`, without the declaration code (it is in the shader).
struct SpecConstant {
    spec_id: u32,
    size: usize,
    force_use: bool,
    /// Up to `size` bytes of the value.
    value: Vec<u8>,
}

/// `OffsetValue`
struct OffsetValue {
    size: usize,
    offset: usize,
    value: Vec<u8>,
}

fn parse_hex(text: &str) -> Vec<u8> {
    (0..text.len() / 2)
        .map(|i| u8::from_str_radix(&text[i * 2..i * 2 + 2], 16).expect("the manifest has valid hex"))
        .collect()
}

fn parse_spec_constants(text: &str) -> Vec<SpecConstant> {
    text.split(';')
        .filter(|entry| !entry.is_empty())
        .map(|entry| {
            let fields: Vec<&str> = entry.split(',').collect();
            SpecConstant {
                spec_id: fields[0].parse().expect("the manifest has valid spec ids"),
                size: fields[1].parse().expect("the manifest has valid sizes"),
                force_use: fields[2] == "1",
                value: parse_hex(fields[3]),
            }
        })
        .collect()
}

fn parse_expected(text: &str) -> Vec<OffsetValue> {
    text.split(';')
        .filter(|entry| !entry.is_empty())
        .map(|entry| {
            let fields: Vec<&str> = entry.split(',').collect();
            OffsetValue {
                size: fields[0].parse().expect("the manifest has valid sizes"),
                offset: fields[1].parse().expect("the manifest has valid offsets"),
                value: parse_hex(fields[2]),
            }
        })
        .collect()
}

/// `Specialization` - the map entries and the data of the `VkSpecializationInfo` (none when nothing is specialized).
fn make_specialization(spec_constants: &[SpecConstant], pack_data: bool) -> (Vec<vk::SpecializationMapEntry>, Vec<u8>) {
    const GENERIC_VALUE_SIZE: usize = 8;

    // Reserve memory for the worst case in the data.
    let mut data = vec![u8::MAX; spec_constants.len() * GENERIC_VALUE_SIZE];
    let mut entries = Vec::new();

    let mut offset = 0usize;
    for spec_constant in spec_constants {
        if spec_constant.size != 0 || spec_constant.force_use {
            if spec_constant.size > 0 {
                data[offset..offset + spec_constant.size].copy_from_slice(&spec_constant.value[..spec_constant.size]);
            }
            entries.push(vk::SpecializationMapEntry {
                constant_id: spec_constant.spec_id,
                offset: offset as u32,
                size: spec_constant.size,
            });
            offset += if pack_data {
                spec_constant.size
            } else {
                GENERIC_VALUE_SIZE
            };
        }
    }

    data.truncate(offset);
    (entries, data)
}

/// `verifyValues` - check if expected values exist in the memory.
fn verify_values(memory: &[u8], expected_values: &[OffsetValue]) -> bool {
    expected_values
        .iter()
        .all(|expected| memory[expected.offset..expected.offset + expected.size] == expected.value[..expected.size])
}

struct SpecConstantCase {
    name: String,
    entry: &'static SpecConstantPrograms,
}

impl SpecConstantCase {
    fn stage(&self) -> vk::ShaderStageFlags {
        match self.entry.stage {
            "vertex" => vk::ShaderStageFlags::VERTEX,
            "fragment" => vk::ShaderStageFlags::FRAGMENT,
            "tess_control" => vk::ShaderStageFlags::TESSELLATION_CONTROL,
            "tess_eval" => vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            "geometry" => vk::ShaderStageFlags::GEOMETRY,
            _ => vk::ShaderStageFlags::COMPUTE,
        }
    }
}

impl TestCase for SpecConstantCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `requireFeatures(context, m_caseDef.requirements | getShaderStageRequirements(m_stage))`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stage = self.stage();
        let features = context.get_device_features();

        if (stage == vk::ShaderStageFlags::TESSELLATION_CONTROL
            || stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION)
            && features.tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if stage == vk::ShaderStageFlags::GEOMETRY && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }

        // All tests use SSBO writes to read back results.
        if stage != vk::ShaderStageFlags::COMPUTE {
            if stage == vk::ShaderStageFlags::FRAGMENT {
                if features.fragment_stores_and_atomics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "SSBO and image writes not supported in fragment shader".to_string(),
                    ));
                }
            } else if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "SSBO and image writes not supported in vertex pipeline".to_string(),
                ));
            }
        }

        let requirements: Vec<&str> = self
            .entry
            .requirements
            .split(',')
            .filter(|requirement| !requirement.is_empty())
            .collect();
        if requirements.contains(&"int64") && features.shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported("64-bit integers not supported".to_string()));
        }
        if requirements.contains(&"int16") && features.shader_int16 == vk::FALSE {
            return Err(TestError::NotSupported("16-bit integers not supported".to_string()));
        }
        if requirements.contains(&"float64") && features.shader_float64 == vk::FALSE {
            return Err(TestError::NotSupported(
                "Double-precision floats not supported".to_string(),
            ));
        }
        if requirements.contains(&"int8") || requirements.contains(&"float16") {
            let mut f16_i8_features = vk::PhysicalDeviceShaderFloat16Int8Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2 {
                next: (&raw mut f16_i8_features).cast(),
                ..Default::default()
            };
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };

            if requirements.contains(&"int8") && f16_i8_features.shader_int8 == vk::FALSE {
                return Err(TestError::NotSupported("8-bit integers not supported".to_string()));
            }
            if requirements.contains(&"float16") && f16_i8_features.shader_float16 == vk::FALSE {
                return Err(TestError::NotSupported("16-bit floats not supported".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.entry.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SpecConstantInstance {
            context,
            stage: self.stage(),
            entry: self.entry,
        })
    }
}

struct SpecConstantInstance<'a> {
    context: &'a Context<'a>,
    stage: vk::ShaderStageFlags,
    entry: &'static SpecConstantPrograms,
}

impl<'a> SpecConstantInstance<'a> {
    fn finish(&self, result_buffer: &BufferWithMemory<'a>) -> Result<TestStatus, TestError> {
        let device = self.context.get_device();
        let result_alloc = result_buffer.get_allocation();
        invalidate_alloc(device, result_alloc)?;

        let memory = unsafe { std::slice::from_raw_parts(result_alloc.get_host_ptr(), self.entry.ssbo_size as usize) };
        if verify_values(memory, &parse_expected(self.entry.expected)) {
            Ok(TestStatus::pass("Success"))
        } else {
            Ok(TestStatus::fail("Values did not match"))
        }
    }

    /// `ComputeTestInstance::iterate`
    fn iterate_compute(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let ssbo_size = vk::DeviceSize::from(self.entry.ssbo_size);

        // Descriptors
        let result_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_buffer_info = vk::DescriptorBufferInfo {
            buffer: result_buffer.get(),
            offset: 0,
            range: ssbo_size,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_buffer_info,
            )
            .update(device);

        // Specialization
        let (entries, data) =
            make_specialization(&parse_spec_constants(self.entry.spec_constants), self.entry.pack_data);
        let specialization_info = vk::SpecializationInfo::builder().map_entries(&entries).data(&data);

        // Pipeline
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("comp")?)?;
        let mut stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0");
        if !entries.is_empty() {
            stage = stage.specialization_info(&specialization_info);
        }
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_handle(vk::Pipeline::null())
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );

            device.cmd_dispatch(cmd, 1, 1, 1);

            let shader_write_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                result_buffer.get(),
                0,
                ssbo_size,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify results
        self.finish(&result_buffer)
    }

    /// `GraphicsTestInstance::iterate`
    fn iterate_graphics(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let ssbo_size = vk::DeviceSize::from(self.entry.ssbo_size);

        // Color attachment
        let render_size = (32u32, 32u32);
        let image_format = vk::Format::R8G8B8A8_UNORM;
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(image_format)
            .extent(vk::Extent3D {
                width: render_size.0,
                height: render_size.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            image_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // Vertex buffer
        let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [-1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Descriptors
        let result_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL_GRAPHICS)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_buffer_info = vk::DescriptorBufferInfo {
            buffer: result_buffer.get(),
            offset: 0,
            range: ssbo_size,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_buffer_info,
            )
            .update(device);

        // Specialization
        let (entries, data) =
            make_specialization(&parse_spec_constants(self.entry.spec_constants), self.entry.pack_data);

        // Pipeline
        let render_pass = make_render_pass(device, image_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_image_view],
            render_size.0,
            render_size.1,
            1,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let is_tessellation = self.stage == vk::ShaderStageFlags::TESSELLATION_CONTROL
            || self.stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION;

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        let mut stage_names = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
        let tesc_module;
        let tese_module;
        let geom_module;
        if is_tessellation {
            tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
            tese_module = create_shader_module(device, binaries.get("tese")?)?;
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"));
        }
        if self.stage == vk::ShaderStageFlags::GEOMETRY {
            geom_module = create_shader_module(device, binaries.get("geom")?)?;
            stages.push((vk::ShaderStageFlags::GEOMETRY, *geom_module));
            stage_names.push((vk::ShaderStageFlags::GEOMETRY, "geom"));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        stage_names.push((vk::ShaderStageFlags::FRAGMENT, "frag"));

        let topology = if is_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let mut state = DrawPipelineState::new(topology)
            .with_full_viewport(render_size.0, render_size.1)
            .with_position_input();
        state.rasterization.depth_bias_enable = vk::FALSE;
        if is_tessellation {
            state.patch_control_points = Some(3);
        }
        let shader_objects = make_shader_objects_stages_specialized(
            context,
            &stage_names,
            &[*descriptor_set_layout],
            &[],
            Some((entries.as_slice(), data.as_slice())),
        )?;
        state.specialization = Some((entries, data));
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?)
        };

        // Draw commands
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        }];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(render_size.0, render_size.1),
            &clear_values,
            &[(color_image.get(), *color_image_view)],
        );
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());
        unsafe {
            let shader_write_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                result_buffer.get(),
                0,
                ssbo_size,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify results
        self.finish(&result_buffer)
    }
}

impl TestInstance for SpecConstantInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.stage == vk::ShaderStageFlags::COMPUTE {
            self.iterate_compute()
        } else {
            self.iterate_graphics()
        }
    }
}

/// A node of the tree of groups, built from the case names.
enum Node {
    Group(String, Vec<Node>),
    Case(Box<dyn TestCase>),
}

fn insert_case(nodes: &mut Vec<Node>, path: &[&str], case: Box<dyn TestCase>) {
    match path.split_first() {
        None => nodes.push(Node::Case(case)),
        Some((group, rest)) => {
            let existing = nodes
                .iter()
                .position(|node| matches!(node, Node::Group(name, _) if name == group));
            let index = existing.unwrap_or_else(|| {
                nodes.push(Node::Group((*group).to_string(), Vec::new()));
                nodes.len() - 1
            });
            if let Node::Group(_, children) = &mut nodes[index] {
                insert_case(children, rest, case);
            }
        }
    }
}

fn build_group(name: &str, nodes: Vec<Node>) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for node in nodes {
        match node {
            Node::Group(child_name, children) => {
                group.add_child(build_group(&child_name, children));
            }
            Node::Case(case) => {
                group.add_child(case);
            }
        }
    }
    group
}

/// `createSpecConstantTests`
pub fn create_spec_constant_tests() -> TestCaseGroup {
    create_spec_constant_tests_for(true)
}

/// `createSpecConstantTests`; the compute stage, and with it the two cases written in SPIR-V assembly, is only built for monolithic pipelines.
pub fn create_spec_constant_tests_for(monolithic: bool) -> TestCaseGroup {
    let mut nodes = Vec::new();

    for &entry in ALL_SPEC_CONSTANT_PROGRAMS.iter() {
        if !monolithic && entry.stage == "compute" {
            continue;
        }
        let parts: Vec<&str> = entry.name.split("__").collect();
        let (leaf, path) = parts.split_last().expect("a case name has parts");
        insert_case(
            &mut nodes,
            path,
            Box::new(SpecConstantCase {
                name: (*leaf).to_string(),
                entry,
            }),
        );
    }

    if monolithic {
        insert_case(
            &mut nodes,
            &["compute", "unaligned_spec_constant"],
            Box::new(SpecConstantAsmCase::unaligned()),
        );
        insert_case(
            &mut nodes,
            &["compute", "same_id"],
            Box::new(SpecConstantAsmCase::same_id()),
        );
    }

    build_group("spec_constant", nodes)
}
