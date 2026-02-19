mod part1;

use crate::cpu::auto_generated::avxneconvert::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVXNECONVERT;

impl ExtensionTest for AVXNECONVERT {
    fn get_name() -> &'static str {
        "AVXNECONVERT"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_bcstnebf16_ps, "test_mm_bcstnebf16_ps"),
            (&test_mm256_bcstnebf16_ps, "test_mm256_bcstnebf16_ps"),
            (&test_mm_bcstnesh_ps, "test_mm_bcstnesh_ps"),
            (&test_mm256_bcstnesh_ps, "test_mm256_bcstnesh_ps"),
            (&test_mm_cvtneebf16_ps, "test_mm_cvtneebf16_ps"),
            (&test_mm256_cvtneebf16_ps, "test_mm256_cvtneebf16_ps"),
            (&test_mm_cvtneeph_ps, "test_mm_cvtneeph_ps"),
            (&test_mm256_cvtneeph_ps, "test_mm256_cvtneeph_ps"),
            (&test_mm_cvtneobf16_ps, "test_mm_cvtneobf16_ps"),
            (&test_mm256_cvtneobf16_ps, "test_mm256_cvtneobf16_ps"),
            (&test_mm_cvtneoph_ps, "test_mm_cvtneoph_ps"),
            (&test_mm256_cvtneoph_ps, "test_mm256_cvtneoph_ps"),
            (&test_mm_cvtneps_avx_pbh, "test_mm_cvtneps_avx_pbh"),
            (&test_mm256_cvtneps_avx_pbh, "test_mm256_cvtneps_avx_pbh"),
        ]
    }
}
