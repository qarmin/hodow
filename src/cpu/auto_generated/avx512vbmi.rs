mod part1;

use crate::cpu::auto_generated::avx512vbmi::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VBMI;

impl ExtensionTest for AVX512VBMI {
    fn get_name() -> &'static str {
        "AVX512VBMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_permutex2var_epi8, "test_mm512_permutex2var_epi8"),
            (&test_mm512_mask_permutex2var_epi8, "test_mm512_mask_permutex2var_epi8"),
            (&test_mm512_maskz_permutex2var_epi8, "test_mm512_maskz_permutex2var_epi8"),
            (&test_mm512_mask2_permutex2var_epi8, "test_mm512_mask2_permutex2var_epi8"),
            (&test_mm256_permutex2var_epi8, "test_mm256_permutex2var_epi8"),
            (&test_mm256_mask_permutex2var_epi8, "test_mm256_mask_permutex2var_epi8"),
            (&test_mm256_maskz_permutex2var_epi8, "test_mm256_maskz_permutex2var_epi8"),
            (&test_mm256_mask2_permutex2var_epi8, "test_mm256_mask2_permutex2var_epi8"),
            (&test_mm_permutex2var_epi8, "test_mm_permutex2var_epi8"),
            (&test_mm_mask_permutex2var_epi8, "test_mm_mask_permutex2var_epi8"),
            (&test_mm_maskz_permutex2var_epi8, "test_mm_maskz_permutex2var_epi8"),
            (&test_mm_mask2_permutex2var_epi8, "test_mm_mask2_permutex2var_epi8"),
            (&test_mm512_permutexvar_epi8, "test_mm512_permutexvar_epi8"),
            (&test_mm512_mask_permutexvar_epi8, "test_mm512_mask_permutexvar_epi8"),
            (&test_mm512_maskz_permutexvar_epi8, "test_mm512_maskz_permutexvar_epi8"),
            (&test_mm256_permutexvar_epi8, "test_mm256_permutexvar_epi8"),
            (&test_mm256_mask_permutexvar_epi8, "test_mm256_mask_permutexvar_epi8"),
            (&test_mm256_maskz_permutexvar_epi8, "test_mm256_maskz_permutexvar_epi8"),
            (&test_mm_permutexvar_epi8, "test_mm_permutexvar_epi8"),
            (&test_mm_mask_permutexvar_epi8, "test_mm_mask_permutexvar_epi8"),
            (&test_mm_maskz_permutexvar_epi8, "test_mm_maskz_permutexvar_epi8"),
            (&test_mm512_multishift_epi64_epi8, "test_mm512_multishift_epi64_epi8"),
            (&test_mm512_mask_multishift_epi64_epi8, "test_mm512_mask_multishift_epi64_epi8"),
            (&test_mm512_maskz_multishift_epi64_epi8, "test_mm512_maskz_multishift_epi64_epi8"),
            (&test_mm256_multishift_epi64_epi8, "test_mm256_multishift_epi64_epi8"),
            (&test_mm256_mask_multishift_epi64_epi8, "test_mm256_mask_multishift_epi64_epi8"),
            (&test_mm256_maskz_multishift_epi64_epi8, "test_mm256_maskz_multishift_epi64_epi8"),
            (&test_mm_multishift_epi64_epi8, "test_mm_multishift_epi64_epi8"),
            (&test_mm_mask_multishift_epi64_epi8, "test_mm_mask_multishift_epi64_epi8"),
            (&test_mm_maskz_multishift_epi64_epi8, "test_mm_maskz_multishift_epi64_epi8"),
        ]
    }
}
