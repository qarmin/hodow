// SPDX-License-Identifier: Apache-2.0
//
// external/vulkancts/modules/vulkan/transform_feedback/

use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vkt::TestCaseGroup;

mod construction;
pub mod fuzz_cases;
pub mod fuzz_tests;
pub mod primitive_restart_tests;
pub mod primitives_generated_query_concurrent_tests;
pub mod primitives_generated_query_tests;
pub mod simple_backward_tests;
pub mod simple_depthclip_tests;
pub mod simple_indirect_tests;
pub mod simple_multistream_tests;
mod simple_pipeline;
pub mod simple_query_tests;
pub mod simple_rebind_tests;
pub mod simple_single_raster_tests;
pub mod simple_stream_tests;
pub mod simple_tests;
pub mod simple_winding_tests;

/// `createTransformFeedbackSimpleTests` - the `transform_feedback` group.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("transform_feedback");
    tests.add_child(simple_tests::create_transform_feedback_simple_tests());
    tests.add_child(construction::create_library_simple_group(
        "simple_fast_gpl",
        PipelineConstructionType::FastLinkedLibrary,
    ));
    tests.add_child(construction::create_library_simple_group(
        "simple_optimized_gpl",
        PipelineConstructionType::LinkTimeOptimizedLibrary,
    ));
    tests.add_child(fuzz_tests::create_transform_feedback_fuzz_layout_tests());
    tests.add_child(primitives_generated_query_tests::create_tests());
    tests.add_child(primitive_restart_tests::create_transform_feedback_primitive_restart_tests());
    tests
}
