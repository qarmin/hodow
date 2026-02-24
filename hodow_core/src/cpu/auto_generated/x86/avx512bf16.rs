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
            (&test_mm_cvtne2ps_pbh, "test_mm_cvtne2ps_pbh"),
            (&test_mm_mask_cvtne2ps_pbh, "test_mm_mask_cvtne2ps_pbh"),
            (&test_mm_maskz_cvtne2ps_pbh, "test_mm_maskz_cvtne2ps_pbh"),
            (&test_mm256_cvtne2ps_pbh, "test_mm256_cvtne2ps_pbh"),
            (&test_mm256_mask_cvtne2ps_pbh, "test_mm256_mask_cvtne2ps_pbh"),
            (&test_mm256_maskz_cvtne2ps_pbh, "test_mm256_maskz_cvtne2ps_pbh"),
            (&test_mm512_cvtne2ps_pbh, "test_mm512_cvtne2ps_pbh"),
            (&test_mm512_mask_cvtne2ps_pbh, "test_mm512_mask_cvtne2ps_pbh"),
            (&test_mm512_maskz_cvtne2ps_pbh, "test_mm512_maskz_cvtne2ps_pbh"),
            (&test_mm256_cvtneps_pbh, "test_mm256_cvtneps_pbh"),
            (&test_mm256_mask_cvtneps_pbh, "test_mm256_mask_cvtneps_pbh"),
            (&test_mm256_maskz_cvtneps_pbh, "test_mm256_maskz_cvtneps_pbh"),
            (&test_mm512_cvtneps_pbh, "test_mm512_cvtneps_pbh"),
            (&test_mm512_mask_cvtneps_pbh, "test_mm512_mask_cvtneps_pbh"),
            (&test_mm512_maskz_cvtneps_pbh, "test_mm512_maskz_cvtneps_pbh"),
            (&test_mm_dpbf16_ps, "test_mm_dpbf16_ps"),
            (&test_mm_mask_dpbf16_ps, "test_mm_mask_dpbf16_ps"),
            (&test_mm_maskz_dpbf16_ps, "test_mm_maskz_dpbf16_ps"),
            (&test_mm256_dpbf16_ps, "test_mm256_dpbf16_ps"),
            (&test_mm256_mask_dpbf16_ps, "test_mm256_mask_dpbf16_ps"),
            (&test_mm256_maskz_dpbf16_ps, "test_mm256_maskz_dpbf16_ps"),
            (&test_mm512_dpbf16_ps, "test_mm512_dpbf16_ps"),
            (&test_mm512_mask_dpbf16_ps, "test_mm512_mask_dpbf16_ps"),
            (&test_mm512_maskz_dpbf16_ps, "test_mm512_maskz_dpbf16_ps"),
            (&test_mm512_cvtpbh_ps, "test_mm512_cvtpbh_ps"),
            (&test_mm512_mask_cvtpbh_ps, "test_mm512_mask_cvtpbh_ps"),
            (&test_mm512_maskz_cvtpbh_ps, "test_mm512_maskz_cvtpbh_ps"),
            (&test_mm256_cvtpbh_ps, "test_mm256_cvtpbh_ps"),
            (&test_mm256_mask_cvtpbh_ps, "test_mm256_mask_cvtpbh_ps"),
            (&test_mm256_maskz_cvtpbh_ps, "test_mm256_maskz_cvtpbh_ps"),
            (&test_mm_cvtpbh_ps, "test_mm_cvtpbh_ps"),
            (&test_mm_mask_cvtpbh_ps, "test_mm_mask_cvtpbh_ps"),
            (&test_mm_maskz_cvtpbh_ps, "test_mm_maskz_cvtpbh_ps"),
            (&test_mm_cvtneps_pbh, "test_mm_cvtneps_pbh"),
            (&test_mm_mask_cvtneps_pbh, "test_mm_mask_cvtneps_pbh"),
            (&test_mm_maskz_cvtneps_pbh, "test_mm_maskz_cvtneps_pbh"),
        ]
    }
}
