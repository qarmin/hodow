// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineCreationCacheControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The templated validator functions become the `Validator` enum, and the
// `graphics_tests` / `compute_tests` namespaces one `Kind`. Pipeline creation goes through the raw entry points: the wrappers
// drop the pipeline array on VK_ERROR_PIPELINE_COMPILE_REQUIRED, which is exactly the result these tests look at.

use std::time::{Duration, Instant};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_creation_cache_control::{CACHE_CONTROL_COMPUTE, CACHE_CONTROL_GRAPHICS};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum CacheType {
    NoCache,
    ExplicitCache,
    DerivativeHandle,
    DerivativeIndex,
}

/// `ElapsedTime`, in microseconds.
#[derive(Clone, Copy)]
enum TimeLimit {
    Immediate = 500,
    Fast = 1000,
}

/// `Validator`, one variant per template of the C++ with its template arguments.
#[derive(Clone, Copy)]
enum Validator {
    /// `checkResult<VK_RESULT, FAIL_RESULT>`
    CheckResult(vk::Result, TestResult),
    /// `checkPipelineMustBeValid<INDEX, FAIL_RESULT>`
    PipelineMustBeValid(usize, TestResult),
    /// `checkPipelineMustBeNull<INDEX, FAIL_RESULT>`
    PipelineMustBeNull(usize, TestResult),
    /// `checkPipelineNullAfterIndex<INDEX, FAIL_RESULT>`
    PipelineNullAfterIndex(usize, TestResult),
    /// `checkElapsedTime<MAX_TIME, FAIL_RESULT>`
    ElapsedTime(TimeLimit, TestResult),
}

impl Validator {
    /// Returns the failing verdict and its reason, or `None` for a pass.
    fn validate(
        &self,
        result: vk::Result,
        pipelines: &[vk::Pipeline],
        elapsed: Duration,
    ) -> Result<Option<(TestResult, String)>, TestError> {
        match *self {
            Self::CheckResult(expected, fail_result) => {
                if expected != result {
                    return Ok(Some((fail_result, format!("Got {result:?}, Expected {expected:?}"))));
                }
            }
            Self::PipelineMustBeValid(index, fail_result) => {
                if pipelines.len() <= index {
                    return Err(TestError::Fail(format!(
                        "Index {index} is not in created pipelines (pipelines.size(): {})",
                        pipelines.len()
                    )));
                }

                if pipelines[index] == vk::Pipeline::null() {
                    return Ok(Some((
                        fail_result,
                        format!("pipelines[{index}] is not a valid VkPipeline object"),
                    )));
                }
            }
            Self::PipelineMustBeNull(index, fail_result) => {
                if pipelines.len() <= index {
                    return Err(TestError::Fail(format!(
                        "Index {index} is not in created pipelines (pipelines.size(): {})",
                        pipelines.len()
                    )));
                }

                if pipelines[index] != vk::Pipeline::null() {
                    return Ok(Some((fail_result, format!("pipelines[{index}] is not VK_NULL_HANDLE"))));
                }
            }
            Self::PipelineNullAfterIndex(index, fail_result) => {
                if pipelines.len() <= index {
                    return Err(TestError::Fail(format!(
                        "Index {index} is not in created pipelines (pipelines.size(): {})",
                        pipelines.len()
                    )));
                }

                if pipelines.len() - 1 == index {
                    return Err(TestError::Fail(format!(
                        "Index {index} is the last pipeline, likely a malformed test case"
                    )));
                }

                // Only have to iterate through if the requested index is null
                if pipelines[index] == vk::Pipeline::null() {
                    for (i, pipeline) in pipelines.iter().enumerate().skip(index + 1) {
                        if *pipeline != vk::Pipeline::null() {
                            return Ok(Some((
                                fail_result,
                                format!("pipelines[{i}] is not VK_NULL_HANDLE after a explicit early return index"),
                            )));
                        }
                    }
                }
            }
            Self::ElapsedTime(max_time, fail_result) => {
                // In debug mode timing is not likely to be accurate
                if cfg!(debug_assertions) {
                    return Ok(None);
                }

                let allowed_time = Duration::from_micros(max_time as u64);
                if elapsed > allowed_time {
                    return Ok(Some((
                        fail_result,
                        format!(
                            "pipeline creation took longer than {}us (actual time: {}us)",
                            allowed_time.as_micros(),
                            elapsed.as_micros()
                        ),
                    )));
                }
            }
        }

        Ok(None)
    }
}

/// `validateResults`
fn validate_results(
    result: vk::Result,
    pipelines: &[vk::Pipeline],
    elapsed: Duration,
    validators: &[Validator],
) -> TestOutcome {
    if result != vk::Result::SUCCESS && result != vk::Result::PIPELINE_COMPILE_REQUIRED {
        return Err(TestError::InternalError(format!(
            "Pipeline creation returned an error result: {result:?}"
        )));
    }

    for validator in validators {
        if let Some((code, reason)) = validator.validate(result, pipelines, elapsed)? {
            return Ok(TestStatus::new(code, reason));
        }
    }

    Ok(TestStatus::pass("Test passed."))
}

fn compile_required() -> vk::Result {
    vk::Result::PIPELINE_COMPILE_REQUIRED
}

/// `TestParams::Iteration`
#[derive(Clone)]
struct Iteration {
    variants: Vec<vk::PipelineCreateFlags>,
    validators: Vec<Validator>,
}

/// `TestParams`
#[derive(Clone)]
struct TestParams {
    name: &'static str,
    cache_type: CacheType,
    iterations: Vec<Iteration>,
    use_maintenance5: bool,
}

fn normal() -> vk::PipelineCreateFlags {
    vk::PipelineCreateFlags::empty()
}

fn no_compile() -> vk::PipelineCreateFlags {
    vk::PipelineCreateFlags::FAIL_ON_PIPELINE_COMPILE_REQUIRED
}

fn early_return() -> vk::PipelineCreateFlags {
    no_compile() | vk::PipelineCreateFlags::EARLY_RETURN_ON_FAILURE
}

fn test_cases() -> Vec<TestParams> {
    use Validator::*;
    let fail = TestResult::Fail;
    let compat = TestResult::CompatibilityWarning;
    let quality = TestResult::QualityWarning;

    // Iteration [0]: Force compilation of pipeline
    let force_compile = || Iteration {
        variants: vec![normal()],
        validators: vec![CheckResult(vk::Result::SUCCESS, fail), PipelineMustBeValid(0, fail)],
    };

    vec![
        // Single creation of never before seen pipeline without compile
        TestParams {
            name: "single_pipeline_no_compile",
            cache_type: CacheType::NoCache,
            iterations: vec![Iteration {
                variants: vec![no_compile()],
                // Warn if pipeline took too long
                validators: vec![ElapsedTime(TimeLimit::Immediate, quality)],
            }],
            use_maintenance5: false,
        },
        // Batch creation of pipelines with early return
        TestParams {
            name: "batch_pipelines_early_return",
            cache_type: CacheType::NoCache,
            iterations: vec![Iteration {
                variants: vec![early_return(), normal(), no_compile()],
                validators: vec![
                    // fail if a valid pipeline follows the early-return failure
                    PipelineNullAfterIndex(0, fail),
                    // Warn if return was not immediate
                    ElapsedTime(TimeLimit::Immediate, quality),
                    // Warn if pipelines[0] is not VK_NULL_HANDLE
                    PipelineMustBeNull(0, compat),
                    // Warn if result is not VK_ERROR_PIPELINE_COMPILE_REQUIRED_EXT
                    CheckResult(compile_required(), compat),
                ],
            }],
            use_maintenance5: false,
        },
        // Duplicate single pipeline recreation with explicit caching
        TestParams {
            name: "duplicate_single_recreate_explicit_caching",
            cache_type: CacheType::ExplicitCache,
            iterations: vec![
                force_compile(),
                // Iteration [1]: Request compilation of same pipeline without compile
                Iteration {
                    variants: vec![no_compile()],
                    validators: vec![
                        // Warn if result is not VK_SUCCESS
                        CheckResult(vk::Result::SUCCESS, compat),
                        // Warn if pipeline is not valid
                        PipelineMustBeValid(0, compat),
                        // Warn if pipeline took too long
                        ElapsedTime(TimeLimit::Fast, quality),
                    ],
                },
            ],
            use_maintenance5: false,
        },
        // Duplicate single pipeline recreation with no explicit cache
        TestParams {
            name: "duplicate_single_recreate_no_caching",
            cache_type: CacheType::NoCache,
            iterations: vec![
                force_compile(),
                Iteration {
                    variants: vec![no_compile()],
                    // Warn if pipeline took too long
                    validators: vec![ElapsedTime(TimeLimit::Fast, quality)],
                },
            ],
            use_maintenance5: false,
        },
        // Duplicate single pipeline recreation using derivative pipelines
        TestParams {
            name: "duplicate_single_recreate_derivative",
            cache_type: CacheType::DerivativeHandle,
            iterations: vec![
                force_compile(),
                Iteration {
                    variants: vec![no_compile()],
                    // Warn if pipeline took too long
                    validators: vec![ElapsedTime(TimeLimit::Fast, quality)],
                },
            ],
            use_maintenance5: false,
        },
        // Batch creation of duplicate pipelines with explicit caching
        TestParams {
            name: "duplicate_batch_pipelines_explicit_cache",
            cache_type: CacheType::ExplicitCache,
            iterations: vec![Iteration {
                variants: vec![no_compile(), normal(), no_compile()],
                validators: vec![
                    // Fail if pipeline[1] is not valid
                    PipelineMustBeValid(1, fail),
                    // Warn if result is not VK_ERROR_PIPELINE_COMPILE_REQUIRED_EXT
                    CheckResult(compile_required(), compat),
                    // Warn if pipelines[0] is not VK_NULL_HANDLE
                    PipelineMustBeNull(0, compat),
                    // Warn if pipelines[2] is not valid
                    PipelineMustBeValid(2, compat),
                ],
            }],
            use_maintenance5: false,
        },
        // Batch creation of duplicate pipelines with no caching
        TestParams {
            name: "duplicate_batch_pipelines_no_cache",
            cache_type: CacheType::NoCache,
            iterations: vec![Iteration {
                variants: vec![no_compile(), normal(), no_compile()],
                validators: vec![
                    PipelineMustBeValid(1, fail),
                    CheckResult(compile_required(), compat),
                    PipelineMustBeNull(0, compat),
                ],
            }],
            use_maintenance5: false,
        },
        // Batch creation of duplicate pipelines with derivative pipeline index
        TestParams {
            name: "duplicate_batch_pipelines_derivative_index",
            cache_type: CacheType::DerivativeIndex,
            iterations: vec![Iteration {
                variants: vec![no_compile(), normal(), no_compile()],
                validators: vec![
                    PipelineMustBeValid(1, fail),
                    CheckResult(compile_required(), compat),
                    PipelineMustBeNull(0, compat),
                ],
            }],
            use_maintenance5: false,
        },
        // Batch creation of pipelines with early return using VkPipelineCreateFlagBits2KHR from maintenance5
        TestParams {
            name: "batch_pipelines_early_return_maintenance5",
            cache_type: CacheType::NoCache,
            iterations: vec![Iteration {
                variants: vec![early_return(), normal(), no_compile()],
                validators: vec![
                    PipelineNullAfterIndex(0, fail),
                    ElapsedTime(TimeLimit::Immediate, quality),
                    PipelineMustBeNull(0, compat),
                    CheckResult(compile_required(), compat),
                ],
            }],
            use_maintenance5: true,
        },
    ]
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    Graphics,
    Compute,
}

/// `createPipelineCreateInfos` flag handling, shared by the graphics and compute variants: returns the flags and base pipeline
/// index of each variant.
fn variant_flags(iteration: &Iteration, cache_type: CacheType) -> Vec<(vk::PipelineCreateFlags, i32)> {
    let mut output = Vec::new();
    let mut base_pipeline_index = -1i32;

    for (count, &variant) in iteration.variants.iter().enumerate() {
        let cur_index = count as i32;
        let mut flags = variant;

        if cache_type == CacheType::DerivativeIndex {
            if flags.contains(vk::PipelineCreateFlags::FAIL_ON_PIPELINE_COMPILE_REQUIRED) {
                if base_pipeline_index != -1 {
                    flags |= vk::PipelineCreateFlags::DERIVATIVE;
                }
            } else {
                flags |= vk::PipelineCreateFlags::ALLOW_DERIVATIVES;

                if base_pipeline_index == -1 {
                    base_pipeline_index = cur_index;
                }
            }
        }

        output.push((flags, base_pipeline_index));
    }

    output
}

struct CacheControlCase {
    kind: Kind,
    params: TestParams,
}

impl TestCase for CacheControlCase {
    fn name(&self) -> &str {
        self.params.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_pipeline_creation_cache_control")?;

        let mut features = vk::PhysicalDevicePipelineCreationCacheControlFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if features.pipeline_creation_cache_control == vk::FALSE {
            return Err(TestError::NotSupported(
                "Feature 'pipelineCreationCacheControl' is not enabled".to_string(),
            ));
        }

        if self.params.use_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::Graphics => CACHE_CONTROL_GRAPHICS.programs,
            Kind::Compute => CACHE_CONTROL_COMPUTE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CacheControlInstance {
            context,
            kind: self.kind,
            params: self.params.clone(),
        })
    }
}

struct CacheControlInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    params: TestParams,
}

/// `createPipelineCache(vk, device, params)`: only the explicit cache type has one.
fn create_pipeline_cache<'a>(
    device: &'a Device,
    params: &TestParams,
) -> Result<Option<Unique<'a, vk::PipelineCache>>, TestError> {
    if params.cache_type != CacheType::ExplicitCache {
        return Ok(None);
    }

    let cache = unsafe { device.create_pipeline_cache(&vk::PipelineCacheCreateInfo::builder(), None) }
        .vk_check("vkCreatePipelineCache")?;
    Ok(Some(Unique::new(device, cache)))
}

impl TestInstance for CacheControlInstance<'_> {
    /// `graphics_tests::testInstance` and `compute_tests::testInstance`, which differ only in how the infos are made and submitted.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let pipeline_cache = create_pipeline_cache(device, params)?;
        let cache_handle = pipeline_cache.as_ref().map_or(vk::PipelineCache::null(), |c| **c);
        let binaries = context.get_binary_collection();

        // Everything the base create info points at has to outlive the loop.
        let mut descriptor_set_layout = None;
        let mut render_pass = None;
        let pipeline_layout;
        let modules;

        // Graphics state, as `getPipelineCreateInfoCommon`.
        let vertex_binding = vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        };
        let vertex_attribute = vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        };
        let vertex_bindings = [vertex_binding];
        let vertex_attributes = [vertex_attribute];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let ia_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(true);
        let tessellation_state = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(0);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: 1.0,
            height: 1.0,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: 256,
                height: 256,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(true)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let sample_masks = [0 as vk::SampleMask];
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .sample_shading_enable(false)
            .min_sample_shading(0.0)
            .sample_mask(&sample_masks);
        let stencil_op_state = vk::StencilOpState {
            fail_op: vk::StencilOp::ZERO,
            pass_op: vk::StencilOp::ZERO,
            depth_fail_op: vk::StencilOp::ZERO,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(false)
            .depth_write_enable(false)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::ONE,
            dst_color_blend_factor: vk::BlendFactor::ZERO,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ONE,
            dst_alpha_blend_factor: vk::BlendFactor::ZERO,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::all(),
        }];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::SET)
            .attachments(&color_blend_attachments)
            .blend_constants([0.0; 4]);
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder();

        let stage_info = match self.kind {
            Kind::Graphics => {
                pipeline_layout = Unique::new(
                    device,
                    unsafe { device.create_pipeline_layout(&vk::PipelineLayoutCreateInfo::builder(), None) }
                        .vk_check("vkCreatePipelineLayout")?,
                );

                // `createRenderPass`: the final layout is PRESENT_SRC_KHR, as upstream's.
                let color_attachment = vk::AttachmentDescription::builder()
                    .format(vk::Format::R8G8B8A8_UNORM)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::PRESENT_SRC_KHR)
                    .build();
                let color_refs = [vk::AttachmentReference {
                    attachment: 0,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                }];
                let subpass = vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(&color_refs)
                    .build();
                let attachments = [color_attachment];
                let subpasses = [subpass];
                let render_pass_info = vk::RenderPassCreateInfo::builder()
                    .attachments(&attachments)
                    .subpasses(&subpasses);
                render_pass = Some(Unique::new(
                    device,
                    unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
                ));

                // No fragment due to rasterizationDiscardEnabled
                modules = vec![create_shader_module(device, binaries.get("vertex")?)?];
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*modules[0])
                    .name(b"main\0")
                    .build()
            }
            Kind::Compute => {
                let layout = DescriptorSetLayoutBuilderOne::build(device)?;
                let set_layouts = [*layout];
                let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
                pipeline_layout = Unique::new(
                    device,
                    unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
                );
                descriptor_set_layout = Some(layout);

                modules = vec![create_shader_module(device, binaries.get("compute")?)?];
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::COMPUTE)
                    .module(*modules[0])
                    .name(b"main\0")
                    .build()
            }
        };
        let _keep_alive = (&descriptor_set_layout, &render_pass);

        let stages = [stage_info];
        let mut base_graphics_info = vk::GraphicsPipelineCreateInfo::default();
        base_graphics_info.stage_count = 1;
        base_graphics_info.stages = stages.as_ptr();
        base_graphics_info.vertex_input_state = &*vertex_input_state;
        base_graphics_info.input_assembly_state = &*ia_state;
        base_graphics_info.tessellation_state = &*tessellation_state;
        base_graphics_info.viewport_state = &*viewport_state;
        base_graphics_info.rasterization_state = &*rasterization_state;
        base_graphics_info.multisample_state = &*multisample_state;
        base_graphics_info.depth_stencil_state = &*depth_stencil_state;
        base_graphics_info.color_blend_state = &*color_blend_state;
        base_graphics_info.dynamic_state = &*dynamic_state;
        base_graphics_info.layout = *pipeline_layout;
        base_graphics_info.render_pass = render_pass.as_ref().map_or(vk::RenderPass::null(), |r| **r);
        base_graphics_info.subpass = 0;
        base_graphics_info.base_pipeline_handle = vk::Pipeline::null();
        base_graphics_info.base_pipeline_index = -1;

        let mut base_compute_info = vk::ComputePipelineCreateInfo::default();
        base_compute_info.stage = stage_info;
        base_compute_info.layout = *pipeline_layout;
        base_compute_info.base_pipeline_handle = vk::Pipeline::null();
        base_compute_info.base_pipeline_index = -1;

        // Placeholder for base pipeline if using cacheType == DERIVATIVE_HANDLE
        let mut base_pipeline: Option<Unique<'_, vk::Pipeline>> = None;

        let mut results: Vec<vk::Result> = Vec::with_capacity(params.iterations.len());

        for iteration in &params.iterations {
            let base_handle = base_pipeline.as_ref().map_or(vk::Pipeline::null(), |p| **p);
            let variants = variant_flags(iteration, params.cache_type);
            let count = variants.len();
            let mut created = vec![vk::Pipeline::null(); count];

            let timed_result = match self.kind {
                Kind::Graphics => {
                    let mut create_infos: Vec<vk::GraphicsPipelineCreateInfo> = variants
                        .iter()
                        .map(|&(flags, base_index)| {
                            let mut info = base_graphics_info;
                            info.flags = flags;
                            info.base_pipeline_handle = base_handle;
                            info.base_pipeline_index = base_index;
                            info
                        })
                        .collect();

                    let mut flags2_create_info: Vec<vk::PipelineCreateFlags2CreateInfo> = (0..count)
                        .map(|_| vk::PipelineCreateFlags2CreateInfo::default())
                        .collect();
                    if params.use_maintenance5 {
                        for ci in 0..count {
                            flags2_create_info[ci].flags =
                                vk::PipelineCreateFlags2::from_bits_truncate(create_infos[ci].flags.bits() as u64);
                            // VUID-VkPipelineCreateFlags2CreateInfoKHR-flags-requiredbitmask says it it not valid to have 0 flags in VkPipelineCreateFlags2CreateInfoKHR
                            // Only add flags2 if it's not 0
                            if !flags2_create_info[ci].flags.is_empty() {
                                flags2_create_info[ci].next = create_infos[ci].next;
                                create_infos[ci].flags = vk::PipelineCreateFlags::empty();
                                create_infos[ci].next =
                                    (&flags2_create_info[ci] as *const vk::PipelineCreateFlags2CreateInfo).cast();
                            }
                        }
                    }

                    let entry_point = device.commands().create_graphics_pipelines;
                    let time_start = Instant::now();
                    let result = unsafe {
                        entry_point(
                            device.handle(),
                            cache_handle,
                            count as u32,
                            create_infos.as_ptr(),
                            std::ptr::null(),
                            created.as_mut_ptr(),
                        )
                    };
                    (result, time_start.elapsed())
                }
                Kind::Compute => {
                    let create_infos: Vec<vk::ComputePipelineCreateInfo> = variants
                        .iter()
                        .map(|&(flags, base_index)| {
                            let mut info = base_compute_info;
                            info.flags = flags;
                            info.base_pipeline_handle = base_handle;
                            info.base_pipeline_index = base_index;
                            info
                        })
                        .collect();

                    let entry_point = device.commands().create_compute_pipelines;
                    let time_start = Instant::now();
                    let result = unsafe {
                        entry_point(
                            device.handle(),
                            cache_handle,
                            count as u32,
                            create_infos.as_ptr(),
                            std::ptr::null(),
                            created.as_mut_ptr(),
                        )
                    };
                    (result, time_start.elapsed())
                }
            };

            // `wrapHandles`
            let mut pipelines: Vec<Option<Unique<'_, vk::Pipeline>>> = created
                .iter()
                .map(|&p| {
                    if p != vk::Pipeline::null() {
                        Some(Unique::new(device, p))
                    } else {
                        None
                    }
                })
                .collect();

            let status = validate_results(timed_result.0, &created, timed_result.1, &iteration.validators)?;
            if status.code() != TestResult::Pass {
                return Ok(status);
            }

            if params.cache_type == CacheType::DerivativeHandle
                && base_pipeline.is_none()
                && let Some(pipeline) = pipelines.iter_mut().find_map(|p| p.take())
            {
                base_pipeline = Some(pipeline);
            }

            results.push(timed_result.0);
        }

        let results_string = results.iter().map(|r| format!("{r:?}")).collect::<Vec<_>>().join(", ");
        Ok(TestStatus::pass(format!(
            "Test Passed. results[{}]={{ {} }}",
            results.len(),
            results_string
        )))
    }
}

/// `compute_tests::createDescriptorSetLayout`: one storage buffer binding at 0 for the compute stage.
struct DescriptorSetLayoutBuilderOne;

impl DescriptorSetLayoutBuilderOne {
    fn build(device: &Device) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        crate::vk::builder_util::DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)
    }
}

/// `createCacheControlTests`, for monolithic pipelines.
pub fn create_cache_control_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("creation_cache_control");

    for (group_name, kind) in [
        ("graphics_pipelines", Kind::Graphics),
        ("compute_pipelines", Kind::Compute),
    ] {
        let mut group = TestCaseGroup::new(group_name);
        for params in test_cases() {
            group.add_child(Box::new(CacheControlCase { kind, params }) as Box<dyn TestCase>);
        }
        tests.add_child(group);
    }

    tests
}
