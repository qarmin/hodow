// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp (`makeComputeTest`, `makeComputeOrMeshTestRequiredSubgroupSize`)
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsArithmeticTests.cpp (`supportedCheck`, `test`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader of every case writes one verdict per invocation and the host only checks
// that all of them are the expected value, so the families share this one runner; what differs between them is the `spec` of the case
// (see `scripts/gen_subgroups_compute_manifest.py`): the feature the device has to report, the format, whether the required subgroup size
// variant runs, the expected verdict and the input buffers. The local size is a specialization constant (ids 0, 1, 2), set per pipeline.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;

use super::utils::{
    BindingType, BuiltinVar, MAX_SUPPORTED_SUBGROUP_SIZE, Scalar, SsboData, VecType, check_builtin_var,
    check_compute_or_mesh, initialize_memory, is_8bit_ubo_storage_supported, is_16bit_ubo_storage_supported,
    is_format_supported_for_device, is_subgroup_broadcast_dynamic_id_supported,
    is_subgroup_feature_supported_for_device, is_subgroup_rotate_spec_version_valid, is_subgroup_supported,
    subgroup_properties, subgroup_rotate_features, subgroup_size_control_features, subgroup_size_control_properties,
    supported_check_compute_shader,
};
use crate::generated::shaders::subgroups_compute::ALL_SUBGROUP_CASE;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one test case of the compute stage of a subgroup family.
#[derive(Clone, Copy)]
pub struct SubgroupCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// The `rss=` of a spec: no required subgroup size, every size the device offers in turn, or one given size.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum RequiredSize {
    None,
    Every,
    Fixed(u32),
}

/// The fields of a case spec.
pub(super) struct Params {
    pub(super) feature: Option<vk::SubgroupFeatureFlags>,
    pub(super) requirements: Vec<&'static str>,
    pub(super) vec_type: VecType,
    pub(super) required_subgroup_size: RequiredSize,
    pub(super) check: u32,
    pub(super) inputs: Vec<SsboData>,
    pub(super) check_input: Option<usize>,
    pub(super) result_components: u64,
    pub(super) builtin: Option<BuiltinVar>,
    pub(super) size_control: Option<super::size_control_tests::SizeControl>,
}

pub(super) fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("subgroup spec without {key}"))
}

pub(super) fn parse(spec: &str) -> Params {
    let feature = match field(spec, "feature") {
        "none" => None,
        "basic" => Some(vk::SubgroupFeatureFlags::BASIC),
        "vote" => Some(vk::SubgroupFeatureFlags::VOTE),
        "arithmetic" => Some(vk::SubgroupFeatureFlags::ARITHMETIC),
        "ballot" => Some(vk::SubgroupFeatureFlags::BALLOT),
        "shuffle" => Some(vk::SubgroupFeatureFlags::SHUFFLE),
        "shuffle_relative" => Some(vk::SubgroupFeatureFlags::SHUFFLE_RELATIVE),
        "clustered" => Some(vk::SubgroupFeatureFlags::CLUSTERED),
        "quad" => Some(vk::SubgroupFeatureFlags::QUAD),
        "partitioned" => Some(vk::SubgroupFeatureFlags::PARTITIONED_EXT),
        "rotate" => Some(vk::SubgroupFeatureFlags::ROTATE),
        "rotate_clustered" => Some(vk::SubgroupFeatureFlags::ROTATE_CLUSTERED),
        other => panic!("subgroup spec with an unknown feature {other}"),
    };
    let requirements = field(spec, "req")
        .split(',')
        .filter(|req| !req.is_empty())
        .map(|req| match req {
            "dynid" => "dynid",
            "rotate" => "rotate",
            "rotate_clustered" => "rotate_clustered",
            "arb" => "arb",
            "arbvote" => "arbvote",
            other => panic!("subgroup spec with an unknown requirement {other}"),
        });
    let check = field(spec, "check");
    Params {
        feature,
        requirements: requirements.collect(),
        vec_type: VecType {
            scalar: Scalar::from_token(field(spec, "type")),
            components: field(spec, "comps").parse().expect("component count"),
        },
        required_subgroup_size: match field(spec, "rss") {
            "0" => RequiredSize::None,
            "1" => RequiredSize::Every,
            fixed => RequiredSize::Fixed(
                fixed
                    .strip_prefix('f')
                    .and_then(|size| size.parse().ok())
                    .unwrap_or_else(|| panic!("subgroup spec with a bad rss {fixed}")),
            ),
        },
        check: u32::from_str_radix(check.trim_start_matches("0x"), 16).expect("check value"),
        inputs: field(spec, "inputs")
            .split('|')
            .filter(|entry| !entry.is_empty())
            .map(SsboData::parse)
            .collect(),
        check_input: spec
            .split(';')
            .find_map(|entry| entry.strip_prefix("checkin="))
            .map(|index| index.parse().expect("checkin index")),
        result_components: spec
            .split(';')
            .find_map(|entry| entry.strip_prefix("rescomps="))
            .map_or(1, |count| count.parse().expect("result component count")),
        builtin: spec
            .split(';')
            .find_map(|entry| entry.strip_prefix("builtin="))
            .map(BuiltinVar::from_token),
        size_control: spec
            .split(';')
            .find_map(|entry| entry.strip_prefix("sc="))
            .map(super::size_control_tests::SizeControl::parse),
    }
}

struct SubgroupComputeCase {
    name: String,
    spec: &'static str,
    programs: BinaryCollection,
}

impl TestCase for SubgroupComputeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `supportedCheck` of the families, for the compute stage.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = parse(self.spec);
        if let Some(size_control) = &params.size_control {
            return size_control.check_support(context, vk::ShaderStageFlags::COMPUTE);
        }
        check_support_common(context, self.spec, &params, vk::ShaderStageFlags::COMPUTE)?;
        supported_check_compute_shader(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SubgroupComputeInstance {
            context,
            params: parse(self.spec),
        })
    }
}

/// The parts of `supportedCheck` that every stage shares: the feature, the format, the requirements and the required subgroup size.
pub(super) fn check_support_common(
    context: &Context<'_>,
    spec: &str,
    params: &Params,
    stage: vk::ShaderStageFlags,
) -> Result<(), TestError> {
    if !is_subgroup_supported(context) {
        return Err(TestError::NotSupported(
            "Subgroup operations are not supported".to_string(),
        ));
    }

    if let Some(feature) = params.feature
        && !is_subgroup_feature_supported_for_device(context, feature)
    {
        return Err(TestError::NotSupported(format!(
            "Device does not support subgroup {} operations",
            field(spec, "feature")
        )));
    }

    for requirement in &params.requirements {
        match *requirement {
            "dynid" => {
                if !is_subgroup_broadcast_dynamic_id_supported(context) {
                    return Err(TestError::NotSupported(
                        "Device does not support SubgroupBroadcastDynamicId".to_string(),
                    ));
                }
            }
            "rotate" | "rotate_clustered" => {
                let rotate = subgroup_rotate_features(context);
                if *requirement == "rotate" && rotate.shader_subgroup_rotate == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Device does not support shaderSubgroupRotate".to_string(),
                    ));
                }
                if *requirement == "rotate_clustered" && rotate.shader_subgroup_rotate_clustered == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Device does not support shaderSubgroupRotateClustered".to_string(),
                    ));
                }
                if !is_subgroup_rotate_spec_version_valid(context)? {
                    return Err(TestError::NotSupported(
                        "VK_KHR_shader_subgroup_rotate is version 1. Need version 2 or higher".to_string(),
                    ));
                }
            }
            "arb" => {
                context.require_device_functionality("VK_EXT_shader_subgroup_ballot")?;

                if context.get_device_features().shader_int64 == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Device does not support int64 data types".to_string(),
                    ));
                }
            }
            "arbvote" => context.require_device_functionality("VK_EXT_shader_subgroup_vote")?,
            _ => unreachable!("parse admits only the known requirements"),
        }
    }

    if !is_format_supported_for_device(context, params.vec_type)? {
        return Err(TestError::NotSupported(
            "Device does not support the specified format in subgroup operations".to_string(),
        ));
    }

    if params.inputs.first().is_some_and(SsboData::is_ubo) {
        if matches!(params.vec_type.scalar, Scalar::Int16 | Scalar::Uint16 | Scalar::Float16)
            && !is_16bit_ubo_storage_supported(context)
        {
            return Err(TestError::NotSupported(
                "Device does not support the specified format in subgroup operations".to_string(),
            ));
        }
        if matches!(params.vec_type.scalar, Scalar::Int8 | Scalar::Uint8) && !is_8bit_ubo_storage_supported(context) {
            return Err(TestError::NotSupported(
                "Device does not support the specified format in subgroup operations".to_string(),
            ));
        }
    }

    if params.required_subgroup_size != RequiredSize::None {
        context.require_device_functionality("VK_EXT_subgroup_size_control")?;

        let features = subgroup_size_control_features(context);
        let properties = subgroup_size_control_properties(context);

        if features.subgroup_size_control == vk::FALSE {
            return Err(TestError::NotSupported(
                "Device does not support varying subgroup sizes nor required subgroup size".to_string(),
            ));
        }

        if features.compute_full_subgroups == vk::FALSE {
            return Err(TestError::NotSupported(
                "Device does not support full subgroups in compute shaders".to_string(),
            ));
        }

        if let RequiredSize::Fixed(size) = params.required_subgroup_size
            && (size < properties.min_subgroup_size || size > properties.max_subgroup_size)
        {
            return Err(TestError::NotSupported("Unsupported subgroup size".to_string()));
        }

        if !properties.required_subgroup_size_stages.contains(stage) {
            return Err(TestError::NotSupported(
                "Required subgroup size is not supported for shader stage".to_string(),
            ));
        }
    }
    Ok(())
}

/// `test`'s handling of the required subgroup size, shared by the compute and the mesh runner.
pub(super) fn run_with_required_subgroup_size(
    context: &Context<'_>,
    params: &Params,
    kind: ComputeLike,
) -> TestOutcome {
    match params.required_subgroup_size {
        RequiredSize::None => return make_compute_or_mesh_test(context, params, 0, kind),
        RequiredSize::Fixed(size) => return make_compute_or_mesh_test(context, params, size, kind),
        RequiredSize::Every => {}
    }

    // According to the spec, requiredSubgroupSize must be a power-of-two integer.
    let properties = subgroup_size_control_properties(context);
    let mut size = properties.min_subgroup_size;
    while size <= properties.max_subgroup_size {
        let result = make_compute_or_mesh_test(context, params, size, kind)?;
        if result.code() != crate::tcu::TestResult::Pass {
            return Ok(result);
        }
        size *= 2;
    }

    Ok(TestStatus::pass("OK"))
}

struct SubgroupComputeInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for SubgroupComputeInstance<'_> {
    /// `test`, compute branch
    fn iterate(&mut self) -> TestOutcome {
        if let Some(size_control) = &self.params.size_control {
            return size_control.run_compute(self.context, &self.params);
        }
        run_with_required_subgroup_size(self.context, &self.params, ComputeLike::Compute)
    }
}

/// `makeComputePipeline`: the local size goes in through the specialization constants 0, 1 and 2.
fn make_compute_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    shader_module: vk::ShaderModule,
    flags: vk::PipelineCreateFlags,
    base_pipeline: vk::Pipeline,
    local_size: [u32; 3],
    required_subgroup_size: u32,
    stage_flags: vk::PipelineShaderStageCreateFlags,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entries = [
        vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 0,
            size: std::mem::size_of::<u32>(),
        },
        vk::SpecializationMapEntry {
            constant_id: 1,
            offset: std::mem::size_of::<u32>() as u32,
            size: std::mem::size_of::<u32>(),
        },
        vk::SpecializationMapEntry {
            constant_id: 2,
            offset: 2 * std::mem::size_of::<u32>() as u32,
            size: std::mem::size_of::<u32>(),
        },
    ];
    let info = vk::SpecializationInfo {
        map_entry_count: 3,
        map_entries: entries.as_ptr(),
        data_size: std::mem::size_of_val(&local_size),
        data: local_size.as_ptr().cast(),
    };
    let subgroup_size_info = vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO,
        next: std::ptr::null(),
        required_subgroup_size,
    };
    let stage = vk::PipelineShaderStageCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
        next: if required_subgroup_size != 0 {
            (&subgroup_size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast()
        } else {
            std::ptr::null()
        },
        flags: stage_flags,
        stage: vk::ShaderStageFlags::COMPUTE,
        module: shader_module,
        name: c"main".as_ptr().cast(),
        specialization_info: &info,
    };
    let create_info = vk::ComputePipelineCreateInfo {
        s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        stage,
        layout: pipeline_layout,
        base_pipeline_handle: base_pipeline,
        base_pipeline_index: -1,
    };

    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `ComputeLike`: what runs the test source, a compute shader or the task or mesh shader of a mesh pipeline.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum ComputeLike {
    Compute,
    Mesh,
}

/// The render pass of a mesh test: one subpass, no attachments (`makeRenderPass(vk, device)`).
fn make_empty_render_pass(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let subpass = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let info = vk::RenderPassCreateInfo::builder().subpasses(&subpass);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `makeMeshPipeline`: the optional task and the mesh stage, both with the local size specialized, over a 1x1 viewport. The required
/// subgroup size is on the task stage when there is one and on the mesh stage otherwise.
fn make_mesh_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    task_module: Option<vk::ShaderModule>,
    mesh_module: vk::ShaderModule,
    flags: vk::PipelineCreateFlags,
    base_pipeline: vk::Pipeline,
    local_size: [u32; 3],
    required_subgroup_size: u32,
    stage_flags: vk::PipelineShaderStageCreateFlags,
    render_pass: vk::RenderPass,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entries = [
        vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 0,
            size: std::mem::size_of::<u32>(),
        },
        vk::SpecializationMapEntry {
            constant_id: 1,
            offset: std::mem::size_of::<u32>() as u32,
            size: std::mem::size_of::<u32>(),
        },
        vk::SpecializationMapEntry {
            constant_id: 2,
            offset: 2 * std::mem::size_of::<u32>() as u32,
            size: std::mem::size_of::<u32>(),
        },
    ];
    let info = vk::SpecializationInfo {
        map_entry_count: 3,
        map_entries: entries.as_ptr(),
        data_size: std::mem::size_of_val(&local_size),
        data: local_size.as_ptr().cast(),
    };
    let subgroup_size_info = vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO,
        next: std::ptr::null(),
        required_subgroup_size,
    };
    let subgroup_size_chain: *const std::ffi::c_void = if required_subgroup_size != 0 {
        (&subgroup_size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast()
    } else {
        std::ptr::null()
    };
    let stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule, next: *const std::ffi::c_void| {
        vk::PipelineShaderStageCreateInfo {
            s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
            next,
            flags: stage_flags,
            stage,
            module,
            name: c"main".as_ptr().cast(),
            specialization_info: &info,
        }
    };

    let mut stages = Vec::with_capacity(2);
    if let Some(task) = task_module {
        stages.push(stage(vk::ShaderStageFlags::TASK_EXT, task, subgroup_size_chain));
    }
    stages.push(stage(
        vk::ShaderStageFlags::MESH_EXT,
        mesh_module,
        if task_module.is_none() {
            subgroup_size_chain
        } else {
            std::ptr::null()
        },
    ));

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: 1.0,
        height: 1.0,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, 1, 1)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder();
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().logic_op(vk::LogicOp::CLEAR);
    let create_info = vk::GraphicsPipelineCreateInfo::builder()
        .flags(flags)
        .stages(&stages)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0)
        .base_pipeline_handle(base_pipeline)
        .base_pipeline_index(-1);

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[create_info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// What `makeComputeOrMeshTestRequiredSubgroupSize` takes beyond `makeComputeOrMeshTest`: the dispatch, the local sizes, the stage flags of the pipeline and the check.
#[derive(Default)]
pub(super) struct RunOverrides<'a> {
    pub num_workgroups: Option<[u32; 3]>,
    pub local_sizes: Option<Vec<[u32; 3]>>,
    pub stage_flags: vk::PipelineShaderStageCreateFlags,
    /// The results, the number of workgroups, the local size and the subgroup size
    pub check: Option<&'a dyn Fn(&[u32], [u32; 3], [u32; 3], u32) -> bool>,
}

/// `makeComputeOrMeshTest`. `required_subgroup_size` is 0 for the plain run.
pub(super) fn make_compute_or_mesh_test(
    context: &Context<'_>,
    params: &Params,
    required_subgroup_size: u32,
    kind: ComputeLike,
) -> TestOutcome {
    make_compute_or_mesh_test_with(context, params, required_subgroup_size, kind, &RunOverrides::default())
}

/// `makeComputeOrMeshTestRequiredSubgroupSize`
pub(super) fn make_compute_or_mesh_test_with(
    context: &Context<'_>,
    params: &Params,
    required_subgroup_size: u32,
    kind: ComputeLike,
    overrides: &RunOverrides<'_>,
) -> TestOutcome {
    let vk = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();

    let num_workgroups = overrides.num_workgroups.unwrap_or([4u32, 2, 2]);
    let is_required_subgroup_size = required_subgroup_size != 0;
    let subgroup_size = if is_required_subgroup_size {
        required_subgroup_size
    } else {
        subgroup_properties(context).subgroup_size
    };

    let local_sizes_to_test: Vec<[u32; 3]> = overrides.local_sizes.clone().unwrap_or_else(|| {
        vec![
            [1, 1, 1],
            [subgroup_size, 1, 1],
            [1, subgroup_size, 1],
            [1, 1, subgroup_size],
            [32, 4, 1],
            [1, 4, 32],
            [3, 5, 7],
            [1, 1, 1], // Isn't used, just here to make double buffering checks easier
        ]
    });
    let local_sizes_to_test_count = local_sizes_to_test.len();

    let element_size = 4 * params.result_components; // getFormatSizeInBytes of the result format
    let max_subgroup_size = if is_required_subgroup_size {
        u64::from(
            subgroup_size_control_properties(context)
                .max_subgroup_size
                .max(MAX_SUPPORTED_SUBGROUP_SIZE),
        )
    } else {
        u64::from(MAX_SUPPORTED_SUBGROUP_SIZE)
    };
    let result_buffer_size = max_subgroup_size * max_subgroup_size * max_subgroup_size;
    let result_buffer_size_in_bytes = result_buffer_size * element_size;
    let result_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(result_buffer_size_in_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let mut input_buffers: Vec<Option<BufferWithMemory>> = Vec::with_capacity(params.inputs.len());
    let mut input_images: Vec<Option<(ImageWithMemory, Unique<vk::ImageView>)>> =
        Vec::with_capacity(params.inputs.len());
    let image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    for input in &params.inputs {
        if input.binding_type == BindingType::Image {
            let image_info = make_image_create_info(
                IVec2::new(input.num_elements as i32, 1),
                vk::Format::R32_UINT,
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            );
            let image = ImageWithMemory::new(vk, allocator, image_info, MemoryRequirement::ANY)?;
            let view = make_image_view(
                vk,
                image.get(),
                vk::ImageViewType::_2D,
                vk::Format::R32_UINT,
                image_subresource_range,
            )?;
            input_images.push(Some((image, view)));
            input_buffers.push(None);
            continue;
        }
        input_images.push(None);
        let usage = if input.is_ubo() {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(input.size_in_bytes(), usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        initialize_memory(context, buffer.get_allocation(), input)?;
        input_buffers.push(Some(buffer));
    }

    let descriptor_type = |input: &SsboData| {
        if input.binding_type == BindingType::Image {
            vk::DescriptorType::STORAGE_IMAGE
        } else if input.is_ubo() {
            vk::DescriptorType::UNIFORM_BUFFER
        } else {
            vk::DescriptorType::STORAGE_BUFFER
        }
    };

    let shader_stage_flags = if kind == ComputeLike::Compute {
        vk::ShaderStageFlags::COMPUTE
    } else {
        vk::ShaderStageFlags::MESH_EXT | vk::ShaderStageFlags::TASK_EXT
    };
    let mut layout_builder =
        DescriptorSetLayoutBuilder::new().add_single_binding(vk::DescriptorType::STORAGE_BUFFER, shader_stage_flags);
    for input in &params.inputs {
        layout_builder = layout_builder.add_single_binding(descriptor_type(input), shader_stage_flags);
    }
    let descriptor_set_layout = layout_builder.build(vk)?;

    let binaries = context.get_binary_collection();
    let comp_shader = if kind == ComputeLike::Compute {
        Some(create_shader_module(vk, binaries.get("comp")?)?)
    } else {
        None
    };
    let mesh_shader = if kind == ComputeLike::Mesh {
        Some(create_shader_module(vk, binaries.get("mesh")?)?)
    } else {
        None
    };
    let task_shader = if kind == ComputeLike::Mesh && binaries.contains("task") {
        Some(create_shader_module(vk, binaries.get("task")?)?)
    } else {
        None
    };
    let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;

    let mut pool_builder = DescriptorPoolBuilder::new().add_type(vk::DescriptorType::STORAGE_BUFFER, 1);
    for input in &params.inputs {
        pool_builder = pool_builder.add_type(descriptor_type(input), 1);
    }
    let descriptor_pool = pool_builder.build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

    let result_descriptor_info = make_descriptor_buffer_info(result_buffer.get(), 0, result_buffer_size_in_bytes);
    let input_infos: Vec<vk::DescriptorBufferInfo> = params
        .inputs
        .iter()
        .zip(&input_buffers)
        .map(|(input, buffer)| match buffer {
            Some(buffer) => make_descriptor_buffer_info(buffer.get(), 0, input.size_in_bytes()),
            None => make_descriptor_buffer_info(vk::Buffer::null(), 0, 0),
        })
        .collect();

    let mut update_builder = DescriptorSetUpdateBuilder::new().write_single(
        *descriptor_set,
        Location::binding(0),
        vk::DescriptorType::STORAGE_BUFFER,
        &result_descriptor_info,
    );
    for (i, input) in params.inputs.iter().enumerate() {
        if input.binding_type == BindingType::Image {
            continue;
        }
        update_builder = update_builder.write_single(
            *descriptor_set,
            Location::binding(i as u32 + 1),
            descriptor_type(input),
            &input_infos[i],
        );
    }
    update_builder.update(vk);

    let image_infos: Vec<(u32, [vk::DescriptorImageInfo; 1])> = input_images
        .iter()
        .enumerate()
        .filter_map(|(i, image)| {
            image.as_ref().map(|(_, view)| {
                (
                    i as u32 + 1,
                    [vk::DescriptorImageInfo {
                        sampler: vk::Sampler::null(),
                        image_view: **view,
                        image_layout: vk::ImageLayout::GENERAL,
                    }],
                )
            })
        })
        .collect();
    let image_writes: Vec<vk::WriteDescriptorSet> = image_infos
        .iter()
        .map(|(binding, info)| {
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(*binding)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(info)
                .build()
        })
        .collect();
    if !image_writes.is_empty() {
        unsafe { vk.update_descriptor_sets(&image_writes, &[] as &[vk::CopyDescriptorSet]) };
    }

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = cmd_buffer.get();

    let image_barriers: Vec<vk::ImageMemoryBarrier> = input_images
        .iter()
        .flatten()
        .map(|(image, _)| {
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                image.get(),
                image_subresource_range,
            )
        })
        .collect();
    if !image_barriers.is_empty() {
        begin_command_buffer(vk, cmd_buffer)?;
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;
    }

    let mut total_iterations = 0u32;
    let mut failed_iterations = 0u32;

    let render_pass = if kind == ComputeLike::Mesh {
        Some(make_empty_render_pass(vk)?)
    } else {
        None
    };
    let framebuffer = match &render_pass {
        Some(render_pass) => Some(make_framebuffer(vk, **render_pass, &[], 1, 1, 1)?),
        None => None,
    };

    let make_pipeline = |flags: vk::PipelineCreateFlags, base: vk::Pipeline, local_size: [u32; 3]| match (
        &comp_shader,
        &mesh_shader,
        &render_pass,
    ) {
        (Some(comp), _, _) => make_compute_pipeline(
            vk,
            *pipeline_layout,
            **comp,
            flags,
            base,
            local_size,
            required_subgroup_size,
            overrides.stage_flags,
        ),
        (None, Some(mesh), Some(render_pass)) => make_mesh_pipeline(
            vk,
            *pipeline_layout,
            task_shader.as_ref().map(|task| **task),
            **mesh,
            flags,
            base,
            local_size,
            required_subgroup_size,
            overrides.stage_flags,
            **render_pass,
        ),
        _ => unreachable!("a compute or a mesh test has the shaders and the render pass it needs"),
    };

    let mut pipelines = Vec::with_capacity(local_sizes_to_test_count);
    pipelines.push(make_pipeline(
        vk::PipelineCreateFlags::ALLOW_DERIVATIVES,
        vk::Pipeline::null(),
        local_sizes_to_test[0],
    )?);

    for local_size in &local_sizes_to_test[1..local_sizes_to_test_count - 1] {
        let base = *pipelines[0];
        pipelines.push(make_pipeline(vk::PipelineCreateFlags::DERIVATIVE, base, *local_size)?);
    }

    for index in 0..local_sizes_to_test_count - 1 {
        // we are running one test
        total_iterations += 1;

        let pipeline_bind_point = if kind == ComputeLike::Compute {
            vk::PipelineBindPoint::COMPUTE
        } else {
            vk::PipelineBindPoint::GRAPHICS
        };
        let pipeline_stage = if kind == ComputeLike::Compute {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            vk::PipelineStageFlags::TASK_SHADER_EXT | vk::PipelineStageFlags::MESH_SHADER_EXT
        };

        begin_command_buffer(vk, cmd_buffer)?;
        if let (Some(render_pass), Some(framebuffer)) = (&render_pass, &framebuffer) {
            begin_render_pass(
                vk,
                cmd_buffer,
                **render_pass,
                **framebuffer,
                make_rect_2d(0, 0, 1, 1),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: [0.0; 4] },
                },
            );
        }
        unsafe {
            vk.cmd_bind_pipeline(cmd_buffer, pipeline_bind_point, *pipelines[index]);
            vk.cmd_bind_descriptor_sets(
                cmd_buffer,
                pipeline_bind_point,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[],
            );
            if kind == ComputeLike::Compute {
                vk.cmd_dispatch(cmd_buffer, num_workgroups[0], num_workgroups[1], num_workgroups[2]);
            } else {
                vk.cmd_draw_mesh_tasks_ext(cmd_buffer, num_workgroups[0], num_workgroups[1], num_workgroups[2]);
            }
        }
        if render_pass.is_some() {
            end_render_pass(vk, cmd_buffer);
        }
        unsafe {
            // Make shader writes available.
            let post_shader_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                pipeline_stage,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[post_shader_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, cmd_buffer)?;

        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        invalidate_alloc(vk, result_buffer.get_allocation())?;
        // SAFETY: the result buffer holds `result_buffer_size` verdicts and is mapped in full.
        let results = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                (result_buffer_size * params.result_components) as usize,
            )
        };

        for buffer in input_buffers.iter().flatten() {
            invalidate_alloc(vk, buffer.get_allocation())?;
        }

        let reference = match params.check_input {
            // The check of the barrier tests reads the value the shader was given from the input buffer.
            Some(input) => {
                let buffer = input_buffers[input]
                    .as_ref()
                    .expect("the input a check reads its reference from is a buffer");
                // SAFETY: the input holds at least one 32 bit value and is mapped in full.
                unsafe { buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>().read() }
            }
            None => params.check,
        };

        let passed = match (overrides.check, params.builtin) {
            (Some(check), _) => check(results, num_workgroups, local_sizes_to_test[index], subgroup_size),
            (None, Some(builtin)) => check_builtin_var(
                builtin,
                results,
                num_workgroups,
                local_sizes_to_test[index],
                subgroup_size,
            ),
            (None, None) => check_compute_or_mesh(results, num_workgroups, local_sizes_to_test[index], reference),
        };
        if !passed {
            failed_iterations += 1;
        }
    }

    if failed_iterations > 0 {
        return Ok(TestStatus::fail(format!(
            "Failed! ({} / {} values passed)",
            total_iterations.saturating_sub(failed_iterations),
            total_iterations
        )));
    }

    Ok(TestStatus::pass("OK"))
}

/// The cases of the compute stage of the ported families, as the groups of their path below `subgroups` and the case.
pub fn create_compute_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_SUBGROUP_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            segments.remove(0);
            (
                segments,
                Box::new(SubgroupComputeCase {
                    name: leaf.to_string(),
                    spec: case.spec,
                    programs: case.programs,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
