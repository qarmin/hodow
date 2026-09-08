mod part1;

use crate::cpu::auto_generated::arm_shared::sha2::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SHA2;

impl ExtensionTest for SHA2 {
    fn get_name() -> &'static str {
        "arm_shared::SHA2"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_arm_shared_sha2_vsha1cq_u32, "test_arm_shared_sha2_vsha1cq_u32"),
            (&test_arm_shared_sha2_vsha1h_u32, "test_arm_shared_sha2_vsha1h_u32"),
            (&test_arm_shared_sha2_vsha1mq_u32, "test_arm_shared_sha2_vsha1mq_u32"),
            (&test_arm_shared_sha2_vsha1pq_u32, "test_arm_shared_sha2_vsha1pq_u32"),
            (&test_arm_shared_sha2_vsha1su0q_u32, "test_arm_shared_sha2_vsha1su0q_u32"),
            (&test_arm_shared_sha2_vsha1su1q_u32, "test_arm_shared_sha2_vsha1su1q_u32"),
            (&test_arm_shared_sha2_vsha256h2q_u32, "test_arm_shared_sha2_vsha256h2q_u32"),
            (&test_arm_shared_sha2_vsha256hq_u32, "test_arm_shared_sha2_vsha256hq_u32"),
            (&test_arm_shared_sha2_vsha256su0q_u32, "test_arm_shared_sha2_vsha256su0q_u32"),
            (&test_arm_shared_sha2_vsha256su1q_u32, "test_arm_shared_sha2_vsha256su1q_u32"),
        ]
    }
}
