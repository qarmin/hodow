// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineCreationFeedbackTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic construction type is built, in `TestMode::CACHE` and
// `TestMode::BINARY` (`add_pipeline_binary_creation_feedback_tests`, over `binary_tests::PipelineBinaryWrapper`; the library
// flavours do not exist here), so only the final-pipeline feedback slot of each of the three pipelines is ever written
// and checked, and it is always one of the heavy ones. The work upstream does in the instance constructors happens at the
// top of `iterate`, in the same order.

use std::mem::size_of;

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_creation_feedback::{
    CF_COMPUTE, CF_VERT_FRAG, CF_VERT_GEOM_FRAG, CF_VERT_TESS_FRAG,
};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::obj_util::make_pipeline_layout;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::pipeline::binary_tests::PipelineBinaryWrapper;
use crate::vkt::tests::pipeline::cache_tests::{Vertex4Rgba, make_render_pass};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const MAX_SHADER_STAGES: usize = 6;
/// 4 parts + 1 final
const MAX_PIPELINE_PARTS: usize = 5;
const FINAL_PIPELINE_INDEX: usize = MAX_PIPELINE_PARTS - 1;

const PIPELINE_NDX_NO_BLOBS: usize = 0;
const PIPELINE_NDX_DERIVATIVE: usize = 1;
const PIPELINE_NDX_USE_BLOBS: usize = 2;
const PIPELINE_NDX_COUNT: usize = 3;

const RENDER_SIZE: u32 = 32;

/// The shader stage sets `createTestsInternal` builds its pipelines from.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Stages {
    VertFrag,
    VertGeomFrag,
    VertTessFrag,
    Compute,
}

/// `getShaderFlagStr` with `isDescription` false.
fn shader_flag_str(stages: Stages) -> &'static str {
    match stages {
        Stages::Compute => "compute_stage",
        Stages::VertFrag => "vertex_stage_fragment_stage",
        Stages::VertGeomFrag => "vertex_stage_geometry_stage_fragment_stage",
        Stages::VertTessFrag => "vertex_stage_tessellation_control_stage_tessellation_evaluation_stage_fragment_stage",
    }
}

/// `getCaseStr`
fn case_str(ndx: usize) -> &'static str {
    match ndx {
        PIPELINE_NDX_NO_BLOBS => "No cached pipeline",
        PIPELINE_NDX_USE_BLOBS => "Cached pipeline",
        _ => "Pipeline derivative",
    }
}

/// `TestParam`, with the mode and the construction type left out.
#[derive(Clone, Copy)]
struct TestParam {
    stages: Stages,
    no_cache: bool,
    delayed_destroy: bool,
    zero_out_feedback_count: bool,
    /// `TestMode::BINARY`
    binary: bool,
}

impl TestParam {
    fn new(stages: Stages, no_cache: bool, delayed_destroy: bool, zero_out_feedback_count: bool) -> Self {
        Self {
            stages,
            no_cache,
            delayed_destroy,
            zero_out_feedback_count,
            binary: false,
        }
    }

    fn new_binary(stages: Stages, no_cache: bool, delayed_destroy: bool, zero_out_feedback_count: bool) -> Self {
        Self {
            binary: true,
            ..Self::new(stages, no_cache, delayed_destroy, zero_out_feedback_count)
        }
    }

    /// `TestParam::generateTestName`
    fn generate_test_name(&self) -> String {
        let mut name = shader_flag_str(self.stages).to_string();
        if self.no_cache {
            name += "_no_cache";
        }
        if self.delayed_destroy {
            name += "_delayed_destroy";
        }
        if self.zero_out_feedback_count {
            name += "_zero_out_feedback_cout";
        }
        name
    }
}

const EMPTY_FEEDBACK: vk::PipelineCreationFeedback = vk::PipelineCreationFeedback {
    flags: vk::PipelineCreationFeedbackFlags::empty(),
    duration: 0,
};

/// `BaseTestInstance`'s pipeline cache: absent when the cache is disabled, in which case the null handle is used.
fn create_pipeline_cache<'a>(
    device: &'a Device,
    param: &TestParam,
) -> Result<Option<Unique<'a, vk::PipelineCache>>, TestError> {
    if param.no_cache {
        return Ok(None);
    }

    let info = vk::PipelineCacheCreateInfo::builder();
    Ok(Some(Unique::new(
        device,
        unsafe { device.create_pipeline_cache(&info, None) }.vk_check("vkCreatePipelineCache")?,
    )))
}

fn cache_handle_of(cache: &Option<Unique<'_, vk::PipelineCache>>) -> vk::PipelineCache {
    cache.as_ref().map_or(vk::PipelineCache::null(), |cache| **cache)
}

struct CreationFeedbackCase {
    name: String,
    param: TestParam,
}

impl TestCase for CreationFeedbackCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `BaseTestCase::checkSupport` plus `GraphicsTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.param.binary {
            context.require_device_functionality("VK_KHR_pipeline_binary")?;
        }
        context.require_device_functionality("VK_EXT_pipeline_creation_feedback")?;

        if self.param.stages == Stages::VertGeomFrag && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::geometryShader".to_string(),
            ));
        }
        if self.param.stages == Stages::VertTessFrag && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::tessellationShader".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.param.stages {
            Stages::VertFrag => CF_VERT_FRAG.programs,
            Stages::VertGeomFrag => CF_VERT_GEOM_FRAG.programs,
            Stages::VertTessFrag => CF_VERT_TESS_FRAG.programs,
            Stages::Compute => CF_COMPUTE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CreationFeedbackInstance {
            context,
            param: self.param,
        })
    }
}

struct CreationFeedbackInstance<'a> {
    context: &'a Context<'a>,
    param: TestParam,
}

impl TestInstance for CreationFeedbackInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.param.stages == Stages::Compute {
            iterate_compute(self.context, &self.param)
        } else {
            iterate_graphics(self.context, &self.param)
        }
    }
}

/// The creation feedback structures one pipeline writes to.
struct FeedbackTarget {
    pipeline: *mut vk::PipelineCreationFeedback,
    stage_count: u32,
    stages: *mut vk::PipelineCreationFeedback,
}

impl FeedbackTarget {
    fn create_info(&self) -> vk::PipelineCreationFeedbackCreateInfo {
        vk::PipelineCreationFeedbackCreateInfo {
            s_type: vk::StructureType::PIPELINE_CREATION_FEEDBACK_CREATE_INFO,
            next: std::ptr::null(),
            pipeline_creation_feedback: self.pipeline,
            pipeline_stage_creation_feedback_count: self.stage_count,
            pipeline_stage_creation_feedbacks: self.stages,
        }
    }
}

struct GraphicsModules {
    vert: vk::ShaderModule,
    tesc: Option<vk::ShaderModule>,
    tese: Option<vk::ShaderModule>,
    geom: Option<vk::ShaderModule>,
    frag: vk::ShaderModule,
}

/// `GraphicsTestInstance::preparePipelineWrapper` for a monolithic pipeline.
#[allow(clippy::too_many_arguments)]
fn prepare_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    modules: &GraphicsModules,
    cache: vk::PipelineCache,
    flags: vk::PipelineCreateFlags,
    flags2: Option<vk::PipelineCreateFlags2>,
    base_pipeline: vk::Pipeline,
    feedback: &FeedbackTarget,
    binaries: Option<Vec<vk::PipelineBinaryKHR>>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut stages = vec![(vk::ShaderStageFlags::VERTEX, modules.vert)];
    if let Some(module) = modules.tesc {
        stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, module));
    }
    if let Some(module) = modules.tese {
        stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, module));
    }
    if let Some(module) = modules.geom {
        stages.push((vk::ShaderStageFlags::GEOMETRY, module));
    }
    stages.push((vk::ShaderStageFlags::FRAGMENT, modules.frag));

    let mut state = DrawPipelineState::new(if modules.tesc.is_none() {
        vk::PrimitiveTopology::TRIANGLE_LIST
    } else {
        vk::PrimitiveTopology::PATCH_LIST
    })
    .with_full_viewport(RENDER_SIZE, RENDER_SIZE);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: size_of::<Vertex4Rgba>() as u32,
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
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0)
        .build();
    let stencil = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .compare_mask(0)
        .write_mask(0)
        .reference(0)
        .build();
    state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(true)
        .depth_write_enable(true)
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil)
        .back(stencil)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build();
    if modules.tesc.is_some() {
        state.patch_control_points = Some(3);
    }
    state.pipeline_cache = cache;
    state.create_flags = flags;
    if base_pipeline != vk::Pipeline::null() {
        state.base_pipeline = Some((base_pipeline, -1));
    }
    state.creation_feedback = Some(feedback.create_info());
    state.create_flags2 = flags2;
    if binaries.is_some() {
        // A pipeline made from binaries has no shader modules (`disableShaderModules`)
        state.null_shader_modules = true;
        state.binary_info = binaries;
    }

    create_draw_pipeline(device, layout, render_pass, &stages, &state)
}

/// `GraphicsTestInstance` - the constructor and `verifyTestResult`.
fn iterate_graphics<'a>(context: &'a Context<'a>, param: &TestParam) -> TestOutcome {
    let device = context.get_device();
    let binaries = context.get_binary_collection();

    // BaseTestInstance
    let cache = create_pipeline_cache(device, param)?;
    let cache_handle = cache_handle_of(&cache);

    // Create pipeline layout
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    // Create render pass
    let render_pass = make_render_pass(device, vk::ImageLayout::UNDEFINED)?;

    // Create shader modules
    let vert_module1 = create_shader_module(device, binaries.get("color_vert_1")?)?;
    let vert_module2 = create_shader_module(device, binaries.get("color_vert_2")?)?;
    let frag_module = create_shader_module(device, binaries.get("color_frag")?)?;
    let geom_module = if param.stages == Stages::VertGeomFrag {
        Some(create_shader_module(device, binaries.get("unused_geo")?)?)
    } else {
        None
    };
    let tesc_module = if param.stages == Stages::VertTessFrag {
        Some(create_shader_module(device, binaries.get("basic_tcs")?)?)
    } else {
        None
    };
    let tese_module = if param.stages == Stages::VertTessFrag {
        Some(create_shader_module(device, binaries.get("basic_tes")?)?)
    } else {
        None
    };

    let geometry_stages =
        1 + u32::from(geom_module.is_some()) + u32::from(tesc_module.is_some()) + u32::from(tese_module.is_some());

    let mut pipeline_creation_feedback = [EMPTY_FEEDBACK; MAX_PIPELINE_PARTS * PIPELINE_NDX_COUNT];
    let mut pipeline_stage_creation_feedbacks = [EMPTY_FEEDBACK; PIPELINE_NDX_COUNT * MAX_SHADER_STAGES];

    if param.binary {
        // Repeat the algorithm of the cache mode, with the loop unwound
        let modules_with = |vert: vk::ShaderModule| GraphicsModules {
            vert,
            tesc: tesc_module.as_ref().map(|module| **module),
            tese: tese_module.as_ref().map(|module| **module),
            geom: geom_module.as_ref().map(|module| **module),
            frag: *frag_module,
        };
        let feedbacks: Vec<FeedbackTarget> = (0..PIPELINE_NDX_COUNT)
            .map(|ndx| FeedbackTarget {
                pipeline: unsafe {
                    pipeline_creation_feedback
                        .as_mut_ptr()
                        .add(MAX_PIPELINE_PARTS * ndx + FINAL_PIPELINE_INDEX)
                },
                stage_count: if param.zero_out_feedback_count {
                    0
                } else {
                    1 + geometry_stages
                },
                stages: unsafe {
                    pipeline_stage_creation_feedbacks
                        .as_mut_ptr()
                        .add(MAX_SHADER_STAGES * ndx)
                },
            })
            .collect();
        let mut binaries_wrapper = PipelineBinaryWrapper::new(device);

        // Create pipeline that is used to create binaries
        let no_blobs = prepare_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &modules_with(*vert_module1),
            cache_handle,
            vk::PipelineCreateFlags::empty(),
            Some(vk::PipelineCreateFlags2::ALLOW_DERIVATIVES | vk::PipelineCreateFlags2::CAPTURE_DATA_KHR),
            vk::Pipeline::null(),
            &feedbacks[PIPELINE_NDX_NO_BLOBS],
            None,
        )?;
        binaries_wrapper.create_from_pipeline(*no_blobs);
        let binary_handles = binaries_wrapper.handles().to_vec();

        // Create derivative pipeline that also uses binaries, and destroy it as soon as it was created
        drop(prepare_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &modules_with(*vert_module2),
            cache_handle,
            vk::PipelineCreateFlags::DERIVATIVE,
            None,
            *no_blobs,
            &feedbacks[PIPELINE_NDX_DERIVATIVE],
            Some(binary_handles.clone()),
        )?);

        // Destroy the NO_BLOBS pipeline to check that the cached one really hits cache, except for the case where a
        // pipeline still active is tested for a cache hit.
        let mut no_blobs = Some(no_blobs);
        if !param.delayed_destroy {
            no_blobs = None;
        }

        // Create third pipeline that just uses binaries, and destroy it as soon as it was created
        drop(prepare_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &modules_with(*vert_module1),
            cache_handle,
            vk::PipelineCreateFlags::ALLOW_DERIVATIVES,
            None,
            vk::Pipeline::null(),
            &feedbacks[PIPELINE_NDX_USE_BLOBS],
            Some(binary_handles),
        )?);

        if param.delayed_destroy {
            no_blobs = None;
        }
        drop(no_blobs);

        return verify_graphics_result(param, &pipeline_creation_feedback, &pipeline_stage_creation_feedbacks);
    }

    let mut no_blobs: Option<Unique<'_, vk::Pipeline>> = None;

    for ndx in 0..PIPELINE_NDX_COUNT {
        let vert_module = if ndx == PIPELINE_NDX_DERIVATIVE {
            &vert_module2
        } else {
            &vert_module1
        };

        if ndx == PIPELINE_NDX_USE_BLOBS && !param.delayed_destroy {
            // Destroy the NO_BLOBS pipeline to check that the cached one really hits cache, except for the case where a
            // pipeline still active is tested for a cache hit.
            no_blobs = None;
        }

        // clearFeedbacks
        pipeline_creation_feedback = [EMPTY_FEEDBACK; MAX_PIPELINE_PARTS * PIPELINE_NDX_COUNT];
        pipeline_stage_creation_feedbacks = [EMPTY_FEEDBACK; PIPELINE_NDX_COUNT * MAX_SHADER_STAGES];

        let base_pipeline = match (&no_blobs, ndx) {
            (Some(pipeline), PIPELINE_NDX_DERIVATIVE) => **pipeline,
            _ => vk::Pipeline::null(),
        };

        let modules = GraphicsModules {
            vert: **vert_module,
            tesc: tesc_module.as_ref().map(|module| **module),
            tese: tese_module.as_ref().map(|module| **module),
            geom: geom_module.as_ref().map(|module| **module),
            frag: *frag_module,
        };
        let flags = if ndx == PIPELINE_NDX_DERIVATIVE {
            vk::PipelineCreateFlags::DERIVATIVE
        } else {
            vk::PipelineCreateFlags::ALLOW_DERIVATIVES
        };
        let feedback = FeedbackTarget {
            pipeline: std::ptr::addr_of_mut!(
                pipeline_creation_feedback[MAX_PIPELINE_PARTS * ndx + FINAL_PIPELINE_INDEX]
            ),
            stage_count: if param.zero_out_feedback_count {
                0
            } else {
                1 + geometry_stages
            },
            stages: std::ptr::addr_of_mut!(pipeline_stage_creation_feedbacks[MAX_SHADER_STAGES * ndx]),
        };

        let pipeline = prepare_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &modules,
            cache_handle,
            flags,
            None,
            base_pipeline,
            &feedback,
            None,
        )?;

        if ndx == PIPELINE_NDX_NO_BLOBS {
            // Kept as the base pipeline of the derivative case.
            no_blobs = Some(pipeline);
        } else {
            // Destroy the pipeline as soon as it is created.
            drop(pipeline);

            if ndx == PIPELINE_NDX_USE_BLOBS && param.delayed_destroy {
                // Destroy the pipeline that was not destroyed earlier for the delayed destroy case.
                no_blobs = None;
            }
        }
    }

    verify_graphics_result(param, &pipeline_creation_feedback, &pipeline_stage_creation_feedbacks)
}

/// `GraphicsTestInstance::verifyTestResult` for the monolithic construction type.
fn verify_graphics_result(
    param: &TestParam,
    pipeline_creation_feedback: &[vk::PipelineCreationFeedback; MAX_PIPELINE_PARTS * PIPELINE_NDX_COUNT],
    pipeline_stage_creation_feedbacks: &[vk::PipelineCreationFeedback; PIPELINE_NDX_COUNT * MAX_SHADER_STAGES],
) -> TestOutcome {
    let mut duration_zero_warning = false;
    let mut cached_pipeline_warning = false;
    let zero_out_feedback_count = param.zero_out_feedback_count;

    // Only the feedback of the final pipeline is written for a monolithic pipeline, so the parts are stepped over.
    for creation_feedback_ndx in
        (FINAL_PIPELINE_INDEX..MAX_PIPELINE_PARTS * PIPELINE_NDX_COUNT).step_by(FINAL_PIPELINE_INDEX + 1)
    {
        let pipeline_cache_ndx = creation_feedback_ndx / MAX_PIPELINE_PARTS;
        let creation_feedback = pipeline_creation_feedback[creation_feedback_ndx];
        let creation_feedback_flags = creation_feedback.flags;
        let case_string = case_str(pipeline_cache_ndx);
        let pipeline_part_index = creation_feedback_ndx % MAX_PIPELINE_PARTS;

        let mut message = String::from(case_string);

        // According to the spec: "An implementation should write pipeline creation feedback to pPipelineCreationFeedback and
        // may write pipeline stage creation feedback to pPipelineStageCreationFeedbacks."
        if !creation_feedback_flags.contains(vk::PipelineCreationFeedbackFlags::VALID) {
            // "If the VK_PIPELINE_CREATION_FEEDBACK_VALID_BIT_EXT is not set in flags, an implementation must not set any
            // other bits in flags, and all other VkPipelineCreationFeedbackEXT data members are undefined."
            if !creation_feedback_flags.is_empty() {
                return Ok(TestStatus::fail(
                    ": Creation feedback is not valid but there are other flags written",
                ));
            }
            message += "\t\t Pipeline Creation Feedback data is not valid\n";
        } else {
            if param.no_cache
                && creation_feedback_flags.contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
            {
                message += ": feedback indicates pipeline hit cache when it shouldn't";
                return Ok(TestStatus::fail(message));
            }

            if pipeline_cache_ndx == PIPELINE_NDX_NO_BLOBS
                && creation_feedback_flags.contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
            {
                message += ": hit the cache when it shouldn't";
                return Ok(TestStatus::fail(message));
            }

            if pipeline_cache_ndx != PIPELINE_NDX_DERIVATIVE
                && creation_feedback_flags.contains(vk::PipelineCreationFeedbackFlags::BASE_PIPELINE_ACCELERATION)
            {
                message += ": feedback indicates base pipeline acceleration when it shouldn't";
                return Ok(TestStatus::fail(message));
            }

            if pipeline_cache_ndx == PIPELINE_NDX_USE_BLOBS
                && !param.no_cache
                && !creation_feedback_flags.contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
            {
                message += "\nWarning: Cached pipeline case did not hit the cache";
                cached_pipeline_warning = true;
            }

            // The final pipeline is the one that is expected to have a large creation time.
            if creation_feedback.duration == 0 {
                message += "\nWarning: Pipeline creation feedback reports duration spent creating a pipeline was zero nanoseconds\n";
                duration_zero_warning = true;
            }

            message += "\n";
            message += &format!(
                "\t\t Hit cache ? \t\t\t{}\n",
                yes_no(
                    creation_feedback_flags.contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
                )
            );
            message += &format!(
                "\t\t Base Pipeline Acceleration ? \t{}\n",
                yes_no(creation_feedback_flags.contains(vk::PipelineCreationFeedbackFlags::BASE_PIPELINE_ACCELERATION))
            );
            message += &format!("\t\t Duration (ns): \t\t{}\n", creation_feedback.duration);
        }

        // Check all shaders when checking the final pipelines.
        if pipeline_part_index == FINAL_PIPELINE_INDEX {
            let shader_count = match param.stages {
                Stages::VertFrag => 2,
                Stages::VertGeomFrag => 3,
                Stages::VertTessFrag => 4,
                Stages::Compute => 1,
            };
            for shader in 0..shader_count {
                let stage_feedback = pipeline_stage_creation_feedbacks[MAX_SHADER_STAGES * pipeline_cache_ndx + shader];
                message += &format!("\t{} shader stage\n", shader + 1);

                // "An implementation should write pipeline creation feedback to pPipelineCreationFeedback and may write
                // pipeline stage creation feedback to pPipelineStageCreationFeedbacks."
                if stage_feedback.flags.bits() & u32::from(zero_out_feedback_count) != 0 {
                    return Ok(TestStatus::fail(format!(
                        "{case_string}: feedback indicates pipeline {} shader stage feedback was generated despite setting feedback count to zero",
                        shader + 1
                    )));
                }

                if !stage_feedback.flags.contains(vk::PipelineCreationFeedbackFlags::VALID) {
                    // "If the VK_PIPELINE_CREATION_FEEDBACK_VALID_BIT_EXT is not set in flags, an implementation must not set
                    // any other bits in flags, and all other VkPipelineCreationFeedbackEXT data members are undefined."
                    if !stage_feedback.flags.is_empty() {
                        return Ok(TestStatus::fail(format!(
                            "{case_string}: Creation feedback is not valid for {} shader stage but there are other flags written",
                            shader + 1
                        )));
                    }
                    message += "\t\t Pipeline Creation Feedback data is not valid\n";
                    continue;
                }
                if param.no_cache
                    && stage_feedback
                        .flags
                        .contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
                {
                    return Ok(TestStatus::fail(format!(
                        "{case_string}: feedback indicates pipeline {} shader stage hit cache when it shouldn't",
                        shader + 1
                    )));
                }

                if pipeline_cache_ndx == PIPELINE_NDX_USE_BLOBS
                    && !param.no_cache
                    && !stage_feedback
                        .flags
                        .contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
                {
                    message += "Warning: pipeline stage did not hit the cache\n";
                    cached_pipeline_warning = true;
                }
                if cached_pipeline_warning
                    && stage_feedback
                        .flags
                        .contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
                {
                    // The warning is only set when neither the pipeline nor its stages hit the cache; if any did, it is disabled.
                    cached_pipeline_warning = false;
                }

                message += &format!(
                    "\t\t Hit cache ? \t\t\t{}\n",
                    yes_no(
                        stage_feedback
                            .flags
                            .contains(vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT)
                    )
                );
                message += &format!(
                    "\t\t Base Pipeline Acceleration ? \t{}\n",
                    yes_no(
                        stage_feedback
                            .flags
                            .contains(vk::PipelineCreationFeedbackFlags::BASE_PIPELINE_ACCELERATION)
                    )
                );
                message += &format!("\t\t Duration (ns): \t\t{}\n", stage_feedback.duration);
            }
        }

        log::info!("{message}");
    }

    final_status(cached_pipeline_warning, duration_zero_warning)
}

fn yes_no(value: bool) -> &'static str {
    if value { "yes" } else { "no" }
}

fn final_status(cached_pipeline_warning: bool, duration_zero_warning: bool) -> TestOutcome {
    if cached_pipeline_warning {
        return Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Cached pipeline or stage did not hit the cache",
        ));
    }
    if duration_zero_warning {
        return Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Pipeline creation feedback reports duration spent creating a pipeline was zero nanoseconds",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `ComputeTestInstance` - the constructor (`buildDescriptorSets`, `buildShader`, `buildPipeline` per pipeline) and
/// `verifyTestResult`.
fn iterate_compute<'a>(context: &'a Context<'a>, param: &TestParam) -> TestOutcome {
    let device = context.get_device();
    let binaries = context.get_binary_collection();
    let zero_out_feedback_count = param.zero_out_feedback_count;

    // BaseTestInstance
    let cache = create_pipeline_cache(device, param)?;
    let cache_handle = cache_handle_of(&cache);

    let mut pipeline_creation_feedback = [EMPTY_FEEDBACK; PIPELINE_NDX_COUNT];
    let mut pipeline_stage_creation_feedback = [EMPTY_FEEDBACK; PIPELINE_NDX_COUNT];

    let mut no_blobs: Option<Unique<'_, vk::Pipeline>> = None;
    let mut binaries_wrapper = PipelineBinaryWrapper::new(device);
    // Everything the pipelines were created from has to outlive the loop in the order upstream keeps it in the instance.
    let mut _kept: Vec<(
        Unique<'_, vk::DescriptorSetLayout>,
        Unique<'_, vk::ShaderModule>,
        Unique<'_, vk::PipelineLayout>,
    )> = Vec::new();

    for ndx in 0..PIPELINE_NDX_COUNT {
        // buildDescriptorSets
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // buildShader
        let shader_name = if ndx == PIPELINE_NDX_DERIVATIVE {
            "basic_compute_2"
        } else {
            "basic_compute_1"
        };
        let compute_module = create_shader_module(device, binaries.get(shader_name)?)?;

        // buildPipeline
        pipeline_creation_feedback[ndx] = EMPTY_FEEDBACK;
        pipeline_stage_creation_feedback[ndx] = EMPTY_FEEDBACK;

        let mut creation_feedback_info = vk::PipelineCreationFeedbackCreateInfo {
            s_type: vk::StructureType::PIPELINE_CREATION_FEEDBACK_CREATE_INFO,
            next: std::ptr::null(),
            pipeline_creation_feedback: std::ptr::addr_of_mut!(pipeline_creation_feedback[ndx]),
            pipeline_stage_creation_feedback_count: if zero_out_feedback_count { 0 } else { 1 },
            pipeline_stage_creation_feedbacks: std::ptr::addr_of_mut!(pipeline_stage_creation_feedback[ndx]),
        };

        // Create compute pipeline layout
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // A pipeline made from binaries is created with no shader stage module
        let uses_binaries = param.binary && ndx != PIPELINE_NDX_NO_BLOBS;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(if uses_binaries {
                vk::ShaderModule::null()
            } else {
                *compute_module
            })
            .name(b"main\0")
            .build();

        let flags = if ndx == PIPELINE_NDX_DERIVATIVE {
            vk::PipelineCreateFlags::DERIVATIVE
        } else {
            vk::PipelineCreateFlags::ALLOW_DERIVATIVES
        };
        let mut pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .flags(flags)
            .base_pipeline_index(0);
        if ndx == PIPELINE_NDX_DERIVATIVE {
            pipeline_info = pipeline_info
                .base_pipeline_handle(no_blobs.as_ref().map_or(vk::Pipeline::null(), |pipeline| **pipeline))
                .base_pipeline_index(-1);
        }

        if ndx == PIPELINE_NDX_USE_BLOBS && !param.delayed_destroy {
            // Destroy the NO_BLOBS pipeline to check that the cached one really hits cache, except for the case where a
            // pipeline still active is tested for a cache hit.
            no_blobs = None;
        }

        let created = if !param.binary {
            let pipeline_info = pipeline_info.push_next(&mut creation_feedback_info);
            unsafe { device.create_compute_pipelines(cache_handle, &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
        } else if ndx == PIPELINE_NDX_NO_BLOBS {
            // Switch to using VkPipelineCreateFlags2 and also include the flags that were specified in the create info
            let mut flags2_info = vk::PipelineCreateFlags2CreateInfo::builder().flags(
                vk::PipelineCreateFlags2::CAPTURE_DATA_KHR
                    | vk::PipelineCreateFlags2::from_bits_truncate(u64::from(flags.bits())),
            );
            let pipeline_info = pipeline_info
                .push_next(&mut creation_feedback_info)
                .push_next(&mut flags2_info);
            unsafe { device.create_compute_pipelines(cache_handle, &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
        } else {
            // Create the pipeline using the binaries; the create info is only the binary info, so no feedback is requested
            let binary_handles = binaries_wrapper.handles().to_vec();
            let mut binary_info = vk::PipelineBinaryInfoKHR::builder().pipeline_binaries(&binary_handles);
            let pipeline_info = pipeline_info.push_next(&mut binary_info);
            unsafe { device.create_compute_pipelines(cache_handle, &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
        };
        let pipeline = Unique::new(device, created.0[0]);

        if param.binary && ndx == PIPELINE_NDX_NO_BLOBS {
            // prepare pipeline binaries
            binaries_wrapper.create_from_pipeline(*pipeline);
        }

        if ndx == PIPELINE_NDX_NO_BLOBS {
            // Kept as the base pipeline of the derivative case.
            no_blobs = Some(pipeline);
        } else {
            // Destroy the pipeline as soon as it is created.
            drop(pipeline);

            if ndx == PIPELINE_NDX_USE_BLOBS && param.delayed_destroy {
                // Destroy the pipeline that was not destroyed earlier for the delayed destroy case.
                no_blobs = None;
            }
        }

        _kept.push((descriptor_set_layout, compute_module, pipeline_layout));
    }

    // verifyTestResult
    let mut duration_zero_warning = false;
    let mut cached_pipeline_warning = false;
    let cache_hit = vk::PipelineCreationFeedbackFlags::APPLICATION_PIPELINE_CACHE_HIT;
    let base_acceleration = vk::PipelineCreationFeedbackFlags::BASE_PIPELINE_ACCELERATION;

    for ndx in 0..PIPELINE_NDX_COUNT {
        let creation_feedback = pipeline_creation_feedback[ndx];
        let stage_feedback = pipeline_stage_creation_feedback[ndx];
        let mut message = String::from(case_str(ndx));

        // No per-stage check is needed for the single stage of a compute pipeline; the spec mentions that "One common
        // scenario for an implementation to skip per-stage feedback is when
        // VK_PIPELINE_CREATION_FEEDBACK_APPLICATION_PIPELINE_CACHE_HIT_BIT_EXT is set in pPipelineCreationFeedback."
        if !creation_feedback
            .flags
            .contains(vk::PipelineCreationFeedbackFlags::VALID)
        {
            if !creation_feedback.flags.is_empty() {
                return Ok(TestStatus::fail(
                    ": Creation feedback is not valid but there are other flags written",
                ));
            }
            message += "\t\t Pipeline Creation Feedback data is not valid\n";
        } else {
            if param.no_cache && creation_feedback.flags.contains(cache_hit) {
                message += ": feedback indicates pipeline hit cache when it shouldn't";
                return Ok(TestStatus::fail(message));
            }

            if ndx == PIPELINE_NDX_NO_BLOBS && creation_feedback.flags.contains(cache_hit) {
                message += ": hit the cache when it shouldn't";
                return Ok(TestStatus::fail(message));
            }

            if !(ndx == PIPELINE_NDX_DERIVATIVE && !param.no_cache)
                && creation_feedback.flags.contains(base_acceleration)
            {
                message += ": feedback indicates base pipeline acceleration when it shouldn't";
                return Ok(TestStatus::fail(message));
            }

            if ndx == PIPELINE_NDX_USE_BLOBS && !param.no_cache && !creation_feedback.flags.contains(cache_hit) {
                message += "\nWarning: Cached pipeline case did not hit the cache";
                cached_pipeline_warning = true;
            }

            if creation_feedback.duration == 0 {
                message += "\nWarning: Pipeline creation feedback reports duration spent creating a pipeline was zero nanoseconds\n";
                duration_zero_warning = true;
            }

            message += "\n";

            message += &format!(
                "\t\t Hit cache ? \t\t\t{}\n",
                yes_no(creation_feedback.flags.contains(cache_hit))
            );
            message += &format!(
                "\t\t Base Pipeline Acceleration ? \t{}\n",
                yes_no(creation_feedback.flags.contains(base_acceleration))
            );
            message += &format!("\t\t Duration (ns): \t\t{}\n", creation_feedback.duration);

            message += "\t Compute Stage\n";
        }

        if !stage_feedback.flags.contains(vk::PipelineCreationFeedbackFlags::VALID) {
            if !stage_feedback.flags.is_empty() {
                return Ok(TestStatus::fail(format!(
                    "{}: Creation feedback is not valid for compute stage but there are other flags written",
                    case_str(ndx)
                )));
            }
            message += "\t\t Pipeline Creation Feedback data is not valid\n";
        } else {
            if param.no_cache && stage_feedback.flags.contains(cache_hit) {
                return Ok(TestStatus::fail(format!(
                    "{}: feedback indicates pipeline compute stage hit cache when it shouldn't",
                    case_str(ndx)
                )));
            }

            if ndx == PIPELINE_NDX_USE_BLOBS && !param.no_cache && !stage_feedback.flags.contains(cache_hit) {
                message += "Warning: pipeline stage did not hit the cache\n";
                cached_pipeline_warning = true;
            }
            if cached_pipeline_warning && stage_feedback.flags.contains(cache_hit) {
                // The warning is only set when neither the pipeline nor its stages hit the cache; if any did, it is disabled.
                cached_pipeline_warning = false;
            }

            message += &format!(
                "\t\t Hit cache ? \t\t\t{}\n",
                yes_no(stage_feedback.flags.contains(cache_hit))
            );
            message += &format!(
                "\t\t Base Pipeline Acceleration ? \t{}\n",
                yes_no(stage_feedback.flags.contains(base_acceleration))
            );
            message += &format!("\t\t Duration (ns): \t\t{}\n", stage_feedback.duration);
        }

        log::info!("{message}");
    }

    final_status(cached_pipeline_warning, duration_zero_warning)
}

fn add_case(group: &mut TestCaseGroup, param: TestParam) {
    group.add_child(Box::new(CreationFeedbackCase {
        name: param.generate_test_name(),
        param,
    }) as Box<dyn TestCase>);
}

/// `createCreationFeedbackTests` for the monolithic construction type: `createTestsInternal` with `TestMode::CACHE`.
pub fn create_creation_feedback_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("creation_feedback");

    // Test pipeline creation feedback with graphics pipeline.
    {
        let mut graphics_tests = TestCaseGroup::new("graphics_tests");

        // (stages, noCache, delayedDestroy, zeroOutFeedbackCount)
        let test_params = [
            TestParam::new(Stages::VertFrag, false, false, false),
            TestParam::new(Stages::VertGeomFrag, false, false, false),
            TestParam::new(Stages::VertTessFrag, false, false, false),
            TestParam::new(Stages::VertFrag, true, false, false),
            TestParam::new(Stages::VertFrag, true, false, true),
            TestParam::new(Stages::VertGeomFrag, true, false, false),
            TestParam::new(Stages::VertTessFrag, true, false, false),
            TestParam::new(Stages::VertFrag, false, true, false),
            TestParam::new(Stages::VertGeomFrag, false, true, false),
            TestParam::new(Stages::VertTessFrag, false, true, false),
        ];

        for param in test_params {
            add_case(&mut graphics_tests, param);
        }

        main_group.add_child(graphics_tests);
    }

    // Compute Pipeline Tests
    {
        let mut compute_tests = TestCaseGroup::new("compute_tests");

        let test_params = [
            TestParam::new(Stages::Compute, false, false, false),
            TestParam::new(Stages::Compute, true, false, false),
            TestParam::new(Stages::Compute, false, true, false),
        ];

        for param in test_params {
            add_case(&mut compute_tests, param);
        }

        main_group.add_child(compute_tests);
    }

    main_group
}

/// `addPipelineBinaryCreationFeedbackTests` for the monolithic construction type: `createTestsInternal` with `TestMode::BINARY`
/// inside a `creation_feedback` group of upstream's `pipeline_binary` group.
pub(super) fn add_pipeline_binary_creation_feedback_tests(binary_tests: &mut TestCaseGroup) {
    let mut feedback_group = TestCaseGroup::new("creation_feedback");

    // Test pipeline creation feedback with graphics pipeline; the pipeline binary cases are the ones with the cache disabled.
    {
        let mut graphics_tests = TestCaseGroup::new("graphics_tests");

        // (stages, noCache, delayedDestroy, zeroOutFeedbackCount), `disableCacheInDelayedDestroy` being true
        let test_params = [
            TestParam::new_binary(Stages::VertFrag, true, false, false),
            TestParam::new_binary(Stages::VertFrag, true, false, true),
            TestParam::new_binary(Stages::VertGeomFrag, true, false, false),
            TestParam::new_binary(Stages::VertTessFrag, true, false, false),
            TestParam::new_binary(Stages::VertFrag, true, true, false),
            TestParam::new_binary(Stages::VertGeomFrag, true, true, false),
            TestParam::new_binary(Stages::VertTessFrag, true, true, false),
        ];

        for param in test_params {
            add_case(&mut graphics_tests, param);
        }

        feedback_group.add_child(graphics_tests);
    }

    // Compute Pipeline Tests; the ones with the cache disabled are skipped
    {
        let mut compute_tests = TestCaseGroup::new("compute_tests");

        let test_params = [
            TestParam::new_binary(Stages::Compute, false, false, false),
            TestParam::new_binary(Stages::Compute, false, true, false),
        ];

        for param in test_params {
            add_case(&mut compute_tests, param);
        }

        feedback_group.add_child(compute_tests);
    }

    binary_tests.add_child(feedback_group);
}
