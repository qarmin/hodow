// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmConstantDataTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the cases is in `shaders/manifest/spirv_assembly_constant_data.toml` (written by
// `scripts/gen_spirv_assembly_constant_data_manifest.py`) and the `TestParams` of each ride along as its `spec`. The cases whose declared array is the 262128 byte
// maximum carry no shader and run as stubs. `runTest` is ported as it is: one storage buffer written by a compute shader or by the fragment shader of a
// full-screen triangle over a one pixel framebuffer with no attachments, with the item count and the data optionally specialized.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::spirv_assembly_constant_data::ALL_CONSTANT_DATA_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_memory_barrier, make_pipeline_layout};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one test case of the constant data groups.
#[derive(Clone, Copy)]
pub struct ConstantDataCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct Params {
    compute: bool,
    item_size_bytes: u32,
    item_count: u32,
    specialized_item_count: Option<u32>,
    specialize_data: bool,
    stub: bool,
}

impl Params {
    fn out_item_count(&self) -> u32 {
        self.specialized_item_count.unwrap_or(self.item_count)
    }
}

fn parse(spec: &str) -> Params {
    let field = |key: &str| -> &str { spec.split(';').find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('='))).unwrap_or_else(|| panic!("constant data spec without {key}")) };
    let number = |key: &str| -> i64 { field(key).parse().unwrap_or_else(|_| panic!("constant data spec with a bad {key}")) };
    Params {
        compute: field("stage") == "comp",
        item_size_bytes: number("size") as u32,
        item_count: number("count") as u32,
        specialized_item_count: u32::try_from(number("actual")).ok(),
        specialize_data: number("data") != 0,
        stub: number("stub") != 0,
    }
}

/// `getConstantDataValues`: the 26 letter pattern repeated to `len` bytes.
fn get_constant_data_values(len: usize, alt: bool) -> Vec<u8> {
    let base = if alt { "ABCDEFGHIJKLMNOPQRSTUVWXYZ" } else { "abcdefghijklmnopqrstuvwxyz" };
    base.bytes().cycle().take(len).collect()
}

struct ConstantDataTest {
    name: String,
    params: Params,
    programs: BinaryCollection,
}

impl TestCase for ConstantDataTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_shader_constant_data")?;

        if context.api_version() < (1, 2, 0) {
            return Err(TestError::NotSupported("Vulkan 1.2 required".to_string()));
        }

        let mut vulkan11 = vk::PhysicalDeviceVulkan11Features::default();
        let mut vulkan12 = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan11).push_next(&mut vulkan12);
        unsafe { context.get_instance().get_physical_device_features2(context.get_physical_device(), &mut features2) };

        let core = context.get_device_features();
        match self.params.item_size_bytes {
            1 => {
                if vulkan12.shader_int8 == vk::FALSE {
                    return Err(TestError::NotSupported("shaderInt8 not supported".to_string()));
                }
                if vulkan12.storage_buffer_8bit_access == vk::FALSE {
                    return Err(TestError::NotSupported("storageBuffer8BitAccess not supported".to_string()));
                }
            }
            2 => {
                if core.shader_int16 == vk::FALSE {
                    return Err(TestError::NotSupported("shaderInt16 not supported".to_string()));
                }
                if vulkan11.storage_buffer_16bit_access == vk::FALSE {
                    return Err(TestError::NotSupported("storageBuffer16BitAccess not supported".to_string()));
                }
            }
            8 => {
                if core.shader_int64 == vk::FALSE {
                    return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
                }
            }
            _ => {}
        }

        if !self.params.compute && core.fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported("fragmentStoresAndAtomics not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConstantDataInstance { context, params: self.params })
    }

    fn is_stub(&self) -> bool {
        self.params.stub
    }
}

struct ConstantDataInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for ConstantDataInstance<'_> {
    /// `runTest`
    fn iterate(&mut self) -> TestOutcome {
        let params = &self.params;
        if params.stub {
            return Err(TestError::NotPorted("the shader of this case holds 262128 bytes of constant data and is not generated".to_string()));
        }

        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let descriptor_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = if params.compute { vk::ShaderStageFlags::COMPUTE } else { vk::ShaderStageFlags::FRAGMENT };
        let out_item_count = params.out_item_count();
        let out_buffer_size = out_item_count as usize * params.item_size_bytes as usize;

        let out_buffer = BufferWithMemory::new(device, allocator, make_buffer_create_info(out_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER), MemoryRequirement::HOST_VISIBLE)?;
        unsafe { std::ptr::write_bytes(out_buffer.get_allocation().get_host_ptr(), 0, out_buffer_size) };
        flush_alloc(device, out_buffer.get_allocation())?;

        let set_layout = DescriptorSetLayoutBuilder::new().add_single_binding(descriptor_type, stage_flags).build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let out_buffer_info = make_descriptor_buffer_info(out_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new().write_single(descriptor_set.get(), Location::binding(0), descriptor_type, &out_buffer_info).update(device);

        let binaries = context.get_binary_collection();

        let mut spec_map_entries = Vec::new();
        let mut spec_data: Vec<u8> = Vec::new();
        if let Some(count) = params.specialized_item_count {
            spec_data.extend_from_slice(&count.to_ne_bytes());
            spec_map_entries.push(vk::SpecializationMapEntry { constant_id: 0, offset: 0, size: std::mem::size_of::<u32>() });
        }

        let data_bytes = get_constant_data_values(out_buffer_size, false);
        if params.specialize_data {
            let previous_size = spec_data.len();
            spec_data.extend_from_slice(&data_bytes);
            spec_map_entries.push(vk::SpecializationMapEntry { constant_id: 1, offset: previous_size as u32, size: data_bytes.len() });
        }

        let specialization_info = vk::SpecializationInfo::builder().map_entries(&spec_map_entries).data(&spec_data);
        let specialization = if spec_data.is_empty() { std::ptr::null() } else { std::ptr::from_ref::<vk::SpecializationInfo>(&specialization_info) };

        let extent = vk::Extent3D { width: 1, height: 1, depth: 1 };
        let scissor = make_rect_2d(0, 0, extent.width, extent.height);
        let entry = c"main";

        let pipeline;
        let _render_pass;
        let _framebuffer;
        let mut render_pass_handle = vk::RenderPass::null();
        let mut framebuffer_handle = vk::Framebuffer::null();
        if params.compute {
            let module = create_shader_module(device, binaries.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo {
                s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::PipelineShaderStageCreateFlags::empty(),
                stage: vk::ShaderStageFlags::COMPUTE,
                module: *module,
                name: entry.as_ptr(),
                specialization_info: specialization,
            };
            let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(*pipeline_layout).base_pipeline_index(-1).build();
            pipeline = Unique::new(device, unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }.vk_check("vkCreateComputePipelines")?.0[0]);
            _render_pass = None;
            _framebuffer = None;
        } else {
            let subpass = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
            let subpasses = [subpass];
            let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
            let render_pass = Unique::new(device, unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?);
            let framebuffer_info = vk::FramebufferCreateInfo::builder().render_pass(*render_pass).width(extent.width).height(extent.height).layers(extent.depth);
            let framebuffer = Unique::new(device, unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?);
            render_pass_handle = *render_pass;
            framebuffer_handle = *framebuffer;

            let vert_module = create_shader_module(device, binaries.get("vert")?)?;
            let frag_module = create_shader_module(device, binaries.get("frag")?)?;
            let stages = [
                vk::PipelineShaderStageCreateInfo::builder().stage(vk::ShaderStageFlags::VERTEX).module(*vert_module).name(entry.to_bytes_with_nul()).build(),
                vk::PipelineShaderStageCreateInfo {
                    s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
                    next: std::ptr::null(),
                    flags: vk::PipelineShaderStageCreateFlags::empty(),
                    stage: vk::ShaderStageFlags::FRAGMENT,
                    module: *frag_module,
                    name: entry.as_ptr(),
                    specialization_info: specialization,
                },
            ];
            let viewports = [vk::Viewport { x: 0.0, y: 0.0, width: extent.width as f32, height: extent.height as f32, min_depth: 0.0, max_depth: 1.0 }];
            let scissors = [scissor];
            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);
            let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder().polygon_mode(vk::PolygonMode::FILL).cull_mode(vk::CullModeFlags::NONE).front_face(vk::FrontFace::COUNTER_CLOCKWISE).line_width(1.0);
            let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
            let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder();
            let info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&stages)
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .multisample_state(&multisample_state)
                .color_blend_state(&color_blend_state)
                .layout(*pipeline_layout)
                .render_pass(render_pass_handle)
                .subpass(0);
            pipeline = Unique::new(device, unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?.0[0]);
            _render_pass = Some(render_pass);
            _framebuffer = Some(framebuffer);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let bind_point = if params.compute { vk::PipelineBindPoint::COMPUTE } else { vk::PipelineBindPoint::GRAPHICS };

        begin_command_buffer(device, cmd)?;
        unsafe {
            if !params.compute {
                let begin_info = vk::RenderPassBeginInfo::builder().render_pass(render_pass_handle).framebuffer(framebuffer_handle).render_area(scissor);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            }
            device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &[descriptor_set.get()], &[] as &[u32]);
            device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
            if params.compute {
                device.cmd_dispatch(cmd, 1, 1, 1);
            } else {
                device.cmd_draw(cmd, 3, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }
            let src_stage = if params.compute { vk::PipelineStageFlags::COMPUTE_SHADER } else { vk::PipelineStageFlags::FRAGMENT_SHADER };
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd,
                src_stage,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, out_buffer.get_allocation())?;
        let out_bytes = unsafe { std::slice::from_raw_parts(out_buffer.get_allocation().get_host_ptr().cast_const(), out_buffer_size) };

        let item_size = params.item_size_bytes as usize;
        let mismatch = data_bytes.chunks(item_size).zip(out_bytes.chunks(item_size)).position(|(expected, found)| expected != found);
        if let Some(item) = mismatch {
            return Ok(TestStatus::fail(format!("Unexpected values in output buffer: item {item} out of {out_item_count} differs")));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn make_case(case: &ConstantDataCase, leaf: &str) -> Box<dyn TestCase> {
    Box::new(ConstantDataTest { name: leaf.to_string(), params: parse(case.spec), programs: case.programs })
}

/// `createConstantDataTests`, as the groups of each case path below `spirv_assembly` and the case.
pub fn create_constant_data_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_CONSTANT_DATA_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}
