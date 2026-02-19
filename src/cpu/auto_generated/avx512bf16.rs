mod part1;

use crate::cpu::auto_generated::avx512bf16::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512BF16;

impl ExtensionTest for AVX512BF16 {
    fn get_name() -> &'static str {
        "AVX512BF16"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtne2ps_pbh, "test_mm_cvtne2ps_pbh"),
            (&test_mm_mask_cvtne2ps_pbh, "test_mm_mask_cvtne2ps_pbh"),
            (&test_mm_maskz_cvtne2ps_pbh, "test_mm_maskz_cvtne2ps_pbh"),
            (&test_mm_dpbf16_ps, "test_mm_dpbf16_ps"),
            (&test_mm_mask_dpbf16_ps, "test_mm_mask_dpbf16_ps"),
            (&test_mm_maskz_dpbf16_ps, "test_mm_maskz_dpbf16_ps"),
            (&test_mm_cvtpbh_ps, "test_mm_cvtpbh_ps"),
            (&test_mm_mask_cvtpbh_ps, "test_mm_mask_cvtpbh_ps"),
            (&test_mm_maskz_cvtpbh_ps, "test_mm_maskz_cvtpbh_ps"),
            (&test_mm_cvtsbh_ss, "test_mm_cvtsbh_ss"),
            (&test_mm_cvtneps_pbh, "test_mm_cvtneps_pbh"),
            (&test_mm_mask_cvtneps_pbh, "test_mm_mask_cvtneps_pbh"),
            (&test_mm_maskz_cvtneps_pbh, "test_mm_maskz_cvtneps_pbh"),
            (&test_mm_cvtness_sbh, "test_mm_cvtness_sbh"),
        ]
    }
}
