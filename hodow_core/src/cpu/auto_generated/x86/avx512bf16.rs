mod part1;

use crate::cpu::auto_generated::x86::avx512bf16::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512BF16;

impl ExtensionTest for AVX512BF16 {
    fn get_name() -> &'static str {
        "x86::AVX512BF16"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_cvtpbh_ps, "test_mm512_cvtpbh_ps"),
            (&test_mm512_mask_cvtpbh_ps, "test_mm512_mask_cvtpbh_ps"),
            (&test_mm512_maskz_cvtpbh_ps, "test_mm512_maskz_cvtpbh_ps"),
            (&test_mm256_cvtpbh_ps, "test_mm256_cvtpbh_ps"),
            (&test_mm256_mask_cvtpbh_ps, "test_mm256_mask_cvtpbh_ps"),
            (&test_mm256_maskz_cvtpbh_ps, "test_mm256_maskz_cvtpbh_ps"),
            (&test_mm_cvtpbh_ps, "test_mm_cvtpbh_ps"),
            (&test_mm_mask_cvtpbh_ps, "test_mm_mask_cvtpbh_ps"),
            (&test_mm_maskz_cvtpbh_ps, "test_mm_maskz_cvtpbh_ps"),
        ]
    }
}
