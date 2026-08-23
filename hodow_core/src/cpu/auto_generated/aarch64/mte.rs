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
            (&test_arm_mte_create_random_tag, "test_arm_mte_create_random_tag"),
            (&test_arm_mte_increment_tag, "test_arm_mte_increment_tag"),
            (&test_arm_mte_exclude_tag, "test_arm_mte_exclude_tag"),
            (&test_arm_mte_set_tag, "test_arm_mte_set_tag"),
            (&test_arm_mte_get_tag, "test_arm_mte_get_tag"),
            (&test_arm_mte_ptrdiff, "test_arm_mte_ptrdiff"),
        ]
    }
}
