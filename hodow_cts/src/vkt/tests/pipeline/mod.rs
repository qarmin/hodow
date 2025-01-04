// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream repeats the whole group once per `PipelineConstructionType` (monolithic, link-time-optimized and
// fast-linked pipeline libraries, six flavours of shader objects) through `GraphicsPipelineWrapper`. The `monolithic` and the
// two library repetitions are ported (the four shader object ones only for `sampler`, `image`, `image_view` and (unlinked SPIR-V) `stencil` and `depth`, see `create_shader_object_children`): the library ones run the same cases with `obj_util`'s pipeline helpers (which read the
// ambient `vk::pipeline_construction` type) linking the pipeline from libraries, so a case that builds its pipeline some other way
// stays monolithic inside them, and a chained structure other than the dynamic rendering info is dropped from the libraries. The
// shader object repetitions are not. Ported: `dynamic_control_points`, `dynamic_vertex_attribute`, `early_destroy`, `input_attribute_offset`, `matched_attachments`, `derivative`, `empty_fs`, `logic_op` (and `logic_op_na_formats`), `bind_point` (graphics + compute pair only), `color_write_enable`, `color_write_enable_maxa`, `depth_range_unrestricted`, `dynamic_offset`, `descriptor_limits`, `misc` and `shader_stencil_export`, `srgb_vertex_formats` `resolve.renderpass_renderarea`, `sliced_view_of_3d_image` and `no_position` (without the device group variant) `executable_properties`, `creation_cache_control`, `extended_dynamic_state.misc`, `bind_buffers_2` (without the robustness2 variants) `vertex_input.legacy_vertex_attributes` (without the `_dac` variants) `cache` (cache mode only) `pipeline_binary.dedicated` (monolithic, without the ray tracing cases; the `basic` groups are `cache_tests` and `creation_feedback` is `creation_feedback_tests`, both in binary mode) `image_2d_view_3d_image` (sparse variants bind on the universal queue), `framebuffer_attachment`, `render_to_image`, `push_constant` and `timestamp` (the transfer-only queue cases run on the default device's transfer queue), `depth` `stencil` `input_assembly` (`primitive_topology` and `primitive_restart` without the amber cases) and `blend` (`format`, `clamp` and `dual_source.format`) `blend_operation_advanced` (all three groups) `interface_matching` (with `shader_layout_component_matching`) `max_varyings` (GLSL in place of upstream's SPIR-V text) and `primitive_restart_index` (without the device address draw calls upstream leaves out too) `spec_constant` `multisample` (see `multisample_tests` and `multisample_image_tests`) `multisample_shader_builtin` `multisample.{sample_locations_ext,std_sample_locations,variable_rate,mixed_count,a2c_with_a2one,z_export,compatible_render_pass,sample_rate_a2c}` (without fragment shading rate) `multisample_interpolation` (without the amber `reinterpolation_consistency` and `nonuniform_interpolant_indexing` groups). `sampler` (`view_type` and `separate_stencil_usage`, the min and max reduction cases as stubs) is built on `image_sampling_instance`, which `image_util` (the test textures) and the shaders of `pipeline_sampler.toml` serve. `pipeline_util.rs` holds what the groups that compare against the software renderer share.

pub mod a2c_with_a2one_tests;
pub mod attachment_feedback_loop_layout_tests;
pub mod binary_tests;
pub mod bind_point_tests;
pub mod bind_vertex_buffers2_tests;
pub mod blend_dynamic_tests;
pub mod blend_operation_advanced_tests;
pub mod blend_tests;
pub mod cache_tests;
pub mod color_write_enable_tests;
pub mod compatible_render_pass_tests;
pub mod component_decorated_tests;
pub mod creation_cache_control_tests;
pub mod creation_feedback_tests;
pub mod depth_only_tests;
pub mod depth_range_unrestricted_tests;
pub mod depth_tests;
pub mod depth_xfer_layout_tests;
pub mod derivative_tests;
pub mod descriptor_limits_tests;
pub mod dynamic_control_points_tests;
pub mod dynamic_offset_mixed_tests;
pub mod dynamic_offset_tests;
pub mod dynamic_vertex_attribute_tests;
pub mod early_destroy_tests;
pub mod empty_fs_tests;
pub mod executable_properties_tests;
pub mod extended_dynamic_state_basic_tests;
pub mod extended_dynamic_state_misc_tests;
pub mod framebuffer_attachment_tests;
pub mod fsr_ambient;
pub mod graphics_library_tests;
pub mod image_2d_view_of_3d_tests;
pub mod image_format_lists;
pub mod image_sampling_instance;
pub mod image_tests;
pub mod image_util;
pub mod image_view_tests;
pub mod input_assembly_null_state_tests;
pub mod input_assembly_tests;
pub mod input_attribute_offset_tests;
pub mod interface_matching_tests;
pub mod legacy_vertex_attributes_tests;
pub mod logic_op_tests;
pub mod matched_attachments_tests;
pub mod max_varyings_tests;
pub mod misc_tests;
pub mod multisample_image_tests;
pub mod multisample_interpolation_tests;
pub mod multisample_mixed_attachment_samples_tests;
pub mod multisample_resolve_maint10_tests;
pub mod multisample_resolve_render_area_tests;
pub mod multisample_shader_builtin_tests;
pub mod multisample_shader_fragment_mask_tests;
pub mod multisample_tests;
pub mod no_position_tests;
pub mod no_queues_tests;
pub mod pipeline_util;
pub mod primitive_restart_index_tests;
pub mod primitive_restart_mix_tests;
pub mod push_constant_tests;
pub mod push_descriptor_tests;
pub mod render_to_image_tests;
pub mod robustness_cache_tests;
pub mod sample_locations_draw_tests;
pub mod sample_locations_tests;
pub mod sample_rate_a2c_tests;
pub mod sampler_border_swizzle_tests;
pub mod sampler_exact_tests;
pub mod sampler_tests;
pub mod shader_module_identifier_tests;
pub mod shader_object_draw;
pub mod sliced_view_of_3d_tests;
pub mod spec_constant_asm_tests;
pub mod spec_constant_tests;
pub mod stencil_export_tests;
pub mod stencil_no_att_tests;
pub mod stencil_tests;
pub mod timestamp_calibrated_tests;
pub mod timestamp_tests;
pub mod variable_rate_tests;
pub mod vertex_input_cases;
pub mod vertex_input_formats;
pub mod vertex_input_misc_tests;
pub mod vertex_input_srgb_tests;
pub mod vertex_input_tests;
pub mod z_export_tests;

use crate::vk::pipeline_construction::{PipelineConstructionType, with_construction_type as wrap_construction_type};
use crate::vkt::TestCaseGroup;

/// `createChildren` for one pipeline construction type. Upstream leaves some groups out of the library variants: `derivative`,
/// `creation_cache_control`, `sliced_view_of_3d_image` and the robustness cache cases exist for monolithic pipelines only.
fn create_children(construction: PipelineConstructionType) -> TestCaseGroup {
    let monolithic = construction == PipelineConstructionType::Monolithic;
    let mut group = TestCaseGroup::new(construction.group_name());
    group.add_child(dynamic_control_points_tests::create_dynamic_control_point_tests());
    {
        let mut stencil = stencil_tests::create_stencil_tests();
        if monolithic || construction == PipelineConstructionType::FastLinkedLibrary {
            stencil.add_child(stencil_no_att_tests::create_no_stencil_att_tests(construction));
        }
        group.add_child(stencil);
    }
    {
        let mut blend = blend_tests::create_blend_tests();
        blend.add_child(blend_dynamic_tests::create_dynamic_dual_disable_tests(construction));
        blend.add_child(blend_dynamic_tests::create_drlr_remap_tests(construction));
        group.add_child(blend);
    }
    group.add_child(blend_operation_advanced_tests::create_blend_operation_advanced_tests());
    group.add_child(interface_matching_tests::create_interface_matching_tests());
    {
        let mut depth = depth_tests::create_depth_tests();
        if monolithic {
            depth.add_child(depth_xfer_layout_tests::create_xfer_queue_layout_tests());
        }
        if monolithic || construction == PipelineConstructionType::FastLinkedLibrary {
            depth.add_child(depth_only_tests::create_depth_only_tests(construction));
        }
        group.add_child(depth);
    }
    group.add_child(dynamic_vertex_attribute_tests::create_dynamic_vertex_attribute_tests());
    group.add_child(early_destroy_tests::create_early_destroy_tests(construction));
    group.add_child(logic_op_tests::create_logic_op_tests());
    group.add_child(logic_op_tests::create_logic_op_inapplicable_formats_tests());
    group.add_child(matched_attachments_tests::create_matched_attachments_tests());
    if monolithic {
        group.add_child(derivative_tests::create_derivative_tests());
    }
    group.add_child(input_attribute_offset_tests::create_input_attribute_offset_tests());
    group.add_child(empty_fs_tests::create_empty_fs_tests());
    group.add_child(bind_point_tests::create_bind_point_tests());
    group.add_child(bind_vertex_buffers2_tests::create_cmd_bind_buffers2_tests());
    group.add_child(color_write_enable_tests::create_color_write_enable_tests());
    group.add_child(color_write_enable_tests::create_color_write_enable2_tests());
    group.add_child(depth_range_unrestricted_tests::create_depth_range_unrestricted_tests());
    group.add_child(dynamic_offset_tests::create_dynamic_offset_tests());
    group.add_child(descriptor_limits_tests::create_descriptor_limits_tests());
    group.add_child(misc_tests::create_misc_tests(false));
    group.add_child(no_position_tests::create_no_position_tests());
    group.add_child(executable_properties_tests::create_executable_properties_tests());
    if let Some(identifier_tests) = shader_module_identifier_tests::create_shader_module_identifier_tests(construction)
    {
        group.add_child(identifier_tests);
    }
    group.add_child(attachment_feedback_loop_layout_tests::create_attachment_feedback_loop_layout_tests(construction));
    if let Some(library_tests) = graphics_library_tests::create_graphics_library_tests(construction) {
        group.add_child(library_tests);
    }
    if monolithic {
        group.add_child(creation_cache_control_tests::create_cache_control_tests());
    }
    {
        // `misc` and most of the ordering groups (monolithic pipelines only) are ported; see extended_dynamic_state_basic_tests.rs for what is missing.
        let mut extended_dynamic_state = TestCaseGroup::new("extended_dynamic_state");
        extended_dynamic_state.add_child(extended_dynamic_state_misc_tests::create_extended_dynamic_state_misc_tests());
        extended_dynamic_state_basic_tests::add_extended_dynamic_state_basic_groups(&mut extended_dynamic_state);
        group.add_child(extended_dynamic_state);
    }
    group.add_child(framebuffer_attachment_tests::create_framebuffer_attachment_tests(false));
    group.add_child(image_2d_view_of_3d_tests::create_image_2d_view_of_3d_tests());
    if monolithic {
        group.add_child(sliced_view_of_3d_tests::create_sliced_view_of_3d_tests());
    }
    group.add_child(stencil_export_tests::create_stencil_export_tests());
    group.add_child(spec_constant_tests::create_spec_constant_tests_for(monolithic));
    {
        // Of upstream's `multisample` only `resolve.renderpass_renderarea` and what `multisample_tests` lists are ported.
        let mut multisample = TestCaseGroup::new("multisample");
        multisample_tests::add_multisample_tests(&mut multisample);
        multisample_image_tests::add_multisample_image_tests(&mut multisample);
        sample_locations_tests::add_sample_locations_tests(&mut multisample);
        variable_rate_tests::add_variable_rate_tests(&mut multisample);
        a2c_with_a2one_tests::add_a2c_with_a2one_tests(&mut multisample);
        sample_locations_tests::add_sample_locations_tests_shader_object(&mut multisample);
        z_export_tests::add_z_export_tests(&mut multisample);
        compatible_render_pass_tests::add_compatible_render_pass_tests(&mut multisample);
        sample_rate_a2c_tests::add_sample_rate_a2c_tests(&mut multisample);
        multisample.add_child(
            multisample_resolve_render_area_tests::create_multisample_resolve_renderpass_render_area_tests(),
        );
        multisample.add_child(multisample_resolve_maint10_tests::create_multisample_resolve_maint10_tests(false));
        multisample_tests::add_conservative_with_full_coverage_tests(&mut multisample, false);
        multisample.add_child(
            multisample_mixed_attachment_samples_tests::create_multisample_mixed_attachment_samples_tests(false),
        );
        multisample_tests::add_sample_mask_with_depth_test_tests(&mut multisample, false);
        multisample
            .add_child(multisample_shader_fragment_mask_tests::create_multisample_shader_fragment_mask_tests(false));
        group.add_child(multisample);
    }
    {
        // `createMultisampleTests(.., useFragmentShadingRate = true)`: the same groups with fragment shading rate state on the pipelines
        // (`fsr_ambient`). Upstream does not repeat the multisample image groups, `z_export`, `a2c_with_a2one`, `sample_rate_a2c` and
        // `resolve`, and leaves the `query` cases of `sample_locations_ext` to the plain group.
        let mut multisample = TestCaseGroup::new("multisample_with_fragment_shading_rate");
        multisample_tests::add_multisample_tests(&mut multisample);
        sample_locations_tests::add_sample_locations_tests_without_queries(&mut multisample);
        variable_rate_tests::add_variable_rate_tests(&mut multisample);
        compatible_render_pass_tests::add_compatible_render_pass_tests(&mut multisample);
        multisample_tests::add_conservative_with_full_coverage_tests(&mut multisample, true);
        multisample.add_child(
            multisample_mixed_attachment_samples_tests::create_multisample_mixed_attachment_samples_tests(true),
        );
        multisample_tests::add_sample_mask_with_depth_test_tests(&mut multisample, true);
        group.add_child(fsr_ambient::with_fragment_shading_rate(multisample));
    }
    {
        // Of upstream's `vertex_input` everything but the shader object repetitions (`single_attribute` and `component_mismatch` aside) is ported: `single_attribute`, `multiple_attributes`, `max_attributes`, `component_mismatch`, `legacy_vertex_attributes` (without a working `_dac` variant), `misc` and `srgb_vertex_formats`.
        let mut vertex_input = TestCaseGroup::new("vertex_input");
        vertex_input_tests::add_vertex_input_attribute_tests(&mut vertex_input, construction);
        vertex_input.add_child(legacy_vertex_attributes_tests::create_legacy_vertex_attributes_tests());
        vertex_input.add_child(vertex_input_misc_tests::create_vertex_input_misc_tests(false));
        vertex_input.add_child(vertex_input_srgb_tests::create_vertex_input_srgb_tests());
        group.add_child(vertex_input);
    }
    group.add_child(multisample_interpolation_tests::create_multisample_interpolation_tests());
    group.add_child(multisample_shader_builtin_tests::create_multisample_shader_builtin_tests());
    group.add_child(input_assembly_tests::create_input_assembly_tests());
    group.add_child(primitive_restart_index_tests::create_primitive_restart_index_tests());
    group.add_child(max_varyings_tests::create_max_varyings_tests());
    group.add_child(push_constant_tests::create_push_constant_tests());
    group.add_child(push_descriptor_tests::create_push_descriptor_tests());
    group.add_child(render_to_image_tests::create_render_to_image_tests());
    group.add_child(cache_tests::create_cache_tests());
    group.add_child(binary_tests::create_pipeline_binary_tests());
    group.add_child(timestamp_tests::create_timestamp_tests());
    group.add_child(creation_feedback_tests::create_creation_feedback_tests());
    group.add_child(sampler_tests::create_sampler_tests(monolithic, construction));
    if monolithic {
        group.add_child(image_tests::create_image_tests(false));
        group.add_child(image_view_tests::create_image_view_tests());
    }
    if monolithic {
        group.add_child(robustness_cache_tests::create_pipeline_robustness_cache_tests());
    }
    if monolithic {
        group
    } else {
        wrap_construction_type(group, construction)
    }
}

/// The repetition for a shader object construction type. Only the groups that record their own draws (`sampler`, `image` and
/// `image_view`, on `ImageSamplingInstance`) have a shader object variant; `genAllTests` is the unlinked SPIR-V type.
fn create_shader_object_children(construction: PipelineConstructionType) -> TestCaseGroup {
    let all_tests = construction == PipelineConstructionType::ShaderObjectUnlinkedSpirv;
    let mut group = TestCaseGroup::new(construction.group_name());
    group.add_child(sampler_tests::create_sampler_tests(all_tests, construction));
    group.add_child(blend_tests::create_blend_tests_for(all_tests));
    group.add_child(blend_operation_advanced_tests::create_blend_operation_advanced_tests());
    group.add_child(depth_range_unrestricted_tests::create_depth_range_unrestricted_tests());
    group.add_child(input_attribute_offset_tests::create_input_attribute_offset_tests());
    group.add_child(logic_op_tests::create_logic_op_tests());
    group.add_child(logic_op_tests::create_logic_op_inapplicable_formats_tests());
    group.add_child(interface_matching_tests::create_interface_matching_tests());
    group.add_child(spec_constant_tests::create_spec_constant_tests_for(false));
    group.add_child(bind_point_tests::create_bind_point_tests());
    group.add_child(no_position_tests::create_no_position_tests_for(true));
    group.add_child(cache_tests::create_cache_tests_for(true));
    group.add_child(multisample_interpolation_tests::create_multisample_interpolation_tests());
    group.add_child(bind_vertex_buffers2_tests::create_cmd_bind_buffers2_tests_for(true));
    group.add_child(max_varyings_tests::create_max_varyings_tests());
    group.add_child(push_descriptor_tests::create_push_descriptor_tests_for(true));
    group.add_child(push_constant_tests::create_push_constant_tests_for(true));
    group.add_child(image_2d_view_of_3d_tests::create_image_2d_view_of_3d_tests_for(true));
    group.add_child(dynamic_offset_tests::create_dynamic_offset_tests_for(true));
    group.add_child(descriptor_limits_tests::create_descriptor_limits_tests_for(true));
    group.add_child(timestamp_tests::create_timestamp_tests_for(true));
    group.add_child(input_assembly_tests::create_input_assembly_tests_for(true, all_tests));
    group.add_child(color_write_enable_tests::create_color_write_enable_tests_for(true));
    group.add_child(stencil_export_tests::create_stencil_export_tests());
    group.add_child(empty_fs_tests::create_empty_fs_tests());
    group.add_child(dynamic_control_points_tests::create_dynamic_control_point_tests());
    group.add_child(dynamic_vertex_attribute_tests::create_dynamic_vertex_attribute_tests());
    group.add_child(early_destroy_tests::create_early_destroy_tests(construction));
    group.add_child(misc_tests::create_misc_tests(true));
    group.add_child(color_write_enable_tests::create_color_write_enable2_tests());
    group.add_child(render_to_image_tests::create_render_to_image_tests());
    group.add_child(framebuffer_attachment_tests::create_framebuffer_attachment_tests(true));
    {
        let mut vertex_input = TestCaseGroup::new("vertex_input");
        vertex_input_tests::add_vertex_input_attribute_tests(&mut vertex_input, construction);
        vertex_input.add_child(vertex_input_misc_tests::create_vertex_input_misc_tests(true));
        vertex_input.add_child(vertex_input_srgb_tests::create_vertex_input_srgb_tests());
        group.add_child(vertex_input);
    }
    {
        let mut multisample = TestCaseGroup::new("multisample");
        multisample_tests::add_multisample_tests_for(&mut multisample, true);
        multisample_image_tests::add_multisample_image_tests_for(&mut multisample, true);
        a2c_with_a2one_tests::add_a2c_with_a2one_tests(&mut multisample);
        z_export_tests::add_z_export_tests(&mut multisample);
        sample_locations_tests::add_sample_locations_tests_shader_object(&mut multisample);
        variable_rate_tests::add_variable_rate_tests(&mut multisample);
        multisample.add_child(multisample_resolve_maint10_tests::create_multisample_resolve_maint10_tests(true));
        multisample
            .add_child(multisample_shader_fragment_mask_tests::create_multisample_shader_fragment_mask_tests(true));
        multisample_tests::add_sample_mask_with_depth_test_tests(&mut multisample, false);
        multisample.add_child(
            multisample_mixed_attachment_samples_tests::create_multisample_mixed_attachment_samples_tests(false),
        );
        group.add_child(multisample);
    }
    group.add_child(attachment_feedback_loop_layout_tests::create_attachment_feedback_loop_layout_tests(construction));
    {
        let mut multisample = TestCaseGroup::new("multisample_with_fragment_shading_rate");
        multisample_tests::add_multisample_tests_for(&mut multisample, true);
        sample_locations_tests::add_sample_locations_tests_shader_object(&mut multisample);
        variable_rate_tests::add_variable_rate_tests(&mut multisample);
        multisample_tests::add_sample_mask_with_depth_test_tests(&mut multisample, true);
        multisample.add_child(
            multisample_mixed_attachment_samples_tests::create_multisample_mixed_attachment_samples_tests(true),
        );
        group.add_child(fsr_ambient::with_fragment_shading_rate(multisample));
    }
    {
        let mut extended_dynamic_state = TestCaseGroup::new("extended_dynamic_state");
        extended_dynamic_state_basic_tests::add_extended_dynamic_state_basic_groups_for(
            &mut extended_dynamic_state,
            true,
        );
        group.add_child(extended_dynamic_state);
    }
    if all_tests {
        group.add_child(primitive_restart_index_tests::create_primitive_restart_index_tests());
        group.add_child(stencil_tests::create_stencil_tests());
        group.add_child(depth_tests::create_depth_tests());
        group.add_child(image_tests::create_image_tests(true));
        group.add_child(image_view_tests::create_image_view_tests());
    }
    wrap_construction_type(group, construction)
}

/// `createTests` - the `pipeline` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pipeline");
    group.add_child(no_queues_tests::create_no_queues_tests());
    group.add_child(create_children(PipelineConstructionType::Monolithic));
    group.add_child(create_children(PipelineConstructionType::LinkTimeOptimizedLibrary));
    group.add_child(create_children(PipelineConstructionType::FastLinkedLibrary));
    group.add_child(create_shader_object_children(
        PipelineConstructionType::ShaderObjectUnlinkedSpirv,
    ));
    group.add_child(create_shader_object_children(
        PipelineConstructionType::ShaderObjectUnlinkedBinary,
    ));
    group.add_child(create_shader_object_children(
        PipelineConstructionType::ShaderObjectLinkedSpirv,
    ));
    group.add_child(create_shader_object_children(
        PipelineConstructionType::ShaderObjectLinkedBinary,
    ));
    group
}
