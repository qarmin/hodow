// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Most ported groups here use no shader and hand back an empty `BinaryCollection`;
// `memory_commitment_tests` is the exception and has `shaders/manifest/api_memory_commitment.toml`
// (its generated module must exist before this subtree compiles: `just cts-shaders`); so does `smoke_tests`
// (`api_smoke.toml`).

pub mod address_binding_report_tests;
pub mod array_tests;
pub mod blitting_tests;
pub mod buffer_marker_tests;
pub mod buffer_memory_requirements_tests;
pub mod buffer_view_access_tests;
pub mod case_util;
pub mod command_buffers_indirect_tests;
pub mod command_buffers_many_draws_tests;
pub mod command_buffers_mix_tests;
pub mod command_buffers_nested_tests;
pub mod command_buffers_order_tests;
pub mod command_buffers_render_pass_tests;
pub mod command_buffers_simul_tests;
pub mod command_buffers_tests;
pub mod compressed_image_to_buffer_tests;
pub mod copies_buffer_tests;
pub mod copies_image_tests;
pub mod copy_blit_dynamic_state_tests;
pub mod copy_blit_reinterpret_tests;
pub mod copy_format_lists;
pub mod copy_image_misc_tests;
pub mod copy_indirect_util;
pub mod copy_memory_indirect_tests;
pub mod copy_multiplane_image_transfer_queue_tests;
pub mod counting_allocator;
pub mod debug_utils_tests;
pub mod depth_stencil_msaa_copy_tests;
pub mod descriptor_pool_tests;
pub mod descriptor_set_tests;
pub mod device_address_misc_tests;
pub mod device_drm_properties_tests;
pub mod device_init_extra_tests;
pub mod device_init_tests;
pub mod device_memory_report_tests;
pub mod driver_properties_tests;
pub mod ds_color_copy_tests;
pub mod extension_core_versions_tests;
pub mod extension_duplicates_tests;
pub mod external_memory_tests;
pub mod feature_bits_influence_tests;
pub mod feature_bits_table;
pub mod feature_info_tests;
pub mod feature_struct_list;
pub mod fill_and_update_buffer_tests;
pub mod fragment_shader_output_tests;
pub mod frame_boundary_tests;
pub mod get_device_proc_addr_names;
pub mod get_device_proc_addr_tests;
pub mod gpa_interface_tests;
pub mod granularity_tests;
pub mod image_clearing_formats;
pub mod image_clearing_tests;
pub mod image_compression_control_tests;
pub mod limits_validation12_tests;
pub mod limits_validation_tests;
pub mod maintenance3_tests;
pub mod maintenance5_format_tests;
pub mod maintenance_tests;
pub mod memory_commitment_tests;
pub mod memory_requirement_invariance_tests;
pub mod memory_to_image_indirect_tests;
pub mod null_handle_tests;
pub mod object_management_tests;
pub mod object_tests;
pub mod performance_counters_by_region_tests;
pub mod pipeline_tests;
pub mod promoted_structures_tests;
pub mod resolve_image_tests;
pub mod smoke_tests;
pub mod smoke_triangle_tests;
pub mod tooling_info_tests;
pub mod unsupported_feature_names;
pub mod unsupported_feature_vendor_structs;
pub mod unsupported_features_tests;
pub mod use_after_copy_tests;
pub mod version_check_tests;
pub mod vulkan14_property_consistency_tests;
pub mod vulkan_feature_consistency_tests;
pub mod vulkan_features_tests;
pub mod vulkan_properties_tests;
pub mod vulkan_property_consistency_tests;

use crate::vkt::TestCaseGroup;

/// `createApiTests`.
///
/// The groups upstream registers here that are absent - copy_and_blit,
/// image_clearing, descriptor_set, external, ... - are absent rather than
/// present-and-skipped, so a comparison against `deqp-vk` reports them as missing
/// instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut api_tests = TestCaseGroup::new("api");

    api_tests.add_child(version_check_tests::create_version_sanity_check_tests());
    api_tests.add_child(debug_utils_tests::create_debug_utils_tests());
    api_tests.add_child(driver_properties_tests::create_driver_properties_tests());
    api_tests.add_child(device_drm_properties_tests::create_device_drm_properties_tests());
    api_tests.add_child(smoke_tests::create_smoke_tests());
    api_tests.add_child(device_init_tests::create_device_initialization_tests());

    api_tests.add_child(command_buffers_tests::create_command_buffers_tests());
    api_tests.add_child(copies_buffer_tests::create_buffer_copy_tests());
    api_tests.add_child(ds_color_copy_tests::create_ds_color_copy_tests());
    api_tests.add_child(image_clearing_tests::create_image_clearing_tests());
    api_tests.add_child(fill_and_update_buffer_tests::create_fill_and_update_buffer_tests());
    api_tests.add_child(device_address_misc_tests::create_device_address_commands_tests());
    api_tests.add_child(gpa_interface_tests::create_gpa_interface_tests());
    api_tests.add_child(descriptor_pool_tests::create_descriptor_pool_tests());
    api_tests.add_child(null_handle_tests::create_null_handle_tests());
    api_tests.add_child(granularity_tests::create_granularity_query_tests());
    api_tests.add_child(memory_commitment_tests::create_memory_commitment_tests());
    api_tests.add_child(maintenance3_tests::create_maintenance3_tests());
    api_tests.add_child(memory_requirement_invariance_tests::create_memory_requirement_invariance_tests());
    api_tests.add_child(tooling_info_tests::create_tooling_info_tests());
    api_tests.add_child(buffer_marker_tests::create_buffer_marker_tests());
    api_tests.add_child(buffer_memory_requirements_tests::create_buffer_memory_requirements_tests());
    api_tests.add_child(frame_boundary_tests::create_frame_boundary_tests());
    api_tests.add_child(get_device_proc_addr_tests::create_get_device_proc_addr_tests());
    api_tests.add_child(maintenance_tests::create_maintenance6_tests());
    api_tests.add_child(maintenance5_format_tests::create_maintenance5_tests());
    api_tests.add_child(maintenance_tests::create_maintenance7_tests());
    api_tests.add_child(extension_duplicates_tests::create_extension_duplicates_tests());
    api_tests.add_child(array_tests::create_array_tests());
    api_tests.add_child(maintenance_tests::create_maintenance11_tests());
    api_tests.add_child(performance_counters_by_region_tests::create_performance_counters_by_region_tests());
    api_tests.add_child(image_compression_control_tests::create_image_compression_control_tests());
    api_tests.add_child(descriptor_set_tests::create_descriptor_set_tests());
    api_tests.add_child(pipeline_tests::create_pipeline_tests());
    api_tests.add_child(fragment_shader_output_tests::create_fragment_shader_output_tests());

    api_tests.add_child(object_management_tests::create_object_management_tests());
    api_tests.add_child(external_memory_tests::create_external_memory_tests());

    for group in object_tests::create_object_groups() {
        api_tests.add_child(group);
    }
    for group in feature_info_tests::create_info_groups() {
        api_tests.add_child(group);
    }

    api_tests
}
