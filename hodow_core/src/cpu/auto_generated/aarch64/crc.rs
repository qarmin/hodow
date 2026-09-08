mod part1;

use crate::cpu::auto_generated::aarch64::crc::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct CRC;

impl ExtensionTest for CRC {
    fn get_name() -> &'static str {
        "aarch64::CRC"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_crc_crc32cd, "test_aarch64_crc_crc32cd"),
            (&test_aarch64_crc_crc32d, "test_aarch64_crc_crc32d"),
        ]
    }
}
