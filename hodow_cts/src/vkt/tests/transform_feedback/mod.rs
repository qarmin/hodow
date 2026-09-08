// SPDX-License-Identifier: Apache-2.0
//
// external/vulkancts/modules/vulkan/transform_feedback/

use crate::vkt::TestCaseGroup;

pub mod primitives_generated_query_tests;

/// `createTransformFeedbackSimpleTests` - the `transform_feedback` group.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("transform_feedback");
    tests.add_child(primitives_generated_query_tests::create_tests());
    tests
}
