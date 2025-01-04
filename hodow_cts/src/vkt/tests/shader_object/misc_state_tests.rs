// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectMiscTests.cpp (`ShaderObjectStateCase`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `misc.state` group: every dynamic state a graphics pipeline or the shader object
// commands can set, over the six stage combinations, drawing one or two quads (or lines) and checking the colour, depth and stencil
// results. The programs are `MISC_STATE` of `shaders/manifest/shader_object_misc_state.toml`, written by
// `scripts/gen_shader_object_state_shaders.py`. Upstream creates a second device with exactly the features and extensions a case needs; here
// the default device is used, which already enables them where the driver has them, and the cases check for the features themselves.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtColorWriteEnableExtensionDeviceCommands, ExtDiscardRectanglesExtensionDeviceCommands,
    ExtMeshShaderExtensionDeviceCommands, ExtSampleLocationsExtensionDeviceCommands,
    ExtShaderObjectExtensionDeviceCommands, ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1,
    KhrLineRasterizationExtensionDeviceCommands,
};

use super::util::{
    ShaderObject, bind_graphics_shaders, bind_null_rasterization_shaders, create_shader, get_mesh_shader_features,
    make_shader_create_info, remove_unsupported_shader_object_extensions,
};
use crate::generated::shaders::shader_object_misc_state::MISC_STATE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::rect_2d;
use crate::vkt::tests::pipeline::pipeline_util::{read_depth_attachment, read_stencil_attachment};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `StateTestParams`
#[derive(Clone, Copy)]
struct StateParams {
    pipeline: bool,
    mesh_shader: bool,
    vert_shader: bool,
    tess_shader: bool,
    geom_shader: bool,
    frag_shader: bool,
    logic_op: bool,
    alpha_to_one: bool,
    depth_bounds: bool,
    depth_clamp: bool,
    depth_clip: bool,
    depth_clip_control: bool,
    color_write: bool,
    geometry_streams: bool,
    discard_rectangles: bool,
    conservative_rasterization: bool,
    rasterizer_discard_enable: bool,
    lines: bool,
    sample_locations: bool,
    provoking_vertex: bool,
    line_rasterization: bool,
    cull_mode: vk::CullModeFlags,
    stencil_test_enable: bool,
    depth_test_enable: bool,
    depth_write_enable: bool,
    depth_bias_enable: bool,
    depth_bounds_test_enable: bool,
    logic_op_enable: bool,
    color_blend_enable: bool,
    discard_rectangles_enable: bool,
    sample_locations_enable: bool,
    conservative_rasterization_overestimate: bool,
    stippled_line_enable: bool,
    color_write_enable: bool,
}

impl StateParams {
    /// The parameters after `StateTestParams::reset`, for the given pipeline kind and stage combination.
    fn new(
        pipeline: bool,
        mesh_shader: bool,
        vert_shader: bool,
        tess_shader: bool,
        geom_shader: bool,
        frag_shader: bool,
    ) -> Self {
        let mut params = Self {
            pipeline,
            mesh_shader,
            vert_shader,
            tess_shader,
            geom_shader,
            frag_shader,
            logic_op: false,
            alpha_to_one: false,
            depth_bounds: false,
            depth_clamp: false,
            depth_clip: false,
            depth_clip_control: false,
            color_write: true,
            geometry_streams: false,
            discard_rectangles: false,
            conservative_rasterization: false,
            rasterizer_discard_enable: false,
            lines: false,
            sample_locations: false,
            provoking_vertex: false,
            line_rasterization: false,
            cull_mode: vk::CullModeFlags::NONE,
            stencil_test_enable: false,
            depth_test_enable: false,
            depth_write_enable: false,
            depth_bias_enable: false,
            depth_bounds_test_enable: false,
            logic_op_enable: false,
            color_blend_enable: false,
            discard_rectangles_enable: false,
            sample_locations_enable: false,
            conservative_rasterization_overestimate: false,
            stippled_line_enable: false,
            color_write_enable: true,
        };
        params.reset();
        params
    }

    fn reset(&mut self) {
        self.logic_op = false;
        self.alpha_to_one = false;
        self.depth_bounds = false;
        self.depth_clamp = false;
        self.depth_clip = false;
        self.depth_clip_control = false;
        self.color_write = true;
        self.geometry_streams = false;
        self.discard_rectangles = false;
        self.conservative_rasterization = false;
        self.rasterizer_discard_enable = false;
        self.lines = false;
        self.sample_locations = false;
        self.provoking_vertex = false;
        self.line_rasterization = false;
        self.cull_mode = vk::CullModeFlags::NONE;
        self.stencil_test_enable = false;
        self.depth_test_enable = false;
        self.depth_write_enable = false;
        self.depth_bias_enable = false;
        self.depth_bounds_test_enable = false;
        self.logic_op_enable = false;
        self.color_blend_enable = false;
        self.discard_rectangles_enable = false;
        self.sample_locations_enable = false;
        self.conservative_rasterization_overestimate = false;
        self.stippled_line_enable = false;
        self.color_write_enable = true;
    }
}

/// The feature structs of the default device that `checkSupport` and `getDynamicStates` read.
struct StateFeatures {
    eds: vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT,
    eds2: vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT,
    eds3: vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT,
    vertex_input: vk::PhysicalDeviceVertexInputDynamicStateFeaturesEXT,
    depth_clip_enable: vk::PhysicalDeviceDepthClipEnableFeaturesEXT,
    depth_clip_control: vk::PhysicalDeviceDepthClipControlFeaturesEXT,
    color_write_enable: vk::PhysicalDeviceColorWriteEnableFeaturesEXT,
    transform_feedback: vk::PhysicalDeviceTransformFeedbackFeaturesEXT,
    line_rasterization: vk::PhysicalDeviceLineRasterizationFeatures,
}

fn query_features(context: &Context<'_>) -> StateFeatures {
    let mut features = StateFeatures {
        eds: Default::default(),
        eds2: Default::default(),
        eds3: Default::default(),
        vertex_input: Default::default(),
        depth_clip_enable: Default::default(),
        depth_clip_control: Default::default(),
        color_write_enable: Default::default(),
        transform_feedback: Default::default(),
        line_rasterization: Default::default(),
    };
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut features.eds)
            .push_next(&mut features.eds2)
            .push_next(&mut features.eds3)
            .push_next(&mut features.vertex_input)
            .push_next(&mut features.depth_clip_enable)
            .push_next(&mut features.depth_clip_control)
            .push_next(&mut features.color_write_enable)
            .push_next(&mut features.transform_feedback)
            .push_next(&mut features.line_rasterization);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

/// `findDSFormat`
fn find_ds_format(context: &Context<'_>) -> vk::Format {
    [
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
        vk::Format::D16_UNORM_S8_UINT,
    ]
    .into_iter()
    .find(|&format| {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
    })
    .unwrap_or(vk::Format::UNDEFINED)
}

/// `getDynamicStates`
fn get_dynamic_states(params: &StateParams, features: &StateFeatures) -> Vec<vk::DynamicState> {
    use vk::DynamicState as D;
    let (eds, eds2, eds3, vi) = (&features.eds, &features.eds2, &features.eds3, &features.vertex_input);
    let on = |value: vk::Bool32| value != vk::FALSE;
    let mut states = Vec::new();

    if on(eds.extended_dynamic_state) {
        states.push(D::VIEWPORT_WITH_COUNT);
        states.push(D::SCISSOR_WITH_COUNT);
    }

    states.push(D::LINE_WIDTH);
    states.push(D::DEPTH_BIAS);
    states.push(D::BLEND_CONSTANTS);
    states.push(D::DEPTH_BOUNDS);
    states.push(D::STENCIL_COMPARE_MASK);
    states.push(D::STENCIL_WRITE_MASK);
    states.push(D::STENCIL_REFERENCE);
    if on(eds.extended_dynamic_state) && !params.mesh_shader && !params.pipeline {
        states.push(D::VERTEX_INPUT_BINDING_STRIDE);
    }
    if on(eds.extended_dynamic_state) {
        states.extend([
            D::CULL_MODE,
            D::DEPTH_BOUNDS_TEST_ENABLE,
            D::DEPTH_COMPARE_OP,
            D::DEPTH_TEST_ENABLE,
            D::DEPTH_WRITE_ENABLE,
            D::FRONT_FACE,
        ]);
    }
    if on(eds.extended_dynamic_state) && !params.mesh_shader {
        states.push(D::PRIMITIVE_TOPOLOGY);
    }
    if on(eds.extended_dynamic_state) {
        states.push(D::STENCIL_OP);
        states.push(D::STENCIL_TEST_ENABLE);
    }
    if on(eds2.extended_dynamic_state2) {
        states.push(D::DEPTH_BIAS_ENABLE);
    }
    if on(eds2.extended_dynamic_state2) && !params.mesh_shader {
        states.push(D::PRIMITIVE_RESTART_ENABLE);
    }
    if on(eds2.extended_dynamic_state2) {
        states.push(D::RASTERIZER_DISCARD_ENABLE);
    }
    if on(vi.vertex_input_dynamic_state) && !params.mesh_shader && !params.pipeline {
        states.push(D::VERTEX_INPUT_EXT);
    }
    if on(eds2.extended_dynamic_state2_logic_op) {
        states.push(D::LOGIC_OP_EXT);
    }
    if on(eds2.extended_dynamic_state2_patch_control_points) && !params.mesh_shader {
        states.push(D::PATCH_CONTROL_POINTS_EXT);
    }
    if on(eds3.extended_dynamic_state3_tessellation_domain_origin) {
        states.push(D::TESSELLATION_DOMAIN_ORIGIN_EXT);
    }
    if on(eds3.extended_dynamic_state_3depth_clamp_enable) {
        states.push(D::DEPTH_CLAMP_ENABLE_EXT);
    }
    if on(eds3.extended_dynamic_state3_polygon_mode) {
        states.push(D::POLYGON_MODE_EXT);
    }
    if on(eds3.extended_dynamic_state3_rasterization_samples) {
        states.push(D::RASTERIZATION_SAMPLES_EXT);
    }
    if on(eds3.extended_dynamic_state3_sample_mask) {
        states.push(D::SAMPLE_MASK_EXT);
    }
    if on(eds3.extended_dynamic_state3_alpha_to_coverage_enable) {
        states.push(D::ALPHA_TO_COVERAGE_ENABLE_EXT);
    }
    if on(eds3.extended_dynamic_state3_alpha_to_one_enable) {
        states.push(D::ALPHA_TO_ONE_ENABLE_EXT);
    }
    // VUID-vkCmdDraw-None-10862
    if on(eds3.extended_dynamic_state3_logic_op_enable) && params.frag_shader {
        states.push(D::LOGIC_OP_ENABLE_EXT);
    }
    if on(eds3.extended_dynamic_state3_color_blend_enable) && params.frag_shader {
        states.push(D::COLOR_BLEND_ENABLE_EXT);
    }
    if on(eds3.extended_dynamic_state3_color_blend_equation) && params.frag_shader {
        states.push(D::COLOR_BLEND_EQUATION_EXT);
    }
    if on(eds3.extended_dynamic_state3_color_write_mask) && params.frag_shader {
        states.push(D::COLOR_WRITE_MASK_EXT);
    }
    if on(eds3.extended_dynamic_state3_rasterization_stream) {
        states.push(D::RASTERIZATION_STREAM_EXT);
    }
    if params.discard_rectangles {
        states.extend([
            D::DISCARD_RECTANGLE_ENABLE_EXT,
            D::DISCARD_RECTANGLE_MODE_EXT,
            D::DISCARD_RECTANGLE_EXT,
        ]);
    }
    if on(eds3.extended_dynamic_state3_conservative_rasterization_mode) && params.conservative_rasterization {
        states.push(D::CONSERVATIVE_RASTERIZATION_MODE_EXT);
    }
    if on(eds3.extended_dynamic_state3_extra_primitive_overestimation_size) && params.conservative_rasterization {
        states.push(D::EXTRA_PRIMITIVE_OVERESTIMATION_SIZE_EXT);
    }
    if on(eds3.extended_dynamic_state_3depth_clip_enable) && params.depth_clip {
        states.push(D::DEPTH_CLIP_ENABLE_EXT);
    }
    if on(eds3.extended_dynamic_state3_sample_locations_enable) && params.sample_locations {
        states.push(D::SAMPLE_LOCATIONS_ENABLE_EXT);
    }
    if params.sample_locations {
        states.push(D::SAMPLE_LOCATIONS_EXT);
    }
    if on(eds3.extended_dynamic_state3_provoking_vertex_mode) && params.provoking_vertex {
        states.push(D::PROVOKING_VERTEX_MODE_EXT);
    }
    if on(eds3.extended_dynamic_state3_line_rasterization_mode) && params.line_rasterization {
        states.push(D::LINE_RASTERIZATION_MODE_EXT);
    }
    if on(eds3.extended_dynamic_state3_line_stipple_enable) && params.line_rasterization {
        states.push(D::LINE_STIPPLE_ENABLE_EXT);
    }
    if params.line_rasterization {
        states.push(D::LINE_STIPPLE);
    }
    if on(eds3.extended_dynamic_state_3depth_clip_negative_one_to_one) && params.depth_clip_control {
        states.push(D::DEPTH_CLIP_NEGATIVE_ONE_TO_ONE_EXT);
    }
    if params.color_write {
        states.push(D::COLOR_WRITE_ENABLE_EXT);
    }
    states
}

/// `ShaderObjectStateInstance::isInsidePrimitive`
fn is_inside_primitive(params: &StateParams, i: u32, j: u32, width: u32, height: u32) -> bool {
    let mut x_offset = width / 4;
    let mut y_offset = height / 4;
    if params.tess_shader {
        x_offset /= 2;
    }
    if params.geom_shader {
        y_offset /= 2;
    }

    if params.lines {
        if params.stippled_line_enable {
            if params.tess_shader && params.geom_shader {
                (j == 4 && i == 3) || (j == 20 && i == 3)
            } else if params.tess_shader {
                j == 8 && i == 3
            } else if params.geom_shader {
                (j == 3 && i == 8) || (j == 27 && i == 8)
            } else {
                (j == 7 && i == 8) || (j == 23 && i == 8)
            }
        } else if params.tess_shader && params.geom_shader {
            i == 3 && (4..28).contains(&j)
        } else if params.tess_shader {
            i == 3 && (8..24).contains(&j)
        } else if params.geom_shader {
            (j == 3 || j == 27) && (8..24).contains(&i)
        } else {
            (8..24).contains(&i) && (j == 7 || j == 23)
        }
    } else {
        i >= x_offset && i < width - x_offset && j >= y_offset && j < height - y_offset
    }
}

struct StateCase {
    name: String,
    params: StateParams,
}

impl TestCase for StateCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ShaderObjectStateCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;
        let features = query_features(context);
        let core = context.get_device_features();
        let not_supported = |what: &str| Err(TestError::NotSupported(format!("{what} not supported")));

        if find_ds_format(context) == vk::Format::UNDEFINED {
            return Err(TestError::NotSupported(
                "Required depth/stencil format not supported".to_string(),
            ));
        }

        if !params.pipeline {
            context.require_device_functionality("VK_EXT_shader_object")?;
        } else {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if core.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return not_supported("vertexPipelineStoresAndAtomics");
        }

        if params.logic_op {
            if core.logic_op == vk::FALSE {
                return not_supported("logicOp");
            }
            if params.pipeline && features.eds2.extended_dynamic_state2_logic_op == vk::FALSE {
                return not_supported("extendedDynamicState2LogicOp");
            }
        }
        if params.alpha_to_one {
            if core.alpha_to_one == vk::FALSE {
                return not_supported("alphaToOne");
            }
            if params.pipeline && features.eds3.extended_dynamic_state3_alpha_to_one_enable == vk::FALSE {
                return not_supported("extendedDynamicState3AlphaToOneEnable");
            }
        }
        if params.depth_bounds {
            if core.depth_bounds == vk::FALSE {
                return not_supported("depthBounds");
            }
            if params.pipeline && features.eds.extended_dynamic_state == vk::FALSE {
                return not_supported("extendedDynamicState");
            }
        }
        if params.depth_clamp {
            if core.depth_clamp == vk::FALSE {
                return not_supported("depthClamp");
            }
            if params.pipeline && features.eds3.extended_dynamic_state_3depth_clamp_enable == vk::FALSE {
                return not_supported("extendedDynamicState3DepthClampEnable");
            }
        }
        if params.depth_clip {
            context.require_device_functionality("VK_EXT_depth_clip_enable")?;
            if features.depth_clip_enable.depth_clip_enable == vk::FALSE {
                return not_supported("depthClipEnable");
            }
            if params.pipeline && features.eds3.extended_dynamic_state_3depth_clip_enable == vk::FALSE {
                return not_supported("extendedDynamicState3DepthClipEnable");
            }
        }
        if params.depth_clip_control {
            context.require_device_functionality("VK_EXT_depth_clip_control")?;
            if features.depth_clip_control.depth_clip_control == vk::FALSE {
                return not_supported("depthClipControl");
            }
            if params.pipeline && features.eds3.extended_dynamic_state_3depth_clip_negative_one_to_one == vk::FALSE {
                return not_supported("extendedDynamicState3DepthClipNegativeOneToOne");
            }
        }
        if params.color_write {
            context.require_device_functionality("VK_EXT_color_write_enable")?;
            if features.color_write_enable.color_write_enable == vk::FALSE {
                return not_supported("colorWriteEnable");
            }
        }
        if params.geometry_streams {
            context.require_device_functionality("VK_EXT_transform_feedback")?;
            if features.transform_feedback.geometry_streams == vk::FALSE {
                return not_supported("geometryStreams");
            }
            if params.pipeline && features.eds3.extended_dynamic_state3_rasterization_stream == vk::FALSE {
                return not_supported("extendedDynamicState3RasterizationStream");
            }
        }
        if params.discard_rectangles {
            context.require_device_functionality("VK_EXT_discard_rectangles")?;

            let extensions = unsafe {
                context
                    .get_instance()
                    .enumerate_device_extension_properties(context.get_physical_device(), None)
            }
            .vk_check("vkEnumerateDeviceExtensionProperties")?;
            for extension in &extensions {
                if extension.extension_name.to_string() == "VK_EXT_discard_rectangles" && extension.spec_version < 2 {
                    return Err(TestError::NotSupported(
                        "VK_EXT_discard_rectangles is version 1. Needs version 2 or higher".to_string(),
                    ));
                }
            }
        }
        if params.conservative_rasterization {
            context.require_device_functionality("VK_EXT_conservative_rasterization")?;
            if params.pipeline && features.eds3.extended_dynamic_state3_conservative_rasterization_mode == vk::FALSE {
                return not_supported("extendedDynamicState3ConservativeRasterizationMode");
            }
        }
        if params.sample_locations {
            context.require_device_functionality("VK_EXT_sample_locations")?;

            let mut sample_locations_properties = vk::PhysicalDeviceSampleLocationsPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut sample_locations_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if params.sample_locations_enable
                && !sample_locations_properties
                    .sample_location_sample_counts
                    .contains(vk::SampleCountFlags::_1)
            {
                return Err(TestError::NotSupported(
                    "VK_SAMPLE_COUNT_1_BIT not supported in sampleLocationSampleCounts".to_string(),
                ));
            }
        }
        if params.provoking_vertex {
            context.require_device_functionality("VK_EXT_provoking_vertex")?;
            if params.pipeline && features.eds3.extended_dynamic_state3_provoking_vertex_mode == vk::FALSE {
                return not_supported("extendedDynamicState3ProvokingVertexMode");
            }
        }
        if params.line_rasterization {
            if !context.is_device_functionality_supported("VK_KHR_line_rasterization")
                && !context.is_device_functionality_supported("VK_EXT_line_rasterization")
            {
                return Err(TestError::NotSupported(
                    "VK_KHR_line_rasterization and VK_EXT_line_rasterization are not supported".to_string(),
                ));
            }
            if features.line_rasterization.rectangular_lines == vk::FALSE {
                return not_supported("rectangularLines");
            }
            if params.pipeline && features.eds3.extended_dynamic_state3_line_rasterization_mode == vk::FALSE {
                return not_supported("extendedDynamicState3LineRasterizationMode");
            }
            if params.pipeline && features.eds3.extended_dynamic_state3_line_stipple_enable == vk::FALSE {
                return not_supported("extendedDynamicState3LineStippleEnable");
            }
            if params.stippled_line_enable && features.line_rasterization.stippled_rectangular_lines == vk::FALSE {
                return not_supported("stippledRectangularLines");
            }
        }
        if params.geom_shader && core.geometry_shader == vk::FALSE {
            return not_supported("geometryShader");
        }
        if params.tess_shader && core.tessellation_shader == vk::FALSE {
            return not_supported("tessellationShader");
        }
        if params.mesh_shader {
            context.require_device_functionality("VK_EXT_mesh_shader")?;
            if get_mesh_shader_features(context).mesh_shader == vk::FALSE {
                return Err(TestError::NotSupported("Mesh shaders not supported".to_string()));
            }
        }
        if params.lines && params.pipeline && features.eds.extended_dynamic_state == vk::FALSE {
            return not_supported("extendedDynamicState");
        }
        if params.color_blend_enable && params.pipeline {
            context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;
            if features.eds3.extended_dynamic_state3_color_blend_enable == vk::FALSE {
                return not_supported("extendedDynamicState3ColorBlendEnable");
            }
        }
        if params.logic_op_enable && params.pipeline {
            context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;
            if features.eds3.extended_dynamic_state3_logic_op_enable == vk::FALSE {
                return not_supported("extendedDynamicState3LogicOpEnable");
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MISC_STATE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StateInstance {
            context,
            params: self.params,
        })
    }
}

fn vertex_shader_name(params: &StateParams) -> String {
    format!("vert_clip{}", params.depth_clip as u32)
}

fn tese_shader_name(params: &StateParams) -> String {
    format!("tese_lines{}", params.lines as u32)
}

fn geom_shader_name(params: &StateParams) -> String {
    format!(
        "geom_lines{}_streams{}",
        params.lines as u32, params.geometry_streams as u32
    )
}

fn mesh_shader_name(params: &StateParams) -> String {
    format!("mesh_lines{}_clip{}", params.lines as u32, params.depth_clip as u32)
}

/// One shader of `stage` from the test's binaries, with the cases' descriptor set layout.
#[allow(clippy::too_many_arguments)]
fn make_state_shader<'a>(
    device: &'a Device,
    binaries: BinaryCollection,
    stage: vk::ShaderStageFlags,
    name: &str,
    tessellation: bool,
    geometry: bool,
    layout: &vk::DescriptorSetLayout,
    flags: vk::ShaderCreateFlagsEXT,
) -> Result<ShaderObject<'a>, TestError> {
    let mut create_info =
        make_shader_create_info(stage, &binaries.get(name)?, tessellation, geometry, Some(layout), None);
    create_info.flags = flags;
    create_shader(device, &create_info)
}

/// `ShaderObjectStateInstance`
struct StateInstance<'a> {
    context: &'a Context<'a>,
    params: StateParams,
}

impl StateInstance<'_> {
    fn has_dynamic_state(&self, dynamic_states: &[vk::DynamicState], dynamic_state: vk::DynamicState) -> bool {
        !self.params.pipeline || dynamic_states.contains(&dynamic_state)
    }

    /// `setDynamicStates`
    fn set_dynamic_states(
        &self,
        cmd: vk::CommandBuffer,
        features: &StateFeatures,
        extensions: &[String],
    ) -> Result<(), TestError> {
        use vk::DynamicState as D;
        let params = self.params;
        let device = self.context.get_device();
        let dynamic_states = get_dynamic_states(&params, features);
        let has = |state: vk::DynamicState| self.has_dynamic_state(&dynamic_states, state);
        let extension_enabled = |name: &str| extensions.iter().any(|extension| extension == name);
        let discard = params.rasterizer_discard_enable;
        let flag = |value: bool| if value { vk::TRUE } else { vk::FALSE };

        let mut viewport = vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: 32.0,
            height: 32.0,
            min_depth: 0.0,
            max_depth: 1.0,
        };
        if params.depth_clamp {
            viewport.max_depth = 0.5;
        }
        let scissor = rect_2d(32, 32);

        unsafe {
            if has(D::VIEWPORT_WITH_COUNT) {
                device.cmd_set_viewport_with_count_ext(cmd, &[viewport]);
            }
            if has(D::SCISSOR_WITH_COUNT) {
                device.cmd_set_scissor_with_count_ext(cmd, &[scissor]);
            }
            if !discard && params.lines && has(D::LINE_WIDTH) {
                device.cmd_set_line_width(cmd, 1.0);
            }
            if !discard && params.depth_bias_enable && has(D::DEPTH_BIAS) {
                device.cmd_set_depth_bias(cmd, 4.0, 1.0, 4.0);
            } else if has(D::DEPTH_BIAS) {
                device.cmd_set_depth_bias(cmd, 1.0, 0.0, 1.0);
            }
            if params.frag_shader && !discard && params.color_blend_enable && has(D::BLEND_CONSTANTS) {
                device.cmd_set_blend_constants(cmd, [1.0, 1.0, 1.0, 1.0]);
            }
            if !discard && params.depth_bounds_test_enable && has(D::DEPTH_BOUNDS) {
                device.cmd_set_depth_bounds(cmd, 0.2, 0.3);
            }
            if has(D::STENCIL_COMPARE_MASK) {
                device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFFFF_FFFF);
            }
            if has(D::STENCIL_WRITE_MASK) {
                device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFFFF_FFFF);
            }
            if has(D::STENCIL_REFERENCE) {
                device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xFFFF_FFFF);
            }
            if has(D::VERTEX_INPUT_BINDING_STRIDE) {
                device.cmd_bind_vertex_buffers2_ext(cmd, 0, &[], &[], &[], &[]);
            }
            if !discard && has(D::CULL_MODE) {
                device.cmd_set_cull_mode_ext(cmd, params.cull_mode);
            }
            if !discard && params.depth_bounds && has(D::DEPTH_BOUNDS_TEST_ENABLE) {
                device.cmd_set_depth_bounds_test_enable_ext(cmd, params.depth_bounds_test_enable);
            }
            if !discard && has(D::DEPTH_COMPARE_OP) {
                device.cmd_set_depth_compare_op_ext(cmd, vk::CompareOp::LESS);
            }
            if !discard && has(D::DEPTH_TEST_ENABLE) {
                device.cmd_set_depth_test_enable_ext(cmd, params.depth_test_enable);
            }
            if !discard && (params.depth_test_enable || params.depth_write_enable) && has(D::DEPTH_WRITE_ENABLE) {
                device.cmd_set_depth_write_enable_ext(cmd, params.depth_write_enable);
            }
            if !discard
                && (params.cull_mode != vk::CullModeFlags::NONE
                    && params.cull_mode != vk::CullModeFlags::FRONT_AND_BACK)
                && has(D::FRONT_FACE)
            {
                device.cmd_set_front_face_ext(cmd, vk::FrontFace::CLOCKWISE);
            }
            if params.vert_shader && has(D::PRIMITIVE_TOPOLOGY) {
                if params.tess_shader {
                    device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::PATCH_LIST);
                } else if params.lines {
                    device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::LINE_LIST);
                } else {
                    device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP);
                }
            }
            if !discard && params.stencil_test_enable && has(D::STENCIL_OP) {
                device.cmd_set_stencil_op_ext(
                    cmd,
                    vk::StencilFaceFlags::FRONT_AND_BACK,
                    vk::StencilOp::REPLACE,
                    vk::StencilOp::REPLACE,
                    vk::StencilOp::REPLACE,
                    vk::CompareOp::GREATER,
                );
            }
            if !discard && has(D::STENCIL_TEST_ENABLE) {
                device.cmd_set_stencil_test_enable_ext(cmd, params.stencil_test_enable);
            }
            if !discard && has(D::DEPTH_BIAS_ENABLE) {
                device.cmd_set_depth_bias_enable_ext(cmd, params.depth_bias_enable);
            }
            if params.vert_shader && has(D::PRIMITIVE_RESTART_ENABLE) {
                device.cmd_set_primitive_restart_enable_ext(cmd, false);
            }
            if has(D::RASTERIZER_DISCARD_ENABLE) {
                device.cmd_set_rasterizer_discard_enable_ext(cmd, discard);
            }
            if params.vert_shader
                && has(D::VERTEX_INPUT_BINDING_STRIDE)
                && (extension_enabled("VK_EXT_shader_object") || extension_enabled("VK_EXT_vertex_input_dynamic_state"))
            {
                device.cmd_set_vertex_input_ext(
                    cmd,
                    &[] as &[vk::VertexInputBindingDescription2EXT],
                    &[] as &[vk::VertexInputAttributeDescription2EXT],
                );
            }
            if params.frag_shader && !discard && params.logic_op_enable && has(D::LOGIC_OP_EXT) {
                device.cmd_set_logic_op_ext(cmd, vk::LogicOp::COPY);
            }
            if has(D::PATCH_CONTROL_POINTS_EXT) {
                device.cmd_set_patch_control_points_ext(cmd, 4);
            }
            if params.tess_shader && has(D::TESSELLATION_DOMAIN_ORIGIN_EXT) {
                device.cmd_set_tessellation_domain_origin_ext(cmd, vk::TessellationDomainOrigin::UPPER_LEFT);
            }
            if !discard && params.depth_clamp {
                device.cmd_set_depth_clamp_enable_ext(cmd, true);
            } else if has(D::DEPTH_CLAMP_ENABLE_EXT) {
                device.cmd_set_depth_clamp_enable_ext(cmd, params.depth_clamp);
            }
            if !discard && has(D::POLYGON_MODE_EXT) {
                device.cmd_set_polygon_mode_ext(cmd, vk::PolygonMode::FILL);
            }
            if !discard && has(D::RASTERIZATION_SAMPLES_EXT) {
                device.cmd_set_rasterization_samples_ext(cmd, vk::SampleCountFlags::_1);
            }
            let sample_mask: vk::SampleMask = 0xFFFF_FFFF;
            if !discard && has(D::SAMPLE_MASK_EXT) {
                device.cmd_set_sample_mask_ext(cmd, vk::SampleCountFlags::_1, Some(&sample_mask));
            }
            if !discard && has(D::ALPHA_TO_COVERAGE_ENABLE_EXT) {
                device.cmd_set_alpha_to_coverage_enable_ext(cmd, false);
            }
            if !discard && params.alpha_to_one {
                device.cmd_set_alpha_to_one_enable_ext(cmd, true);
            } else if has(D::ALPHA_TO_ONE_ENABLE_EXT) {
                device.cmd_set_alpha_to_one_enable_ext(cmd, params.alpha_to_one);
            }
            if params.frag_shader && !discard && params.logic_op && has(D::LOGIC_OP_ENABLE_EXT) {
                device.cmd_set_logic_op_enable_ext(cmd, params.logic_op_enable);
            }
            if params.frag_shader && !discard && has(D::COLOR_BLEND_ENABLE_EXT) {
                device.cmd_set_color_blend_enable_ext(cmd, 0, &[flag(params.color_blend_enable)]);
            }
            let color_blend_equation = vk::ColorBlendEquationEXT {
                src_color_blend_factor: vk::BlendFactor::ONE,
                dst_color_blend_factor: vk::BlendFactor::ONE,
                color_blend_op: vk::BlendOp::ADD,
                src_alpha_blend_factor: vk::BlendFactor::ONE,
                dst_alpha_blend_factor: vk::BlendFactor::ONE,
                alpha_blend_op: vk::BlendOp::ADD,
            };
            if params.frag_shader && !discard && has(D::COLOR_BLEND_EQUATION_EXT) {
                device.cmd_set_color_blend_equation_ext(cmd, 0, &[color_blend_equation]);
            }
            let color_write_mask = vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A;
            if params.frag_shader && !discard && has(D::COLOR_WRITE_MASK_EXT) {
                device.cmd_set_color_write_mask_ext(cmd, 0, &[color_write_mask]);
            }
            if params.geom_shader && params.geometry_streams && has(D::RASTERIZATION_STREAM_EXT) {
                device.cmd_set_rasterization_stream_ext(cmd, 0);
            }
            if params.discard_rectangles {
                device.cmd_set_discard_rectangle_enable_ext(cmd, params.discard_rectangles_enable);
            }
            if params.discard_rectangles_enable && has(D::DISCARD_RECTANGLE_MODE_EXT) {
                device.cmd_set_discard_rectangle_mode_ext(cmd, vk::DiscardRectangleModeEXT::EXCLUSIVE);
            }
            if params.discard_rectangles_enable && has(D::DISCARD_RECTANGLE_EXT) {
                let mut discard_properties = vk::PhysicalDeviceDiscardRectanglePropertiesEXT::default();
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut discard_properties);
                self.context
                    .get_instance()
                    .get_physical_device_properties2(self.context.get_physical_device(), &mut properties2);
                for i in 0..discard_properties.max_discard_rectangles {
                    device.cmd_set_discard_rectangle_ext(cmd, i, &[scissor]);
                }
            }
            if !discard && params.conservative_rasterization && has(D::CONSERVATIVE_RASTERIZATION_MODE_EXT) {
                let mode = if params.conservative_rasterization_overestimate {
                    vk::ConservativeRasterizationModeEXT::OVERESTIMATE
                } else {
                    vk::ConservativeRasterizationModeEXT::DISABLED
                };
                device.cmd_set_conservative_rasterization_mode_ext(cmd, mode);
            }
            if !discard
                && params.conservative_rasterization
                && params.conservative_rasterization_overestimate
                && has(D::EXTRA_PRIMITIVE_OVERESTIMATION_SIZE_EXT)
            {
                let mut conservative_properties = vk::PhysicalDeviceConservativeRasterizationPropertiesEXT::default();
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut conservative_properties);
                self.context
                    .get_instance()
                    .get_physical_device_properties2(self.context.get_physical_device(), &mut properties2);
                device.cmd_set_extra_primitive_overestimation_size_ext(
                    cmd,
                    conservative_properties.max_extra_primitive_overestimation_size.min(1.0),
                );
            }
            if params.depth_clip && has(D::DEPTH_CLIP_ENABLE_EXT) {
                device.cmd_set_depth_clip_enable_ext(cmd, true);
            }
            if params.sample_locations && has(D::SAMPLE_LOCATIONS_ENABLE_EXT) {
                device.cmd_set_sample_locations_enable_ext(cmd, params.sample_locations_enable);
            }
            let sample_location = vk::SampleLocationEXT { x: 0.5, y: 0.5 };
            let sample_locations_info = vk::SampleLocationsInfoEXT {
                s_type: vk::StructureType::SAMPLE_LOCATIONS_INFO_EXT,
                next: std::ptr::null(),
                sample_locations_per_pixel: vk::SampleCountFlags::_1,
                sample_location_grid_size: vk::Extent2D { width: 1, height: 1 },
                sample_locations_count: 1,
                sample_locations: &sample_location,
            };
            if params.sample_locations && params.sample_locations_enable && has(D::SAMPLE_LOCATIONS_EXT) {
                device.cmd_set_sample_locations_ext(cmd, &sample_locations_info);
            }
            if params.provoking_vertex && has(D::PROVOKING_VERTEX_MODE_EXT) {
                device.cmd_set_provoking_vertex_mode_ext(cmd, vk::ProvokingVertexModeEXT::FIRST_VERTEX);
            }
            if !discard && params.line_rasterization && params.lines && !params.mesh_shader {
                if has(D::LINE_RASTERIZATION_MODE_EXT) {
                    device.cmd_set_line_rasterization_mode_ext(cmd, vk::LineRasterizationModeEXT::RECTANGULAR);
                }
                if has(D::LINE_STIPPLE_ENABLE_EXT) {
                    device.cmd_set_line_stipple_enable_ext(cmd, params.stippled_line_enable);
                }
                if params.stippled_line_enable && has(D::LINE_STIPPLE) {
                    device.cmd_set_line_stipple_khr(cmd, 1, 0x1);
                }
            }
            if params.depth_clip_control && has(D::DEPTH_CLIP_NEGATIVE_ONE_TO_ONE_EXT) {
                device.cmd_set_depth_clip_negative_one_to_one_ext(cmd, true);
            }
            if params.color_write && has(D::COLOR_WRITE_ENABLE_EXT) {
                device.cmd_set_color_write_enable_ext(cmd, &[flag(params.color_write_enable)]);
            }
        }
        Ok(())
    }
}

/// The monolithic graphics pipeline of the `pipeline` cases.
fn create_state_pipeline<'a>(
    context: &'a Context<'_>,
    params: StateParams,
    pipeline_layout: vk::PipelineLayout,
    features: &StateFeatures,
    ds_format: vk::Format,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    {
        let device = context.get_device();
        let binaries = context.get_binary_collection();

        let mesh_module = if params.mesh_shader {
            Some(create_shader_module(device, binaries.get(&mesh_shader_name(&params))?)?)
        } else {
            None
        };
        let vert_module = if params.vert_shader {
            Some(create_shader_module(
                device,
                binaries.get(&vertex_shader_name(&params))?,
            )?)
        } else {
            None
        };
        let tesc_module = if params.tess_shader {
            Some(create_shader_module(device, binaries.get("tesc")?)?)
        } else {
            None
        };
        let tese_module = if params.tess_shader {
            Some(create_shader_module(device, binaries.get(&tese_shader_name(&params))?)?)
        } else {
            None
        };
        let geom_module = if params.geom_shader {
            Some(create_shader_module(device, binaries.get(&geom_shader_name(&params))?)?)
        } else {
            None
        };
        let frag_module = if params.frag_shader {
            Some(create_shader_module(device, binaries.get("frag")?)?)
        } else {
            None
        };

        let entry = c"main";
        let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let mut stages = Vec::new();
        if let Some(module) = &mesh_module {
            stages.push(make_stage(vk::ShaderStageFlags::MESH_EXT, **module));
        }
        if let Some(module) = &vert_module {
            stages.push(make_stage(vk::ShaderStageFlags::VERTEX, **module));
        }
        if let Some(module) = &tesc_module {
            stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, **module));
        }
        if let Some(module) = &tese_module {
            stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, **module));
        }
        if let Some(module) = &geom_module {
            stages.push(make_stage(vk::ShaderStageFlags::GEOMETRY, **module));
        }
        if let Some(module) = &frag_module {
            stages.push(make_stage(vk::ShaderStageFlags::FRAGMENT, **module));
        }

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();

        let topology = if params.tess_shader {
            vk::PrimitiveTopology::PATCH_LIST
        } else if params.lines {
            vk::PrimitiveTopology::LINE_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_STRIP
        };
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(topology)
            .primitive_restart_enable(false);
        let tessellation_state = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(4);

        let mut depth_clip_state =
            vk::PipelineRasterizationDepthClipStateCreateInfoEXT::builder().depth_clip_enable(params.depth_clip);
        // VUID-VkGraphicsPipelineCreateInfo-pDynamicState-09639
        let mut conservative_state = vk::PipelineRasterizationConservativeStateCreateInfoEXT::builder()
            .conservative_rasterization_mode(if params.conservative_rasterization_overestimate {
                vk::ConservativeRasterizationModeEXT::OVERESTIMATE
            } else {
                vk::ConservativeRasterizationModeEXT::DISABLED
            })
            .extra_primitive_overestimation_size(0.0);
        let mut rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(params.depth_clamp)
            .rasterizer_discard_enable(params.rasterizer_discard_enable)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(params.cull_mode)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(params.depth_bias_enable)
            .depth_bias_constant_factor(0.0)
            .depth_bias_clamp(0.0)
            .depth_bias_slope_factor(0.0)
            .line_width(1.0);
        if params.conservative_rasterization {
            rasterization_state = rasterization_state.push_next(&mut conservative_state);
        }
        if params.depth_clip {
            rasterization_state = rasterization_state.push_next(&mut depth_clip_state);
        }

        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .alpha_to_coverage_enable(false)
            .alpha_to_one_enable(params.alpha_to_one);

        let stencil_op = if params.stencil_test_enable {
            vk::StencilOp::REPLACE
        } else {
            vk::StencilOp::KEEP
        };
        let stencil_compare_op = if params.stencil_test_enable {
            vk::CompareOp::GREATER
        } else {
            vk::CompareOp::ALWAYS
        };
        let stencil_op_state = vk::StencilOpState {
            fail_op: stencil_op,
            pass_op: stencil_op,
            depth_fail_op: stencil_op,
            compare_op: stencil_compare_op,
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(params.depth_test_enable)
            .depth_write_enable(params.depth_write_enable)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(params.depth_bounds_test_enable)
            .stencil_test_enable(params.stencil_test_enable)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let color_blend_attachment = [vk::PipelineColorBlendAttachmentState {
            blend_enable: params.color_blend_enable as vk::Bool32,
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
        }];

        const COLOR_ATTACHMENT_COUNT: u32 = 2;
        let max_color_attachments = context.get_device_properties().limits.max_color_attachments;
        let color_write_enables: Vec<vk::Bool32> = (0..max_color_attachments)
            .map(|i| {
                if i < COLOR_ATTACHMENT_COUNT {
                    vk::TRUE
                } else {
                    vk::FALSE
                }
            })
            .collect();
        let mut color_write_state =
            vk::PipelineColorWriteCreateInfoEXT::builder().color_write_enables(&color_write_enables);
        let mut color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(params.logic_op_enable)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&color_blend_attachment)
            .blend_constants([0.0, 0.0, 0.0, 0.0]);
        if params.color_write {
            color_blend_state = color_blend_state.push_next(&mut color_write_state);
        }

        let viewport = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: 32.0,
            height: 32.0,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissor = [rect_2d(32, 32)];
        let viewport_and_scissor_count = if features.eds.extended_dynamic_state != vk::FALSE {
            0
        } else {
            1
        };
        let mut depth_clip_control_state =
            vk::PipelineViewportDepthClipControlCreateInfoEXT::builder().negative_one_to_one(true);
        let mut viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewport_count(viewport_and_scissor_count)
            .scissor_count(viewport_and_scissor_count);
        if viewport_and_scissor_count > 0 {
            viewport_state = viewport_state.viewports(&viewport).scissors(&scissor);
        }
        if params.depth_clip_control {
            viewport_state = viewport_state.push_next(&mut depth_clip_control_state);
        }

        let dynamic_states = get_dynamic_states(&params, features);
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let color_formats = [COLOR_FORMAT];
        let mut rendering_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(ds_format)
            .stencil_attachment_format(ds_format);

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .dynamic_state(&dynamic_state)
            .layout(pipeline_layout)
            .render_pass(vk::RenderPass::null())
            .subpass(0)
            .push_next(&mut rendering_info);
        if !params.mesh_shader {
            info = info
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state);
        }
        if params.tess_shader {
            info = info.tessellation_state(&tessellation_state);
        }

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }
}

impl TestInstance for StateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let features = query_features(context);
        let extensions = remove_unsupported_shader_object_extensions(context)?;
        let core = *context.get_device_features();
        let tessellation_supported = core.tessellation_shader != vk::FALSE;
        let geometry_supported = core.geometry_shader != vk::FALSE;
        let mesh_features = get_mesh_shader_features(context);

        let ds_format = find_ds_format(context);
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_range =
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
        let render_area = rect_2d(RENDER_SIZE, RENDER_SIZE);
        let second_draw = !params.depth_clamp && !params.depth_clip;
        let size = crate::tcu::IVec2::new(RENDER_SIZE as i32, RENDER_SIZE as i32);

        let image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D, COLOR_FORMAT, color_range)?;

        let mut depth_info = make_image_create_info(
            size,
            ds_format,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        );
        if params.sample_locations_enable {
            depth_info.flags |= vk::ImageCreateFlags::SAMPLE_LOCATIONS_COMPATIBLE_DEPTH_EXT;
        }
        let depth_image = ImageWithMemory::new(device, allocator, depth_info, MemoryRequirement::ANY)?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            ds_format,
            depth_range,
        )?;

        let color_output_buffer_size = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let color_output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::ALL_GRAPHICS | vk::ShaderStageFlags::MESH_EXT,
            )
            .build(device)?;
        let layout_handle = *descriptor_set_layout;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;

        let buffer_size_bytes = (std::mem::size_of::<u32>() * 8) as vk::DeviceSize;
        let descriptor_set1 = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
        let descriptor_set2 = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
        let output_buffer1 = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let output_buffer2 = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_info1 = [vk::DescriptorBufferInfo {
            buffer: output_buffer1.get(),
            offset: 0,
            range: buffer_size_bytes,
        }];
        let descriptor_info2 = [vk::DescriptorBufferInfo {
            buffer: output_buffer2.get(),
            offset: 0,
            range: buffer_size_bytes,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set1.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&descriptor_info1)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set2.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&descriptor_info2)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;

        let binaries = context.get_binary_collection();
        let mut pipeline = None;
        let (mut mesh_shader, mut vert_shader, mut tesc_shader, mut tese_shader, mut geom_shader, mut frag_shader) =
            (None, None, None, None, None, None);

        if params.pipeline {
            pipeline = Some(create_state_pipeline(
                context,
                params,
                *pipeline_layout,
                &features,
                ds_format,
            )?);
        } else {
            if params.mesh_shader {
                mesh_shader = Some(make_state_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::MESH_EXT,
                    &mesh_shader_name(&params),
                    tessellation_supported,
                    geometry_supported,
                    &layout_handle,
                    vk::ShaderCreateFlagsEXT::NO_TASK_SHADER,
                )?);
            }
            if params.vert_shader {
                vert_shader = Some(make_state_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::VERTEX,
                    &vertex_shader_name(&params),
                    tessellation_supported,
                    geometry_supported,
                    &layout_handle,
                    vk::ShaderCreateFlagsEXT::empty(),
                )?);
            }
            if params.tess_shader {
                tesc_shader = Some(make_state_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::TESSELLATION_CONTROL,
                    "tesc",
                    tessellation_supported,
                    geometry_supported,
                    &layout_handle,
                    vk::ShaderCreateFlagsEXT::empty(),
                )?);
                tese_shader = Some(make_state_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                    &tese_shader_name(&params),
                    tessellation_supported,
                    geometry_supported,
                    &layout_handle,
                    vk::ShaderCreateFlagsEXT::empty(),
                )?);
            }
            if params.geom_shader {
                geom_shader = Some(make_state_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::GEOMETRY,
                    &geom_shader_name(&params),
                    tessellation_supported,
                    geometry_supported,
                    &layout_handle,
                    vk::ShaderCreateFlagsEXT::empty(),
                )?);
            }
            if params.frag_shader {
                frag_shader = Some(make_state_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::FRAGMENT,
                    "frag",
                    tessellation_supported,
                    geometry_supported,
                    &layout_handle,
                    vk::ShaderCreateFlagsEXT::empty(),
                )?);
            }
        }

        let tf_buf_size = (4 * std::mem::size_of::<[f32; 4]>()) as vk::DeviceSize;
        let tf_buf = if params.geometry_streams {
            Some(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    tf_buf_size,
                    vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?)
        } else {
            None
        };
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );

        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 0.0],
            },
        };
        let clear_depth = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
        };

        begin_command_buffer(device, cmd)?;

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set1.get()],
                &[] as &[u32],
            )
        };

        let pre_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            color_range,
        );
        let pre_depth_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            depth_image.get(),
            depth_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_image_barrier],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_depth_barrier],
            );
        }

        let color_attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(*image_view)
            .image_layout(vk::ImageLayout::GENERAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_color)
            .build();
        let depth_attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(*depth_view)
            .image_layout(vk::ImageLayout::GENERAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_depth)
            .build();
        let color_attachments = [color_attachment];
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(render_area)
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_attachments)
            .depth_attachment(&depth_attachment)
            .stencil_attachment(&depth_attachment);
        unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };

        if let Some(pipeline) = &pipeline {
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline) };
        } else if params.mesh_shader {
            bind_null_rasterization_shaders(device, cmd, &core);
            let stages = [vk::ShaderStageFlags::MESH_EXT, vk::ShaderStageFlags::FRAGMENT];
            let shaders = [
                mesh_shader.as_ref().expect("mesh shader").get(),
                frag_shader.as_ref().expect("fragment shader").get(),
            ];
            unsafe { device.cmd_bind_shaders_ext(cmd, &stages, &shaders) };
        } else {
            let null = vk::ShaderEXT::null();
            let get = |shader: &Option<ShaderObject<'_>>| shader.as_ref().map(|shader| shader.get()).unwrap_or(null);
            bind_graphics_shaders(
                device,
                cmd,
                get(&vert_shader),
                get(&tesc_shader),
                get(&tese_shader),
                get(&geom_shader),
                get(&frag_shader),
                mesh_features.task_shader != vk::FALSE,
                mesh_features.mesh_shader != vk::FALSE,
            );
        }
        self.set_dynamic_states(cmd, &features, &extensions)?;

        if let Some(tf_buf) = &tf_buf {
            unsafe {
                device.cmd_bind_transform_feedback_buffers_ext(cmd, 0, &[tf_buf.get()], &[0], &[tf_buf_size]);
                (device.commands().cmd_begin_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
            }
        }

        unsafe {
            if params.mesh_shader {
                if second_draw {
                    device.cmd_draw_mesh_tasks_ext(cmd, 2, 1, 1);
                } else {
                    device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
                }
            } else {
                device.cmd_draw(cmd, 4, 1, 0, 0);
                if second_draw {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout,
                        0,
                        &[descriptor_set2.get()],
                        &[] as &[u32],
                    );
                    device.cmd_draw(cmd, 4, 1, 0, 1);
                }
            }
            if tf_buf.is_some() {
                (device.commands().cmd_end_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
            }
            device.cmd_end_rendering(cmd);
        }

        let post_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            image.get(),
            color_range,
        );
        let post_depth_barrier = make_image_memory_barrier(
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            depth_image.get(),
            depth_range,
        );
        let buffer_barrier1 = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer1.get(),
            0,
            buffer_size_bytes,
        );
        let buffer_barrier2 = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer2.get(),
            0,
            buffer_size_bytes,
        );
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            },
        };
        let copy_buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            color_output_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_image_barrier],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_depth_barrier],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier1],
                &[] as &[vk::ImageMemoryBarrier],
            );
            if second_draw {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier2],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            if tf_buf.is_some() {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::GENERAL,
                color_output_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[copy_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, color_output_buffer.get_allocation())?;
        let result = unsafe {
            std::slice::from_raw_parts(
                color_output_buffer.get_allocation().get_host_ptr().cast_const(),
                color_output_buffer_size as usize,
            )
        };

        let (width, height) = (RENDER_SIZE, RENDER_SIZE);
        let threshold = 1.0f32 / 256.0;
        let white_color = [0.75f32; 4];
        let black_color = [0.0f32; 4];

        invalidate_alloc(device, output_buffer1.get_allocation())?;
        let buffer_values: Vec<u32> = unsafe {
            std::slice::from_raw_parts(
                output_buffer1
                    .get_allocation()
                    .get_host_ptr()
                    .cast_const()
                    .cast::<u32>(),
                8,
            )
        }
        .to_vec();

        if let Some(tf_buf) = &tf_buf {
            invalidate_alloc(device, tf_buf.get_allocation())?;
            let tf_data = unsafe {
                std::slice::from_raw_parts(tf_buf.get_allocation().get_host_ptr().cast_const().cast::<f32>(), 16)
            };
            let count = if params.lines { 2 } else { 3 };
            for i in 0..count {
                for j in 0..4 {
                    if tf_data[i * 4 + j] != (i + 1) as f32 {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
            return Ok(TestStatus::pass("Pass"));
        }

        if params.vert_shader && buffer_values[0] != 1 {
            log::info!(
                "Buffer value at index 0 was expected to be 1, but was[{}]",
                buffer_values[0]
            );
            return Ok(TestStatus::fail("Fail"));
        }

        if params.tess_shader {
            if buffer_values[1] != 2 {
                log::info!(
                    "Buffer value at index 1 was expected to be 2, but was[{}]",
                    buffer_values[1]
                );
                return Ok(TestStatus::fail("Fail"));
            }
            if buffer_values[2] != 3 {
                log::info!(
                    "Buffer value at index 2 was expected to be 3, but was[{}]",
                    buffer_values[2]
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }

        if params.geom_shader && buffer_values[3] != 4 {
            log::info!(
                "Buffer value at index 3 was expected to be 4, but was[{}]",
                buffer_values[3]
            );
            return Ok(TestStatus::fail("Fail"));
        }

        let culled = if params.mesh_shader {
            vk::CullModeFlags::BACK
        } else {
            vk::CullModeFlags::FRONT
        };

        if params.frag_shader && !params.rasterizer_discard_enable {
            let dynamic_states = get_dynamic_states(&params, &features);
            let uses_src_one_dst_one_blending =
                (!params.pipeline && params.frag_shader && !params.rasterizer_discard_enable)
                    || self.has_dynamic_state(&dynamic_states, vk::DynamicState::COLOR_BLEND_EQUATION_EXT);

            for j in 0..height {
                for i in 0..width {
                    let offset = ((j * width + i) * 4) as usize;
                    let color = [0, 1, 2, 3].map(|channel| f32::from(result[offset + channel]) / 255.0);

                    let mut expected_color = black_color;
                    let inside = is_inside_primitive(&params, i, j, width, height);
                    if params.conservative_rasterization && params.conservative_rasterization_overestimate && !inside {
                        continue;
                    }
                    if inside
                        && ((params.cull_mode != vk::CullModeFlags::FRONT_AND_BACK && params.cull_mode != culled)
                            || params.lines)
                        && (!params.color_write || params.color_write_enable)
                        && !params.depth_bounds_test_enable
                        && (!params.depth_clip || i < 16)
                        && !params.discard_rectangles_enable
                    {
                        expected_color = white_color;
                        if params.alpha_to_one {
                            expected_color[3] = 1.0;
                        }
                        if params.color_blend_enable
                            && second_draw
                            && !params.logic_op_enable
                            && !params.stencil_test_enable
                            && uses_src_one_dst_one_blending
                        {
                            // using src_factor=ONE dst_factor=ONE blending from dynamic state; otherwise dst_factor=ZERO, so expect 'whiteColor'
                            expected_color = [1.0; 4];
                        }
                    }

                    if (0..4).any(|channel| (color[channel] - expected_color[channel]).abs() > threshold) {
                        log::info!("Color at ({i}, {j}) is expected to be ({expected_color:?}), but was ({color:?})");
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }

        if params.frag_shader && !params.rasterizer_discard_enable {
            let depth_buffer = read_depth_attachment(
                context,
                depth_image.get(),
                ds_format,
                (width, height),
                vk::ImageLayout::GENERAL,
            )?;
            let depth_access = depth_buffer.get_const_access();
            let stencil_buffer = read_stencil_attachment(
                context,
                depth_image.get(),
                ds_format,
                (width, height),
                vk::ImageLayout::GENERAL,
            )?;
            let stencil_access = stencil_buffer.get_const_access();

            let depth_epsilon = 0.02f32;
            for j in 0..height {
                for i in 0..width {
                    let depth = depth_access.get_pix_depth(i, j, 0);
                    let stencil = stencil_access.get_pix_stencil(i, j, 0);
                    let inside = is_inside_primitive(&params, i, j, width, height);
                    if params.conservative_rasterization && params.conservative_rasterization_overestimate && !inside {
                        continue;
                    }
                    if inside
                        && ((params.depth_test_enable && params.depth_write_enable) || params.stencil_test_enable)
                        && !params.depth_bounds_test_enable
                        && !params.discard_rectangles_enable
                        && ((params.cull_mode != vk::CullModeFlags::FRONT_AND_BACK && params.cull_mode != culled)
                            || params.lines)
                    {
                        let mut depth_min = 0.4 - depth_epsilon;
                        let mut depth_max = 0.6 + depth_epsilon;
                        if params.stencil_test_enable {
                            depth_min = 0.7 - depth_epsilon;
                            depth_max = 0.9 + depth_epsilon;
                        }
                        if params.depth_clamp {
                            depth_min = 0.35 - depth_epsilon;
                            depth_max = 0.45 + depth_epsilon;
                        }
                        if params.depth_clip {
                            depth_min = 0.9 - depth_epsilon;
                            depth_max = 1.0 + depth_epsilon;
                        }
                        if params.depth_clip_control {
                            depth_min = 0.7 - depth_epsilon;
                            depth_max = 1.0 + depth_epsilon;
                        }
                        if params.depth_bias_enable {
                            let bias = if params.lines { 0.004 } else { 0.03 };
                            depth_min += bias;
                            depth_max += bias;
                        }
                        if !params.depth_test_enable {
                            depth_min = 1.0 - depth_epsilon;
                            depth_max = 1.0 + depth_epsilon;
                        }

                        if depth < depth_min || depth > depth_max {
                            log::info!(
                                "Depth at ({i}, {j}) is expected to be between {depth_min} and {depth_max}, but was ({depth})"
                            );
                            return Ok(TestStatus::fail("Fail"));
                        }
                        if params.stencil_test_enable && (!params.depth_clip || i < 16) && stencil != 255 {
                            log::info!("Stencil at ({i}, {j}) is expected to be 255, but was ({stencil})");
                            return Ok(TestStatus::fail("Fail"));
                        }
                    } else {
                        if (depth - 1.0).abs() > depth_epsilon {
                            log::info!("Depth at ({i}, {j}) is expected to be 1.0f, but was ({depth})");
                            return Ok(TestStatus::fail("Fail"));
                        }
                        if params.stencil_test_enable && stencil != 0 {
                            log::info!("Stencil at ({i}, {j}) is expected to be 0, but was ({stencil})");
                            return Ok(TestStatus::fail("Fail"));
                        }
                    }
                }
            }
        }

        if params.mesh_shader && buffer_values[4] != 5 {
            log::info!(
                "Buffer value at index 4 was expected to be 5, but was[{}]",
                buffer_values[4]
            );
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `state` group of `createShaderObjectMiscTests`.
pub fn create_state_group() -> TestCaseGroup {
    struct StageSet {
        mesh: bool,
        vert: bool,
        tess: bool,
        geom: bool,
        frag: bool,
        name: &'static str,
    }

    let shaders_tests = [
        StageSet {
            mesh: false,
            vert: true,
            tess: false,
            geom: false,
            frag: false,
            name: "vert",
        },
        StageSet {
            mesh: false,
            vert: true,
            tess: false,
            geom: false,
            frag: true,
            name: "vert_frag",
        },
        StageSet {
            mesh: false,
            vert: true,
            tess: true,
            geom: false,
            frag: true,
            name: "vert_tess_frag",
        },
        StageSet {
            mesh: false,
            vert: true,
            tess: false,
            geom: true,
            frag: true,
            name: "vert_geom_frag",
        },
        StageSet {
            mesh: false,
            vert: true,
            tess: true,
            geom: true,
            frag: true,
            name: "vert_tess_geom_frag",
        },
        StageSet {
            mesh: true,
            vert: false,
            tess: false,
            geom: false,
            frag: true,
            name: "mesh_frag",
        },
    ];

    let case = |name: &str, params: StateParams| {
        Box::new(StateCase {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>
    };

    let mut state_group = TestCaseGroup::new("state");
    for (pipeline, pipeline_name) in [(false, "shaders"), (true, "pipeline")] {
        let mut pipeline_group = TestCaseGroup::new(pipeline_name);
        for shaders in &shaders_tests {
            let mut shaders_group = TestCaseGroup::new(shaders.name);
            let mut params = StateParams::new(
                pipeline,
                shaders.mesh,
                shaders.vert,
                shaders.tess,
                shaders.geom,
                shaders.frag,
            );

            let mut alpha_to_one_group = TestCaseGroup::new("alphaToOne");
            for (alpha_to_one, name) in [(false, "disabled"), (true, "enabled")] {
                params.alpha_to_one = alpha_to_one;
                alpha_to_one_group.add_child(case(name, params));
            }
            shaders_group.add_child(alpha_to_one_group);
            params.reset();

            // (depthTestEnable, depthWriteEnable, depthBounds, depthBoundsTestEnable, depthClamp, depthClip, depthClipControl, depthBiasEnable, name)
            let depth_tests: [(bool, bool, bool, bool, bool, bool, bool, bool, &str); 8] = [
                (false, false, false, false, false, false, false, false, "none"),
                (true, true, true, false, false, false, false, false, "bounds_disabled"),
                (true, true, true, true, false, false, false, false, "bounds_enabled"),
                (true, true, false, false, true, false, false, false, "clamp"),
                (true, true, false, false, false, true, false, false, "clip"),
                (true, true, false, false, false, false, true, false, "clip_control"),
                (true, true, false, false, false, false, false, true, "bias"),
                (
                    false,
                    true,
                    false,
                    false,
                    false,
                    false,
                    false,
                    false,
                    "test_disabled_write_enabled",
                ),
            ];
            let mut depth_group = TestCaseGroup::new("depth");
            for (
                depth_test_enable,
                _depth_write_enable,
                depth_bounds,
                depth_bounds_test_enable,
                depth_clamp,
                depth_clip,
                depth_clip_control,
                depth_bias_enable,
                name,
            ) in depth_tests
            {
                // upstream never assigns the table's depthWriteEnable
                params.depth_test_enable = depth_test_enable;
                params.depth_bounds = depth_bounds;
                params.depth_bounds_test_enable = depth_bounds_test_enable;
                params.depth_clamp = depth_clamp;
                params.depth_clip = depth_clip;
                params.depth_clip_control = depth_clip_control;
                params.depth_bias_enable = depth_bias_enable;
                depth_group.add_child(case(name, params));
            }
            shaders_group.add_child(depth_group);
            params.reset();

            let mut discard_rectangles_group = TestCaseGroup::new("discard_rectangles");
            for (discard_rectangles, enabled, name) in [
                (false, false, "disabled"),
                (true, false, "enabled"),
                (true, true, "discard"),
            ] {
                params.discard_rectangles = discard_rectangles;
                params.discard_rectangles_enable = enabled;
                discard_rectangles_group.add_child(case(name, params));
            }
            shaders_group.add_child(discard_rectangles_group);
            params.reset();

            let mut rasterization_discard_group = TestCaseGroup::new("rasterization_discard");
            for (enable, name) in [(false, "disabled"), (true, "enabled")] {
                params.rasterizer_discard_enable = enable;
                rasterization_discard_group.add_child(case(name, params));
            }
            shaders_group.add_child(rasterization_discard_group);
            params.reset();

            let mut color_blend_group = TestCaseGroup::new("color_blend");
            for (enable, name) in [(false, "disabled"), (true, "enabled")] {
                params.color_blend_enable = enable;
                color_blend_group.add_child(case(name, params));
            }
            shaders_group.add_child(color_blend_group);
            params.reset();

            let mut primitives_group = TestCaseGroup::new("primitives");
            for (lines, name) in [(false, "triangles"), (true, "lines")] {
                params.lines = lines;
                primitives_group.add_child(case(name, params));
            }
            shaders_group.add_child(primitives_group);
            params.reset();

            let mut stencil_group = TestCaseGroup::new("stencil");
            for (enable, name) in [(false, "disabled"), (true, "enabled")] {
                params.stencil_test_enable = enable;
                stencil_group.add_child(case(name, params));
            }
            shaders_group.add_child(stencil_group);
            params.reset();

            let mut logic_op_group = TestCaseGroup::new("logic_op");
            for (logic_op, logic_op_enable, name) in [
                (false, false, "disabled"),
                (true, false, "enabled"),
                (true, true, "copy"),
            ] {
                params.logic_op = logic_op;
                params.logic_op_enable = logic_op_enable;
                logic_op_group.add_child(case(name, params));
            }
            shaders_group.add_child(logic_op_group);
            params.reset();

            if shaders.geom {
                let mut geometry_streams_group = TestCaseGroup::new("geometry_streams");
                for (geometry_streams, name) in [(false, "disabled"), (true, "enabled")] {
                    params.geometry_streams = geometry_streams;
                    geometry_streams_group.add_child(case(name, params));
                }
                shaders_group.add_child(geometry_streams_group);
                params.reset();
            }

            let mut provoking_vertex_group = TestCaseGroup::new("provoking_vertex");
            for (provoking_vertex, name) in [(false, "disabled"), (true, "enabled")] {
                params.provoking_vertex = provoking_vertex;
                provoking_vertex_group.add_child(case(name, params));
            }
            shaders_group.add_child(provoking_vertex_group);
            params.reset();

            let mut sample_locations_group = TestCaseGroup::new("sample_locations");
            for (sample_locations, enable, name) in [
                (false, false, "disabled"),
                (true, false, "enabled"),
                (true, true, "used"),
            ] {
                params.sample_locations = sample_locations;
                params.sample_locations_enable = enable;
                sample_locations_group.add_child(case(name, params));
            }
            shaders_group.add_child(sample_locations_group);
            params.reset();

            // The parameters carry over from one entry of the lines table to the next, as they do upstream.
            let mut lines_group = TestCaseGroup::new("lines");
            for (line_rasterization, stippled_line_enable, name) in [
                (false, false, "default"),
                (true, false, "rectangular"),
                (true, true, "rectangular_stippled"),
            ] {
                params.lines = true;
                params.stippled_line_enable = stippled_line_enable;
                params.line_rasterization = line_rasterization;
                lines_group.add_child(case(name, params));

                params.rasterizer_discard_enable = true;
                lines_group.add_child(case(&format!("{name}_rasterizer_discard"), params));

                params.discard_rectangles_enable = false;
                params.lines = false;
                lines_group.add_child(case(&format!("{name}_topology_triangles"), params));
            }
            shaders_group.add_child(lines_group);
            params.reset();

            let mut cull_group = TestCaseGroup::new("cull");
            for (cull_mode, name) in [
                (vk::CullModeFlags::NONE, "none"),
                (vk::CullModeFlags::FRONT, "front"),
                (vk::CullModeFlags::BACK, "back"),
                (vk::CullModeFlags::FRONT_AND_BACK, "front_and_back"),
            ] {
                params.cull_mode = cull_mode;
                cull_group.add_child(case(name, params));
            }
            shaders_group.add_child(cull_group);
            params.reset();

            let mut conservative_group = TestCaseGroup::new("conservative_rasterization");
            for (conservative, overestimate, name) in [
                (false, false, "disabled"),
                (true, false, "enabled"),
                (true, true, "overestimate"),
            ] {
                params.conservative_rasterization = conservative;
                params.conservative_rasterization_overestimate = overestimate;
                conservative_group.add_child(case(name, params));
            }
            shaders_group.add_child(conservative_group);
            params.reset();

            let mut color_write_group = TestCaseGroup::new("color_write");
            for (color_write, color_write_enable, name) in
                [(false, false, "disabled"), (true, false, "false"), (true, true, "true")]
            {
                params.color_write = color_write;
                params.color_write_enable = color_write_enable;
                color_write_group.add_child(case(name, params));
            }
            shaders_group.add_child(color_write_group);
            params.reset();

            pipeline_group.add_child(shaders_group);
        }
        state_group.add_child(pipeline_group);
    }
    state_group
}
