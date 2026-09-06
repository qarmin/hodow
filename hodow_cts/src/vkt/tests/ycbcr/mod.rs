// SPDX-License-Identifier: Apache-2.0
//
// external/vulkancts/modules/vulkan/ycbcr/

use crate::tcu::TestCaseGroup;

pub mod copy_tests;
pub mod format_tables;

/// The `ycbcr` group.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("ycbcr");
    tests.add_child(copy_tests::create_copy_tests());
    tests
}
