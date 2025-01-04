mod vsha1cq;
mod vsha1h;
mod vsha1mq;
mod vsha1pq;
mod vsha1su0q;
mod vsha1su1q;
mod vsha256h2q;
mod vsha256hq;
mod vsha256su0q;
mod vsha256su1q;

use crate::cpu::auto_generated::arm_shared::sha2::vsha1cq::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha1h::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha1mq::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha1pq::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha1su0q::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha1su1q::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha256h2q::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha256hq::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha256su0q::*;
use crate::cpu::auto_generated::arm_shared::sha2::vsha256su1q::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SHA2;

impl ExtensionTest for SHA2 {
    fn get_name() -> &'static str {
        "arm_shared::SHA2"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_arm_shared_sha2_vsha1cq_u32, "test_arm_shared_sha2_vsha1cq_u32"),
            (test_arm_shared_sha2_vsha1h_u32, "test_arm_shared_sha2_vsha1h_u32"),
            (test_arm_shared_sha2_vsha1mq_u32, "test_arm_shared_sha2_vsha1mq_u32"),
            (test_arm_shared_sha2_vsha1pq_u32, "test_arm_shared_sha2_vsha1pq_u32"),
            (test_arm_shared_sha2_vsha1su0q_u32, "test_arm_shared_sha2_vsha1su0q_u32"),
            (test_arm_shared_sha2_vsha1su1q_u32, "test_arm_shared_sha2_vsha1su1q_u32"),
            (test_arm_shared_sha2_vsha256h2q_u32, "test_arm_shared_sha2_vsha256h2q_u32"),
            (test_arm_shared_sha2_vsha256hq_u32, "test_arm_shared_sha2_vsha256hq_u32"),
            (test_arm_shared_sha2_vsha256su0q_u32, "test_arm_shared_sha2_vsha256su0q_u32"),
            (test_arm_shared_sha2_vsha256su1q_u32, "test_arm_shared_sha2_vsha256su1q_u32"),
        ]
    }
}
