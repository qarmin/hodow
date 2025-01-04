// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineExecutablePropertiesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2019 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only, and the recorded data goes nowhere (the port has no
// per-case log). The three queries are called through the raw entry points: vulkanalia's wrappers hand the driver uninitialised
// structs, and these tests are about what a driver does with the ones it is given.

use std::ffi::c_char;

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_executable_properties::{
    EXECUTABLE_PROPERTIES_COMPUTE, EXECUTABLE_PROPERTIES_VERT_FRAG, EXECUTABLE_PROPERTIES_VERT_GEOM_FRAG,
    EXECUTABLE_PROPERTIES_VERT_TESS_FRAG,
};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const PIPELINE_CACHE_NDX_INITIAL: usize = 0;
const PIPELINE_CACHE_NDX_CACHED: usize = 1;
const PIPELINE_CACHE_NDX_COUNT: usize = 2;

/// `getShaderFlagStr(shader, false)`
fn get_shader_flag_str(shader: vk::ShaderStageFlags) -> String {
    let mut name = String::new();
    if shader.contains(vk::ShaderStageFlags::COMPUTE) {
        name += "compute_stage";
    } else {
        name += "vertex_stage";
        if shader.contains(vk::ShaderStageFlags::GEOMETRY) {
            name += "_geometry_stage";
        }
        if shader.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
            name += "_tessellation_control_stage";
        }
        if shader.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
            name += "_tessellation_evaluation_stage";
        }
        name += "_fragment_stage";
    }
    name
}

#[derive(Clone, Copy)]
struct ExecutablePropertiesTestParam {
    shaders: vk::ShaderStageFlags,
    test_statistics: bool,
    test_internal_representations: bool,
}

impl ExecutablePropertiesTestParam {
    fn generate_test_name(&self) -> String {
        let mut result = get_shader_flag_str(self.shaders);

        if self.test_statistics {
            result += "_statistics";
        }
        if self.test_internal_representations {
            result += "_internal_representations";
        }

        result
    }
}

/// `checkString`: non-empty and null terminated.
fn check_string(string: &[c_char]) -> bool {
    let i = string.iter().position(|&c| c == 0).unwrap_or(string.len());

    // The string needs to be non-empty and null terminated
    !(i == 0 || i >= string.len())
}

fn check_result(result: vk::Result, what: &str) -> Result<(), TestError> {
    if result == vk::Result::SUCCESS {
        Ok(())
    } else {
        Err(TestError::Fail(format!("{what} returned {result:?}")))
    }
}

fn get_executable_properties(
    device: &Device,
    pipeline: vk::Pipeline,
) -> Result<Vec<vk::PipelineExecutablePropertiesKHR>, TestError> {
    let pipeline_info = vk::PipelineInfoKHR {
        s_type: vk::StructureType::PIPELINE_INFO_KHR,
        next: std::ptr::null(),
        pipeline,
    };
    let mut executable_count = 0u32;
    let entry_point = device.commands().get_pipeline_executable_properties_khr;
    check_result(
        unsafe {
            entry_point(
                device.handle(),
                &pipeline_info,
                &mut executable_count,
                std::ptr::null_mut(),
            )
        },
        "vkGetPipelineExecutablePropertiesKHR",
    )?;

    if executable_count == 0 {
        return Ok(Vec::new());
    }

    let mut props: Vec<vk::PipelineExecutablePropertiesKHR> = (0..executable_count)
        .map(|_| vk::PipelineExecutablePropertiesKHR::default())
        .collect();
    check_result(
        unsafe {
            entry_point(
                device.handle(),
                &pipeline_info,
                &mut executable_count,
                props.as_mut_ptr(),
            )
        },
        "vkGetPipelineExecutablePropertiesKHR",
    )?;
    props.truncate(executable_count as usize);
    Ok(props)
}

fn get_executable_statistics(
    device: &Device,
    pipeline: vk::Pipeline,
    executable_index: u32,
) -> Result<Vec<vk::PipelineExecutableStatisticKHR>, TestError> {
    let info = vk::PipelineExecutableInfoKHR {
        s_type: vk::StructureType::PIPELINE_EXECUTABLE_INFO_KHR,
        next: std::ptr::null(),
        pipeline,
        executable_index,
    };
    let mut statistic_count = 0u32;
    let entry_point = device.commands().get_pipeline_executable_statistics_khr;
    check_result(
        unsafe { entry_point(device.handle(), &info, &mut statistic_count, std::ptr::null_mut()) },
        "vkGetPipelineExecutableStatisticsKHR",
    )?;

    if statistic_count == 0 {
        return Ok(Vec::new());
    }

    let mut statistics: Vec<vk::PipelineExecutableStatisticKHR> = (0..statistic_count)
        .map(|_| vk::PipelineExecutableStatisticKHR::default())
        .collect();
    check_result(
        unsafe { entry_point(device.handle(), &info, &mut statistic_count, statistics.as_mut_ptr()) },
        "vkGetPipelineExecutableStatisticsKHR",
    )?;
    statistics.truncate(statistic_count as usize);
    Ok(statistics)
}

struct ExecutablePropertiesInstance<'a> {
    context: &'a Context<'a>,
    param: ExecutablePropertiesTestParam,
}

impl ExecutablePropertiesInstance<'_> {
    /// `ExecutablePropertiesTestInstance::verifyStatistics`
    fn verify_statistics(
        &self,
        pipelines: &[vk::Pipeline; PIPELINE_CACHE_NDX_COUNT],
        executable_ndx: u32,
    ) -> TestOutcome {
        let device = self.context.get_device();

        let mut statistics: [Vec<vk::PipelineExecutableStatisticKHR>; PIPELINE_CACHE_NDX_COUNT] =
            [Vec::new(), Vec::new()];

        for ndx in 0..PIPELINE_CACHE_NDX_COUNT {
            statistics[ndx] = get_executable_statistics(device, pipelines[ndx], executable_ndx)?;

            for stat_ndx in 0..statistics[ndx].len() {
                let stat = &statistics[ndx][stat_ndx];
                if !check_string(stat.name.as_array()) {
                    return Ok(TestStatus::fail("Invalid statistic name string"));
                }

                for other_ndx in 0..stat_ndx {
                    if stat.name.as_array() == statistics[ndx][other_ndx].name.as_array() {
                        return Ok(TestStatus::fail(
                            "Statistic name string not unique within the executable",
                        ));
                    }
                }

                if !check_string(stat.description.as_array()) {
                    return Ok(TestStatus::fail("Invalid statistic description string"));
                }

                if stat.format == vk::PipelineExecutableStatisticFormatKHR::BOOL32 {
                    let b32 = unsafe { stat.value.b32 };
                    if b32 != vk::TRUE && b32 != vk::FALSE {
                        return Ok(TestStatus::fail("Boolean statistic is neither VK_TRUE nor VK_FALSE"));
                    }
                }
            }
        }

        if statistics[0].len() != statistics[1].len() {
            return Ok(TestStatus::fail(
                "Identical pipelines have different numbers of statistics",
            ));
        }

        if statistics[0].is_empty() {
            return Ok(TestStatus::pass("No statistics reported"));
        }

        // Both compiles had better have specified the same infos
        for stat0 in &statistics[0] {
            let Some(stat1) = statistics[1]
                .iter()
                .find(|stat1| stat0.name.as_array() == stat1.name.as_array())
            else {
                return Ok(TestStatus::fail("Identical pipelines have different statistics"));
            };

            if stat0.description.as_array() != stat1.description.as_array() {
                return Ok(TestStatus::fail("Invalid binary description string"));
            }

            if stat0.format != stat1.format {
                return Ok(TestStatus::fail(
                    "Identical pipelines have statistics with different formats",
                ));
            }

            // Statistics differing between two compilations is not a failure, so only the format is validated here.
            match stat0.format {
                vk::PipelineExecutableStatisticFormatKHR::BOOL32
                | vk::PipelineExecutableStatisticFormatKHR::INT64
                | vk::PipelineExecutableStatisticFormatKHR::UINT64
                | vk::PipelineExecutableStatisticFormatKHR::FLOAT64 => {}
                _ => return Ok(TestStatus::fail("Invalid statistic format")),
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `ExecutablePropertiesTestInstance::verifyInternalRepresentations`
    fn verify_internal_representations(
        &self,
        pipelines: &[vk::Pipeline; PIPELINE_CACHE_NDX_COUNT],
        executable_ndx: u32,
    ) -> TestOutcome {
        let device = self.context.get_device();

        // We only care about internal representations on the second pipeline.
        // We still compile twice to ensure that we still get the right thing
        // even if the pipeline is hot in the cache.
        let info = vk::PipelineExecutableInfoKHR {
            s_type: vk::StructureType::PIPELINE_EXECUTABLE_INFO_KHR,
            next: std::ptr::null(),
            pipeline: pipelines[PIPELINE_CACHE_NDX_CACHED],
            executable_index: executable_ndx,
        };
        let entry_point = device.commands().get_pipeline_executable_internal_representations_khr;

        let mut ir_count = 0u32;
        check_result(
            unsafe { entry_point(device.handle(), &info, &mut ir_count, std::ptr::null_mut()) },
            "vkGetPipelineExecutableInternalRepresentationsKHR",
        )?;

        if ir_count == 0 {
            return Ok(TestStatus::pass("No internal representations reported"));
        }

        let mut irs: Vec<vk::PipelineExecutableInternalRepresentationKHR> = (0..ir_count)
            .map(|_| vk::PipelineExecutableInternalRepresentationKHR::default())
            .collect();
        let mut ir_datas: Vec<Vec<u8>> = (0..ir_count).map(|_| Vec::new()).collect();
        check_result(
            unsafe { entry_point(device.handle(), &info, &mut ir_count, irs.as_mut_ptr()) },
            "vkGetPipelineExecutableInternalRepresentationsKHR",
        )?;

        for ir_ndx in 0..ir_count as usize {
            if !check_string(irs[ir_ndx].name.as_array()) {
                return Ok(TestStatus::fail("Invalid internal representation name string"));
            }

            for other_ndx in 0..ir_ndx {
                if irs[ir_ndx].name.as_array() == irs[other_ndx].name.as_array() {
                    return Ok(TestStatus::fail(
                        "Internal representation name string not unique within the executable",
                    ));
                }
            }

            if !check_string(irs[ir_ndx].description.as_array()) {
                return Ok(TestStatus::fail("Invalid binary description string"));
            }

            if irs[ir_ndx].data_size == 0 {
                return Ok(TestStatus::fail("Internal representation has no data"));
            }

            ir_datas[ir_ndx] = vec![0u8; irs[ir_ndx].data_size];
            irs[ir_ndx].data = ir_datas[ir_ndx].as_mut_ptr().cast();
            if irs[ir_ndx].is_text != vk::FALSE {
                // For binary data the size is important.  We check that the
                // implementation fills the whole buffer by filling it with
                // garbage first and then looking for that same garbage later.
                for (i, byte) in ir_datas[ir_ndx].iter_mut().enumerate() {
                    *byte = (37usize.wrapping_mul(17 + i)) as u8;
                }
            }
        }

        check_result(
            unsafe { entry_point(device.handle(), &info, &mut ir_count, irs.as_mut_ptr()) },
            "vkGetPipelineExecutableInternalRepresentationsKHR",
        )?;

        for ir_ndx in 0..ir_count as usize {
            let data = &ir_datas[ir_ndx];
            if irs[ir_ndx].is_text != vk::FALSE {
                let as_chars: Vec<c_char> = data.iter().map(|&b| b as c_char).collect();
                if !check_string(&as_chars) {
                    return Ok(TestStatus::fail("Textual internal representation isn't a valid string"));
                }
            } else {
                let mut matching_chunk_size = 0usize;
                for (i, &byte) in data.iter().enumerate() {
                    if byte == (37usize.wrapping_mul(17 + i)) as u8 {
                        matching_chunk_size += 1;
                    } else {
                        matching_chunk_size = 0;
                    }
                }

                // 64 bytes of our random data still being in the buffer probably
                // isn't a coincidence
                if matching_chunk_size == irs[ir_ndx].data_size || matching_chunk_size >= 64 {
                    return Ok(TestStatus::fail(
                        "Implementation didn't fill the whole internal representation data buffer",
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `ExecutablePropertiesTestInstance::verifyTestResult`
    fn verify_test_result(&self, pipelines: &[vk::Pipeline; PIPELINE_CACHE_NDX_COUNT]) -> TestOutcome {
        let device = self.context.get_device();

        let mut props: [Vec<vk::PipelineExecutablePropertiesKHR>; PIPELINE_CACHE_NDX_COUNT] = [Vec::new(), Vec::new()];

        for ndx in 0..PIPELINE_CACHE_NDX_COUNT {
            props[ndx] = get_executable_properties(device, pipelines[ndx])?;

            for exec_ndx in 0..props[ndx].len() {
                let exec = &props[ndx][exec_ndx];
                if !check_string(exec.name.as_array()) {
                    return Ok(TestStatus::fail("Invalid binary name string"));
                }

                for other_ndx in 0..exec_ndx {
                    if exec.name.as_array() == props[ndx][other_ndx].name.as_array() {
                        return Ok(TestStatus::fail("Binary name string not unique within the pipeline"));
                    }
                }

                if !check_string(exec.description.as_array()) {
                    return Ok(TestStatus::fail("Invalid binary description string"));
                }

                // Check that the binary only contains stages actually used to
                // compile the pipeline
                if !(exec.stages & !self.param.shaders).is_empty() {
                    return Ok(TestStatus::fail("Binary uses unprovided stage"));
                }
            }
        }

        if props[0].len() != props[1].len() {
            return Ok(TestStatus::fail("Identical pipelines have different numbers of props"));
        }

        if props[0].is_empty() {
            return Ok(TestStatus::pass("No executables reported"));
        }

        // Both compiles had better have specified the same infos
        for exec0 in &props[0] {
            let Some(exec1) = props[1]
                .iter()
                .find(|exec1| exec0.name.as_array() == exec1.name.as_array())
            else {
                return Ok(TestStatus::fail(
                    "Identical pipelines have different sets of executables",
                ));
            };

            if exec0.description.as_array() != exec1.description.as_array() {
                return Ok(TestStatus::fail("Same binary has different descriptions"));
            }

            if exec0.stages != exec1.stages {
                return Ok(TestStatus::fail("Same binary has different stages"));
            }

            if exec0.subgroup_size != exec1.subgroup_size {
                return Ok(TestStatus::fail("Same binary has different subgroup sizes"));
            }
        }

        let mut status = TestStatus::pass("Pass");
        for exec_ndx in 0..props[0].len() as u32 {
            if self.param.test_statistics {
                status = self.verify_statistics(pipelines, exec_ndx)?;
                if status.code() != TestResult::Pass {
                    break;
                }
            }

            if self.param.test_internal_representations {
                status = self.verify_internal_representations(pipelines, exec_ndx)?;
                if status.code() != TestResult::Pass {
                    break;
                }
            }
        }

        Ok(status)
    }

    /// `GraphicsExecutablePropertiesTestInstance`'s constructor and `preparePipelineWrapper`, monolithic.
    fn build_graphics_pipelines<'b>(
        &'b self,
        cache: vk::PipelineCache,
    ) -> Result<(Vec<Unique<'b, vk::Pipeline>>, Unique<'b, vk::RenderPass>), TestError> {
        let device = self.context.get_device();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let depth_format = vk::Format::D16_UNORM;

        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&vk::PipelineLayoutCreateInfo::builder(), None) }
                .vk_check("vkCreatePipelineLayout")?,
        );

        // `makeRenderPass(vk, device, colorFormat, depthFormat)`: one colour and one depth attachment.
        let color_attachment = vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build();
        let depth_attachment = vk::AttachmentDescription::builder()
            .format(depth_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let attachments = [color_attachment, depth_attachment];
        let color_refs = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_ref = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)
            .depth_stencil_attachment(&depth_ref)
            .build();
        let subpasses = [subpass];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let binaries = self.context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("color_frag")?)?;
        let shader_flags = self.param.shaders;
        let has_tess = shader_flags.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL);
        let tesc_module = if has_tess {
            Some(create_shader_module(device, binaries.get("basic_tcs")?)?)
        } else {
            None
        };
        let tese_module = if shader_flags.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
            Some(create_shader_module(device, binaries.get("basic_tes")?)?)
        } else {
            None
        };
        let geom_module = if shader_flags.contains(vk::ShaderStageFlags::GEOMETRY) {
            Some(create_shader_module(device, binaries.get("dummy_geo")?)?)
        } else {
            None
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let Some(module) = &tesc_module {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **module));
        }
        if let Some(module) = &tese_module {
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **module));
        }
        if let Some(module) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **module));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

        let mut pipelines = Vec::new();
        for ndx in 0..PIPELINE_CACHE_NDX_COUNT {
            let mut flags = vk::PipelineCreateFlags::empty();
            if self.param.test_statistics {
                flags |= vk::PipelineCreateFlags::CAPTURE_STATISTICS_KHR;
            }
            // Only check gather internal representations on the second pipeline.
            // This way, it's more obvious if they failed to capture due to the pipeline being cached.
            if ndx == PIPELINE_CACHE_NDX_CACHED && self.param.test_internal_representations {
                flags |= vk::PipelineCreateFlags::CAPTURE_INTERNAL_REPRESENTATIONS_KHR;
            }

            let mut state = DrawPipelineState::new(if has_tess {
                vk::PrimitiveTopology::PATCH_LIST
            } else {
                vk::PrimitiveTopology::TRIANGLE_LIST
            })
            .with_full_viewport(32, 32);
            // `Vertex4RGBA`: a position and a colour, both vec4.
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 32,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![
                vk::VertexInputAttributeDescription {
                    location: 0,
                    binding: 0,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 0,
                },
                vk::VertexInputAttributeDescription {
                    location: 1,
                    binding: 0,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 16,
                },
            ];
            state.color_blend_attachment = Some(vk::PipelineColorBlendAttachmentState {
                blend_enable: vk::FALSE,
                src_color_blend_factor: vk::BlendFactor::ONE,
                dst_color_blend_factor: vk::BlendFactor::ZERO,
                color_blend_op: vk::BlendOp::ADD,
                src_alpha_blend_factor: vk::BlendFactor::ONE,
                dst_alpha_blend_factor: vk::BlendFactor::ZERO,
                alpha_blend_op: vk::BlendOp::ADD,
                color_write_mask: vk::ColorComponentFlags::R
                    | vk::ColorComponentFlags::G
                    | vk::ColorComponentFlags::B
                    | vk::ColorComponentFlags::A,
            });
            let keep_never = vk::StencilOpState {
                fail_op: vk::StencilOp::KEEP,
                pass_op: vk::StencilOp::KEEP,
                depth_fail_op: vk::StencilOp::KEEP,
                compare_op: vk::CompareOp::NEVER,
                compare_mask: 0,
                write_mask: 0,
                reference: 0,
            };
            state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
                .depth_test_enable(true)
                .depth_write_enable(true)
                .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
                .depth_bounds_test_enable(false)
                .stencil_test_enable(false)
                .front(keep_never)
                .back(keep_never)
                .min_depth_bounds(0.0)
                .max_depth_bounds(1.0)
                .build();
            if has_tess {
                state.patch_control_points = Some(3);
            }
            state.pipeline_cache = cache;
            state.create_flags = flags;

            pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?);
        }

        Ok((pipelines, render_pass))
    }
}

struct GraphicsExecutablePropertiesInstance<'a>(ExecutablePropertiesInstance<'a>);

impl TestInstance for GraphicsExecutablePropertiesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let device = self.0.context.get_device();
        let cache = Unique::new(
            device,
            unsafe { device.create_pipeline_cache(&vk::PipelineCacheCreateInfo::builder(), None) }
                .vk_check("vkCreatePipelineCache")?,
        );
        let (pipelines, _render_pass) = self.0.build_graphics_pipelines(*cache)?;
        let handles = [
            *pipelines[PIPELINE_CACHE_NDX_INITIAL],
            *pipelines[PIPELINE_CACHE_NDX_CACHED],
        ];
        self.0.verify_test_result(&handles)
    }
}

struct ComputeExecutablePropertiesInstance<'a>(ExecutablePropertiesInstance<'a>);

impl TestInstance for ComputeExecutablePropertiesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.0.context;
        let param = self.0.param;
        let device = context.get_device();
        let cache = Unique::new(
            device,
            unsafe { device.create_pipeline_cache(&vk::PipelineCacheCreateInfo::builder(), None) }
                .vk_check("vkCreatePipelineCache")?,
        );

        let mut descriptor_set_layouts = Vec::new();
        let mut shader_modules = Vec::new();
        let mut pipeline_layouts = Vec::new();
        let mut pipelines = Vec::new();

        for ndx in 0..PIPELINE_CACHE_NDX_COUNT {
            // buildDescriptorSets
            let mut layout_builder = DescriptorSetLayoutBuilder::new();
            for _binding_ndx in 0..2 {
                layout_builder = layout_builder
                    .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE);
            }
            descriptor_set_layouts.push(layout_builder.build(device)?);

            // buildShader
            shader_modules.push(create_shader_module(
                device,
                context.get_binary_collection().get("basic_compute")?,
            )?);

            // buildPipeline
            let set_layouts = [*descriptor_set_layouts[ndx]];
            let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
            pipeline_layouts.push(Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
            ));

            let stage_create_info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*shader_modules[ndx])
                .name(b"main\0")
                .build();

            let mut flags = vk::PipelineCreateFlags::empty();
            if param.test_statistics {
                flags |= vk::PipelineCreateFlags::CAPTURE_STATISTICS_KHR;
            }

            // Only check gather internal representations on the second
            // pipeline.  This way, it's more obvious if they failed to capture
            // due to the pipeline being cached.
            if ndx == PIPELINE_CACHE_NDX_CACHED && param.test_internal_representations {
                flags |= vk::PipelineCreateFlags::CAPTURE_INTERNAL_REPRESENTATIONS_KHR;
            }

            let pipeline_create_info = vk::ComputePipelineCreateInfo::builder()
                .flags(flags)
                .stage(stage_create_info)
                .layout(*pipeline_layouts[ndx])
                .base_pipeline_index(0)
                .build();
            let created = unsafe { device.create_compute_pipelines(*cache, &[pipeline_create_info], None) }
                .vk_check("vkCreateComputePipelines")?;
            pipelines.push(Unique::new(device, created.0[0]));
        }

        let handles = [
            *pipelines[PIPELINE_CACHE_NDX_INITIAL],
            *pipelines[PIPELINE_CACHE_NDX_CACHED],
        ];
        self.0.verify_test_result(&handles)
    }
}

struct ExecutablePropertiesTest {
    name: String,
    param: ExecutablePropertiesTestParam,
}

impl TestCase for ExecutablePropertiesTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_pipeline_executable_properties")?;

        let shader_flags = self.param.shaders;
        if shader_flags.contains(vk::ShaderStageFlags::COMPUTE) {
            return Ok(());
        }

        let features = context.get_device_features();
        if shader_flags.contains(vk::ShaderStageFlags::GEOMETRY) && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry Shader Not Supported".to_string()));
        }
        if (shader_flags.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL)
            || shader_flags.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION))
            && features.tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported("Tessellation Not Supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let shader_flags = self.param.shaders;
        if shader_flags.contains(vk::ShaderStageFlags::COMPUTE) {
            EXECUTABLE_PROPERTIES_COMPUTE.programs
        } else if shader_flags.contains(vk::ShaderStageFlags::GEOMETRY) {
            EXECUTABLE_PROPERTIES_VERT_GEOM_FRAG.programs
        } else if shader_flags.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
            EXECUTABLE_PROPERTIES_VERT_TESS_FRAG.programs
        } else {
            EXECUTABLE_PROPERTIES_VERT_FRAG.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let instance = ExecutablePropertiesInstance {
            context,
            param: self.param,
        };
        if self.param.shaders.contains(vk::ShaderStageFlags::COMPUTE) {
            Box::new(ComputeExecutablePropertiesInstance(instance))
        } else {
            Box::new(GraphicsExecutablePropertiesInstance(instance))
        }
    }
}

fn new_test_case(param: ExecutablePropertiesTestParam) -> Box<dyn TestCase> {
    Box::new(ExecutablePropertiesTest {
        name: param.generate_test_name(),
        param,
    })
}

/// `createExecutablePropertiesTests`, for monolithic pipelines.
pub fn create_executable_properties_tests() -> TestCaseGroup {
    let mut binary_info_tests = TestCaseGroup::new("executable_properties");

    // Graphics Pipeline Tests
    {
        let mut graphics_tests = TestCaseGroup::new("graphics");

        let vert_frag_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let vert_geom_frag_stages = vert_frag_stages | vk::ShaderStageFlags::GEOMETRY;
        let vert_tess_frag_stages = vert_frag_stages
            | vk::ShaderStageFlags::TESSELLATION_CONTROL
            | vk::ShaderStageFlags::TESSELLATION_EVALUATION;

        for (test_statistics, test_internal_representations) in
            [(false, false), (true, false), (false, true), (true, true)]
        {
            for shaders in [vert_frag_stages, vert_geom_frag_stages, vert_tess_frag_stages] {
                graphics_tests.add_child(new_test_case(ExecutablePropertiesTestParam {
                    shaders,
                    test_statistics,
                    test_internal_representations,
                }));
            }
        }

        binary_info_tests.add_child(graphics_tests);
    }

    // Compute Pipeline Tests - don't repeat those tests for graphics pipeline library
    {
        let mut compute_tests = TestCaseGroup::new("compute");

        for (test_statistics, test_internal_representations) in
            [(false, false), (true, false), (false, true), (true, true)]
        {
            compute_tests.add_child(new_test_case(ExecutablePropertiesTestParam {
                shaders: vk::ShaderStageFlags::COMPUTE,
                test_statistics,
                test_internal_representations,
            }));
        }

        binary_info_tests.add_child(compute_tests);
    }

    binary_info_tests
}
