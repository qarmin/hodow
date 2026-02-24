mod part1;

use crate::cpu::auto_generated::aes::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AES;

impl ExtensionTest for AES {
    fn get_name() -> &'static str {
        "AES"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_aesdec_si128, "test_mm_aesdec_si128"),
            (&test_mm_aesdeclast_si128, "test_mm_aesdeclast_si128"),
            (&test_mm_aesenc_si128, "test_mm_aesenc_si128"),
            (&test_mm_aesenclast_si128, "test_mm_aesenclast_si128"),
            (&test_mm_aesimc_si128, "test_mm_aesimc_si128"),
        ]
    }
}
