// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectCreateUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `addBasicShaderObjectShaders` is the `SHADER_OBJECT_BASIC` program set of
// `shaders/manifest/shader_object_create.toml`.
//
// Helpers every shader object test shares.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtAttachmentFeedbackLoopDynamicStateExtensionDeviceCommands, ExtColorWriteEnableExtensionDeviceCommands,
    ExtDiscardRectanglesExtensionDeviceCommands, ExtSampleLocationsExtensionDeviceCommands,
    ExtShaderObjectExtensionDeviceCommands, Handle, InstanceV1_1, KhrFragmentShadingRateExtensionDeviceCommands,
    KhrLineRasterizationExtensionDeviceCommands, NvClipSpaceWScalingExtensionDeviceCommands,
    NvFragmentShadingRateEnumsExtensionDeviceCommands, NvScissorExclusiveExtensionDeviceCommands,
};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::programs::ProgramBinary;
use crate::vkt::Context;

/// `vk::getShaderName`
pub fn get_shader_name(stage: vk::ShaderStageFlags) -> &'static str {
    if stage == vk::ShaderStageFlags::VERTEX {
        "vert"
    } else if stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
        "tesc"
    } else if stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
        "tese"
    } else if stage == vk::ShaderStageFlags::GEOMETRY {
        "geom"
    } else if stage == vk::ShaderStageFlags::FRAGMENT {
        "frag"
    } else if stage == vk::ShaderStageFlags::COMPUTE {
        "comp"
    } else if stage == vk::ShaderStageFlags::MESH_EXT {
        "mesh"
    } else if stage == vk::ShaderStageFlags::TASK_EXT {
        "task"
    } else {
        debug_assert!(false, "unexpected stage");
        ""
    }
}

/// `vk::getShaderObjectNextStages`
pub fn get_shader_object_next_stages(
    shader_stage: vk::ShaderStageFlags,
    tessellation_shader_feature: bool,
    geometry_shader_feature: bool,
) -> vk::ShaderStageFlags {
    if shader_stage == vk::ShaderStageFlags::VERTEX {
        let mut flags = vk::ShaderStageFlags::FRAGMENT;
        if tessellation_shader_feature {
            flags |= vk::ShaderStageFlags::TESSELLATION_CONTROL;
        }
        if geometry_shader_feature {
            flags |= vk::ShaderStageFlags::GEOMETRY;
        }
        flags
    } else if shader_stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
        vk::ShaderStageFlags::TESSELLATION_EVALUATION
    } else if shader_stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
        let mut flags = vk::ShaderStageFlags::FRAGMENT;
        if geometry_shader_feature {
            flags |= vk::ShaderStageFlags::GEOMETRY;
        }
        flags
    } else if shader_stage == vk::ShaderStageFlags::GEOMETRY {
        vk::ShaderStageFlags::FRAGMENT
    } else if shader_stage == vk::ShaderStageFlags::TASK_EXT {
        vk::ShaderStageFlags::MESH_EXT
    } else if shader_stage == vk::ShaderStageFlags::MESH_EXT {
        vk::ShaderStageFlags::FRAGMENT
    } else {
        vk::ShaderStageFlags::empty()
    }
}

/// A `VkShaderEXT` that is destroyed when dropped (`Move<VkShaderEXT>`).
pub struct ShaderObject<'a> {
    device: &'a Device,
    handle: vk::ShaderEXT,
}

impl<'a> ShaderObject<'a> {
    pub fn new(device: &'a Device, handle: vk::ShaderEXT) -> Self {
        Self { device, handle }
    }

    pub fn get(&self) -> vk::ShaderEXT {
        self.handle
    }
}

impl Drop for ShaderObject<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_shader_ext(self.handle, None) };
    }
}

/// `ShaderCreateInfoEXT` over SPIR-V (or a binary) with `main` as the entry point; the descriptor set layout slice has to outlive the
/// call it is passed to.
pub fn shader_create_info(
    flags: vk::ShaderCreateFlagsEXT,
    stage: vk::ShaderStageFlags,
    next_stage: vk::ShaderStageFlags,
    code_type: vk::ShaderCodeTypeEXT,
    code_size: usize,
    code: *const std::ffi::c_void,
    set_layouts: &[vk::DescriptorSetLayout],
    push_constant_ranges: &[vk::PushConstantRange],
) -> vk::ShaderCreateInfoEXT {
    vk::ShaderCreateInfoEXT {
        s_type: vk::StructureType::SHADER_CREATE_INFO_EXT,
        next: std::ptr::null(),
        flags,
        stage,
        next_stage,
        code_type,
        code_size,
        code,
        name: c"main".as_ptr(),
        set_layout_count: set_layouts.len() as u32,
        set_layouts: if set_layouts.is_empty() {
            std::ptr::null()
        } else {
            set_layouts.as_ptr()
        },
        push_constant_range_count: push_constant_ranges.len() as u32,
        push_constant_ranges: if push_constant_ranges.is_empty() {
            std::ptr::null()
        } else {
            push_constant_ranges.as_ptr()
        },
        specialization_info: std::ptr::null(),
    }
}

/// `vk::makeShaderCreateInfo` - a SPIR-V shader with a descriptor set layout and a push constant range when given.
pub fn make_shader_create_info(
    stage: vk::ShaderStageFlags,
    program_binary: &ProgramBinary,
    tessellation_shader_feature: bool,
    geometry_shader_feature: bool,
    descriptor_set_layout: Option<&vk::DescriptorSetLayout>,
    push_constant_range: Option<&vk::PushConstantRange>,
) -> vk::ShaderCreateInfoEXT {
    shader_create_info(
        vk::ShaderCreateFlagsEXT::empty(),
        stage,
        get_shader_object_next_stages(stage, tessellation_shader_feature, geometry_shader_feature),
        vk::ShaderCodeTypeEXT::SPIRV,
        std::mem::size_of_val(program_binary.spirv),
        program_binary.spirv.as_ptr().cast(),
        descriptor_set_layout.map(std::slice::from_ref).unwrap_or(&[]),
        push_constant_range.map(std::slice::from_ref).unwrap_or(&[]),
    )
}

/// `vk::createShader` - one shader, a failure is the test's failure.
pub fn create_shader<'a>(
    device: &'a Device,
    create_info: &vk::ShaderCreateInfoEXT,
) -> Result<ShaderObject<'a>, TestError> {
    let (shaders, _) =
        unsafe { device.create_shaders_ext(std::slice::from_ref(create_info), None) }.vk_check("vkCreateShadersEXT")?;
    Ok(ShaderObject::new(device, shaders[0]))
}

/// `vk::createShaderFromBinary`
pub fn create_shader_from_binary<'a>(
    device: &'a Device,
    shader_stage: vk::ShaderStageFlags,
    code: &[u8],
    tessellation_shader_feature: bool,
    geometry_shader_feature: bool,
    descriptor_set_layout: Option<vk::DescriptorSetLayout>,
) -> Result<ShaderObject<'a>, TestError> {
    let layouts: Vec<vk::DescriptorSetLayout> = descriptor_set_layout.into_iter().collect();
    let create_info = shader_create_info(
        vk::ShaderCreateFlagsEXT::empty(),
        shader_stage,
        get_shader_object_next_stages(shader_stage, tessellation_shader_feature, geometry_shader_feature),
        vk::ShaderCodeTypeEXT::BINARY,
        code.len(),
        code.as_ptr().cast(),
        &layouts,
        &[],
    );

    create_shader(device, &create_info)
}

/// `vkGetShaderBinaryDataEXT` as upstream's two calls (size, then data).
pub fn get_shader_binary_data(device: &Device, shader: vk::ShaderEXT) -> Result<Vec<u8>, TestError> {
    unsafe { device.get_shader_binary_data_ext(shader) }.vk_check("vkGetShaderBinaryDataEXT")
}

/// `vkCreateShadersEXT` with the handles left to the caller, who pre-fills `shaders` and reads them back whatever the result was.
pub fn create_shaders_raw(
    device: &Device,
    create_infos: &[vk::ShaderCreateInfoEXT],
    shaders: &mut [vk::ShaderEXT],
) -> vk::Result {
    debug_assert!(create_infos.len() == shaders.len());
    unsafe {
        (device.commands().create_shaders_ext)(
            device.handle(),
            create_infos.len() as u32,
            create_infos.as_ptr(),
            std::ptr::null(),
            shaders.as_mut_ptr(),
        )
    }
}

/// `Context::getMeshShaderFeaturesEXT`
pub fn get_mesh_shader_features(context: &Context<'_>) -> vk::PhysicalDeviceMeshShaderFeaturesEXT {
    let mut mesh_features = vk::PhysicalDeviceMeshShaderFeaturesEXT::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut mesh_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    mesh_features
}

fn extension_enabled(extensions: &[String], name: &str) -> bool {
    extensions.iter().any(|extension| extension == name)
}

/// `vk::setDefaultShaderObjectDynamicStates`; `extensions` is what the device was created with.
#[allow(clippy::too_many_arguments)]
pub fn set_default_shader_object_dynamic_states(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    extensions: &[String],
    topology: vk::PrimitiveTopology,
    mesh_shader: bool,
    set_viewport: bool,
    width: u32,
    height: u32,
) {
    let enabled = |name: &str| extension_enabled(extensions, name);
    let viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: width as f32,
        height: height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    };
    let scissor = vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D { width, height },
    };
    let combiner_ops = [
        vk::FragmentShadingRateCombinerOpKHR::KEEP,
        vk::FragmentShadingRateCombinerOpKHR::KEEP,
    ];

    unsafe {
        if set_viewport {
            device.cmd_set_viewport(cmd_buffer, 0, &[viewport]);
        }
        device.cmd_set_viewport_with_count_ext(cmd_buffer, &[viewport]);
        if set_viewport {
            device.cmd_set_scissor(cmd_buffer, 0, &[scissor]);
        }
        device.cmd_set_scissor_with_count_ext(cmd_buffer, &[scissor]);
        device.cmd_set_line_width(cmd_buffer, 1.0);
        device.cmd_set_depth_bias(cmd_buffer, 1.0, 1.0, 1.0);
        device.cmd_set_blend_constants(cmd_buffer, [1.0, 1.0, 1.0, 1.0]);
        device.cmd_set_depth_bounds(cmd_buffer, 0.0, 1.0);
        device.cmd_set_stencil_compare_mask(cmd_buffer, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFFFF_FFFF);
        device.cmd_set_stencil_write_mask(cmd_buffer, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFFFF_FFFF);
        device.cmd_set_stencil_reference(cmd_buffer, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFFFF_FFFF);
        device.cmd_bind_vertex_buffers2_ext(cmd_buffer, 0, &[], &[], &[], &[]);
        device.cmd_set_cull_mode_ext(cmd_buffer, vk::CullModeFlags::NONE);
        device.cmd_set_depth_bounds_test_enable_ext(cmd_buffer, false);
        device.cmd_set_depth_compare_op_ext(cmd_buffer, vk::CompareOp::NEVER);
        device.cmd_set_depth_test_enable_ext(cmd_buffer, false);
        device.cmd_set_depth_write_enable_ext(cmd_buffer, false);
        device.cmd_set_front_face_ext(cmd_buffer, vk::FrontFace::CLOCKWISE);
        if !mesh_shader {
            device.cmd_set_primitive_topology_ext(cmd_buffer, topology);
        }
        device.cmd_set_stencil_op_ext(
            cmd_buffer,
            vk::StencilFaceFlags::FRONT_AND_BACK,
            vk::StencilOp::KEEP,
            vk::StencilOp::KEEP,
            vk::StencilOp::KEEP,
            vk::CompareOp::NEVER,
        );
        device.cmd_set_stencil_test_enable_ext(cmd_buffer, false);
        device.cmd_set_depth_bias_enable_ext(cmd_buffer, false);
        if !mesh_shader {
            device.cmd_set_primitive_restart_enable_ext(cmd_buffer, false);
        }
        device.cmd_set_rasterizer_discard_enable_ext(cmd_buffer, false);
        if !mesh_shader && (enabled("VK_EXT_shader_object") || enabled("VK_EXT_vertex_input_dynamic_state")) {
            device.cmd_set_vertex_input_ext(
                cmd_buffer,
                &[] as &[vk::VertexInputBindingDescription2EXT],
                &[] as &[vk::VertexInputAttributeDescription2EXT],
            );
        }
        device.cmd_set_logic_op_ext(cmd_buffer, vk::LogicOp::AND);
        if !mesh_shader {
            device.cmd_set_patch_control_points_ext(cmd_buffer, 4);
        }
        device.cmd_set_tessellation_domain_origin_ext(cmd_buffer, vk::TessellationDomainOrigin::UPPER_LEFT);
        device.cmd_set_depth_clamp_enable_ext(cmd_buffer, false);
        device.cmd_set_polygon_mode_ext(cmd_buffer, vk::PolygonMode::FILL);
        device.cmd_set_rasterization_samples_ext(cmd_buffer, vk::SampleCountFlags::_1);
        let sample_mask: vk::SampleMask = 0xFFFF_FFFF;
        device.cmd_set_sample_mask_ext(cmd_buffer, vk::SampleCountFlags::_1, Some(&sample_mask));
        device.cmd_set_alpha_to_coverage_enable_ext(cmd_buffer, false);
        device.cmd_set_alpha_to_one_enable_ext(cmd_buffer, false);
        device.cmd_set_logic_op_enable_ext(cmd_buffer, false);
        device.cmd_set_color_blend_enable_ext(cmd_buffer, 0, &[vk::FALSE]);
        let color_blend_equation = vk::ColorBlendEquationEXT {
            src_color_blend_factor: vk::BlendFactor::ONE,
            dst_color_blend_factor: vk::BlendFactor::ONE,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ONE,
            dst_alpha_blend_factor: vk::BlendFactor::ONE,
            alpha_blend_op: vk::BlendOp::ADD,
        };
        device.cmd_set_color_blend_equation_ext(cmd_buffer, 0, &[color_blend_equation]);
        let color_write_mask = vk::ColorComponentFlags::R
            | vk::ColorComponentFlags::G
            | vk::ColorComponentFlags::B
            | vk::ColorComponentFlags::A;
        device.cmd_set_color_write_mask_ext(cmd_buffer, 0, &[color_write_mask]);
        if enabled("VK_KHR_fragment_shading_rate") {
            device.cmd_set_fragment_shading_rate_khr(cmd_buffer, &vk::Extent2D { width: 1, height: 1 }, combiner_ops);
        }
        if enabled("VK_EXT_transform_feedback") {
            device.cmd_set_rasterization_stream_ext(cmd_buffer, 0);
        }
        if enabled("VK_EXT_conservative_rasterization") {
            device.cmd_set_conservative_rasterization_mode_ext(
                cmd_buffer,
                vk::ConservativeRasterizationModeEXT::DISABLED,
            );
            device.cmd_set_extra_primitive_overestimation_size_ext(cmd_buffer, 0.0);
        }
        if enabled("VK_EXT_depth_clip_enable") {
            device.cmd_set_depth_clip_enable_ext(cmd_buffer, false);
        }
        if enabled("VK_EXT_sample_locations") {
            device.cmd_set_sample_locations_enable_ext(cmd_buffer, false);
            let sample_location = vk::SampleLocationEXT { x: 0.5, y: 0.5 };
            let sample_locations = vk::SampleLocationsInfoEXT {
                s_type: vk::StructureType::SAMPLE_LOCATIONS_INFO_EXT,
                next: std::ptr::null(),
                sample_locations_per_pixel: vk::SampleCountFlags::_1,
                sample_location_grid_size: vk::Extent2D { width: 1, height: 1 },
                sample_locations_count: 1,
                sample_locations: &sample_location,
            };
            device.cmd_set_sample_locations_ext(cmd_buffer, &sample_locations);
        }
        if enabled("VK_EXT_blend_operation_advanced") {
            let color_blend_advanced = vk::ColorBlendAdvancedEXT {
                advanced_blend_op: vk::BlendOp::SRC_EXT,
                src_premultiplied: vk::FALSE,
                dst_premultiplied: vk::FALSE,
                blend_overlap: vk::BlendOverlapEXT::UNCORRELATED,
                clamp_results: vk::FALSE,
            };
            device.cmd_set_color_blend_advanced_ext(cmd_buffer, 0, &[color_blend_advanced]);
        }
        if enabled("VK_EXT_provoking_vertex") {
            device.cmd_set_provoking_vertex_mode_ext(cmd_buffer, vk::ProvokingVertexModeEXT::FIRST_VERTEX);
        }
        if enabled("VK_KHR_line_rasterization") || enabled("VK_EXT_line_rasterization") {
            device.cmd_set_line_rasterization_mode_ext(cmd_buffer, vk::LineRasterizationModeEXT::DEFAULT);
            device.cmd_set_line_stipple_enable_ext(cmd_buffer, false);
            device.cmd_set_line_stipple_khr(cmd_buffer, 1, 0x0F0F);
        }
        if enabled("VK_EXT_depth_clip_control") {
            device.cmd_set_depth_clip_negative_one_to_one_ext(cmd_buffer, false);
        }
        if enabled("VK_EXT_color_write_enable") {
            device.cmd_set_color_write_enable_ext(cmd_buffer, &[vk::TRUE]);
        }
        if enabled("VK_NV_clip_space_w_scaling") {
            device.cmd_set_viewport_w_scaling_enable_nv(cmd_buffer, false);
            device.cmd_set_viewport_w_scaling_nv(
                cmd_buffer,
                0,
                &[vk::ViewportWScalingNV {
                    xcoeff: 1.0,
                    ycoeff: 1.0,
                }],
            );
        }
        if enabled("VK_NV_viewport_swizzle") {
            let viewport_swizzle = vk::ViewportSwizzleNV {
                x: vk::ViewportCoordinateSwizzleNV::POSITIVE_X,
                y: vk::ViewportCoordinateSwizzleNV::POSITIVE_Y,
                z: vk::ViewportCoordinateSwizzleNV::POSITIVE_Z,
                w: vk::ViewportCoordinateSwizzleNV::POSITIVE_W,
            };
            device.cmd_set_viewport_swizzle_nv(cmd_buffer, 0, &[viewport_swizzle]);
        }
        if enabled("VK_NV_fragment_coverage_to_color") {
            device.cmd_set_coverage_to_color_enable_nv(cmd_buffer, false);
            device.cmd_set_coverage_to_color_location_nv(cmd_buffer, 0);
        }
        if enabled("VK_NV_framebuffer_mixed_samples") {
            device.cmd_set_coverage_modulation_mode_nv(cmd_buffer, vk::CoverageModulationModeNV::NONE);
            device.cmd_set_coverage_modulation_table_enable_nv(cmd_buffer, false);
            device.cmd_set_coverage_modulation_table_nv(cmd_buffer, &[1.0]);
        }
        if enabled("VK_NV_shading_rate_image") {
            device.cmd_set_shading_rate_image_enable_nv(cmd_buffer, false);
        }
        if enabled("VK_NV_coverage_reduction_mode") {
            device.cmd_set_coverage_reduction_mode_nv(cmd_buffer, vk::CoverageReductionModeNV::MERGE);
        }
        if enabled("VK_NV_representative_fragment_test") {
            device.cmd_set_representative_fragment_test_enable_nv(cmd_buffer, false);
        }
        if enabled("VK_NV_scissor_exclusive") {
            device.cmd_set_exclusive_scissor_enable_nv(cmd_buffer, 0, &[vk::FALSE]);
            device.cmd_set_exclusive_scissor_nv(cmd_buffer, 0, &[scissor]);
        }
        if enabled("VK_NV_fragment_shading_rate_enums") {
            device.cmd_set_fragment_shading_rate_enum_nv(
                cmd_buffer,
                vk::FragmentShadingRateNV::_1_INVOCATION_PER_2X2_PIXELS,
                combiner_ops,
            );
        }
        if enabled("VK_EXT_discard_rectangles") {
            device.cmd_set_discard_rectangle_enable_ext(cmd_buffer, false);
            device.cmd_set_discard_rectangle_ext(cmd_buffer, 0, &[scissor]);
            device.cmd_set_discard_rectangle_mode_ext(cmd_buffer, vk::DiscardRectangleModeEXT::INCLUSIVE);
        }
        if enabled("VK_NV_shading_rate_image") {
            device.cmd_set_shading_rate_image_enable_nv(cmd_buffer, false);
        }
        if enabled("VK_EXT_attachment_feedback_loop_dynamic_state") {
            device.cmd_set_attachment_feedback_loop_enable_ext(cmd_buffer, vk::ImageAspectFlags::empty());
        }
    }
}

#[allow(clippy::too_many_arguments)]
/// `vk::bindGraphicsShaders` - the five graphics stages in one call, then a null task and mesh shader when supported.
pub fn bind_graphics_shaders(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    vert: vk::ShaderEXT,
    tesc: vk::ShaderEXT,
    tese: vk::ShaderEXT,
    geom: vk::ShaderEXT,
    frag: vk::ShaderEXT,
    task_shader_supported: bool,
    mesh_shader_supported: bool,
) {
    let stages = [
        vk::ShaderStageFlags::VERTEX,
        vk::ShaderStageFlags::TESSELLATION_CONTROL,
        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
        vk::ShaderStageFlags::GEOMETRY,
        vk::ShaderStageFlags::FRAGMENT,
    ];
    unsafe {
        device.cmd_bind_shaders_ext(cmd_buffer, &stages, &[vert, tesc, tese, geom, frag]);
        if task_shader_supported {
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::TASK_EXT], &[vk::ShaderEXT::null()]);
        }
        if mesh_shader_supported {
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::MESH_EXT], &[vk::ShaderEXT::null()]);
        }
    }
}

/// `vk::bindComputeShader`
pub fn bind_compute_shader(device: &Device, cmd_buffer: vk::CommandBuffer, comp: vk::ShaderEXT) {
    unsafe { device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::COMPUTE], &[comp]) };
}

/// `vk::bindNullTaskMeshShaders`
pub fn bind_null_task_mesh_shaders(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    mesh_features: &vk::PhysicalDeviceMeshShaderFeaturesEXT,
) {
    unsafe {
        if mesh_features.task_shader != vk::FALSE {
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::TASK_EXT], &[vk::ShaderEXT::null()]);
        }
        if mesh_features.mesh_shader != vk::FALSE {
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::MESH_EXT], &[vk::ShaderEXT::null()]);
        }
    }
}

/// `vk::bindNullRasterizationShaders`
pub fn bind_null_rasterization_shaders(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    features: &vk::PhysicalDeviceFeatures,
) {
    let null = [vk::ShaderEXT::null()];
    unsafe {
        device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::VERTEX], &null);
        if features.tessellation_shader != vk::FALSE {
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::TESSELLATION_CONTROL], &null);
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::TESSELLATION_EVALUATION], &null);
        }
        if features.geometry_shader != vk::FALSE {
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::GEOMETRY], &null);
        }
    }
}

/// `vk::removeUnsupportedShaderObjectExtensions` - the device extension list without the two whose pre-version-2 specs have no dynamic state
/// for shader objects.
pub fn remove_unsupported_shader_object_extensions(context: &Context<'_>) -> Result<Vec<String>, TestError> {
    let properties = unsafe {
        context
            .get_instance()
            .enumerate_device_extension_properties(context.get_physical_device(), None)
    }
    .vk_check("vkEnumerateDeviceExtensionProperties")?;
    let spec_version = |name: &str| -> u32 {
        properties
            .iter()
            .find(|p| unsafe { std::ffi::CStr::from_ptr(p.extension_name.as_ptr()) }.to_bytes() == name.as_bytes())
            .map_or(0, |p| p.spec_version)
    };
    let discard_rectangles_version = spec_version("VK_EXT_discard_rectangles");
    let scissor_exclusive_version = spec_version("VK_NV_scissor_exclusive");

    let mut extensions = context.get_device_extensions().to_vec();
    if discard_rectangles_version < 2 {
        extensions.retain(|e| e != "VK_EXT_discard_rectangles");
    }
    if scissor_exclusive_version < 2 {
        extensions.retain(|e| e != "VK_NV_scissor_exclusive");
    }
    Ok(extensions)
}

/// `vkCmdBindShadersEXT` with a null `pShaders`, which unbinds every stage in `stages`; the wrapper cannot pass one.
pub fn bind_shaders_null_pointer(device: &Device, cmd_buffer: vk::CommandBuffer, stages: &[vk::ShaderStageFlags]) {
    unsafe {
        (device.commands().cmd_bind_shaders_ext)(cmd_buffer, stages.len() as u32, stages.as_ptr(), std::ptr::null())
    };
}

/// One shader of `stage` from the test's binaries; the layout, when given, has to outlive the call.
pub fn make_shader<'a>(
    device: &'a Device,
    binaries: crate::vk::programs::BinaryCollection,
    stage: vk::ShaderStageFlags,
    name: &str,
    features: &vk::PhysicalDeviceFeatures,
    layout: Option<&vk::DescriptorSetLayout>,
) -> Result<ShaderObject<'a>, TestError> {
    create_shader(
        device,
        &make_shader_create_info(
            stage,
            &binaries.get(name)?,
            features.tessellation_shader != vk::FALSE,
            features.geometry_shader != vk::FALSE,
            layout,
            None,
        ),
    )
}
