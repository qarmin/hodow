mod part1;

use crate::cpu::auto_generated::arm_shared::crc::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct CRC;

impl ExtensionTest for CRC {
    fn get_name() -> &'static str {
        "arm_shared::CRC"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_arm_shared_crc_crc32b, "test_arm_shared_crc_crc32b"),
            (&test_arm_shared_crc_crc32cb, "test_arm_shared_crc_crc32cb"),
            #[cfg(target_arch = "arm")]
            (&test_arm_shared_crc_crc32cd, "test_arm_shared_crc_crc32cd"),
            (&test_arm_shared_crc_crc32ch, "test_arm_shared_crc_crc32ch"),
            (&test_arm_shared_crc_crc32cw, "test_arm_shared_crc_crc32cw"),
            #[cfg(target_arch = "arm")]
            (&test_arm_shared_crc_crc32d, "test_arm_shared_crc_crc32d"),
            (&test_arm_shared_crc_crc32h, "test_arm_shared_crc_crc32h"),
            (&test_arm_shared_crc_crc32w, "test_arm_shared_crc_crc32w"),
        ]
    }
}
