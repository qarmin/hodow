// SPDX-License-Identifier: Apache-2.0
//
// external/vulkancts/modules/vulkan/query_pool/
//
// `statistics_query` is ported without `multiple_queries` and `multiple_geom_stats`.

use crate::vkt::TestCaseGroup;

pub mod concurrent_tests;
pub mod discard_tests;
pub mod frag_invocation_tests;
pub mod maintenance7_tests;
pub mod occlusion_tests;
pub mod performance_tests;
pub mod statistics_tests;

/// `createTests` - the `query_pool` group.
pub fn create_tests() -> TestCaseGroup {
    let mut query_pool_tests = TestCaseGroup::new("query_pool");
    query_pool_tests.add_child(discard_tests::create_discard_tests());
    query_pool_tests.add_child(concurrent_tests::create_concurrent_tests());
    query_pool_tests.add_child(frag_invocation_tests::create_frag_invocation_tests());
    query_pool_tests.add_child(maintenance7_tests::create_query_maintenance7_tests());
    query_pool_tests.add_child(occlusion_tests::create_occlusion_tests());
    query_pool_tests.add_child(performance_tests::create_performance_query_tests());
    query_pool_tests.add_child(statistics_tests::create_statistics_tests());
    query_pool_tests
}
