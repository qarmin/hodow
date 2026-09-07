mod part1;

use crate::cpu::auto_generated::aarch64::mte::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct MTE;

impl ExtensionTest for MTE {
    fn get_name() -> &'static str {
        "aarch64::MTE"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_mte_arm_mte_exclude_tag, "test_aarch64_mte_arm_mte_exclude_tag"),
            (&test_aarch64_mte_arm_mte_set_tag, "test_aarch64_mte_arm_mte_set_tag"),
            (&test_aarch64_mte_arm_mte_get_tag, "test_aarch64_mte_arm_mte_get_tag"),
        ]
    }
}
