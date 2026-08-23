mod part1;

use crate::cpu::auto_generated::arm::neon::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct NEON;

impl ExtensionTest for NEON {
    fn get_name() -> &'static str {
        "arm::NEON"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_arm_neon_vsli_n_p64, "test_arm_neon_vsli_n_p64"),
            (&test_arm_neon_vsliq_n_p64, "test_arm_neon_vsliq_n_p64"),
            (&test_arm_neon_vsri_n_p64, "test_arm_neon_vsri_n_p64"),
            (&test_arm_neon_vsriq_n_p64, "test_arm_neon_vsriq_n_p64"),
        ]
    }
}
