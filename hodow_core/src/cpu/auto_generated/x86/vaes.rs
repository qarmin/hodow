mod part1;

use crate::cpu::auto_generated::x86::vaes::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct VAES;

impl ExtensionTest for VAES {
    fn get_name() -> &'static str {
        "x86::VAES"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm256_aesenc_epi128, "test_mm256_aesenc_epi128"),
            (&test_mm256_aesenclast_epi128, "test_mm256_aesenclast_epi128"),
            (&test_mm256_aesdec_epi128, "test_mm256_aesdec_epi128"),
            (&test_mm256_aesdeclast_epi128, "test_mm256_aesdeclast_epi128"),
            (&test_mm512_aesenc_epi128, "test_mm512_aesenc_epi128"),
            (&test_mm512_aesenclast_epi128, "test_mm512_aesenclast_epi128"),
            (&test_mm512_aesdec_epi128, "test_mm512_aesdec_epi128"),
            (&test_mm512_aesdeclast_epi128, "test_mm512_aesdeclast_epi128"),
        ]
    }
}
