// SPDX-License-Identifier: Apache-2.0
//
// external/vulkancts/modules/vulkan/ycbcr/

use crate::vkt::TestCaseGroup;

pub mod conversion_tests;
pub mod conversion_util;
pub mod copy_tests;
pub mod filtering_tests;
pub mod format_channels;
pub mod format_channels_core;
pub mod format_lists;
pub mod format_tables;
pub mod format_tests;
pub mod image_offset_tests;
pub mod image_query_tests;
pub mod misc_tests;
pub mod render_attachment_tests;
pub mod storage_write_programs;
pub mod storage_write_tests;
pub mod util;
pub mod view_tests;

/// The `ycbcr` group.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("ycbcr");
    tests.add_child(conversion_tests::create_conversion_tests());
    tests.add_child(copy_tests::create_copy_tests());
    tests.add_child(copy_tests::create_single_planar_copy_tests());
    tests.add_child(copy_tests::create_dimensions_copy_tests());
    tests.add_child(image_offset_tests::create_image_offset_tests());
    tests.add_child(misc_tests::create_misc_tests());
    tests.add_child(render_attachment_tests::create_render_attachment_tests());
    tests.add_child(image_query_tests::create_image_query_tests());
    tests.add_child(format_tests::create_format_tests());
    tests.add_child(view_tests::create_view_tests());
    tests.add_child(filtering_tests::create_filtering_tests());
    tests.add_child(storage_write_tests::create_storage_image_write_tests());
    tests
}
