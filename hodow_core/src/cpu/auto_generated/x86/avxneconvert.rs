mod part1;

use crate::cpu::auto_generated::x86::avxneconvert::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVXNECONVERT;

impl ExtensionTest for AVXNECONVERT {
    fn get_name() -> &'static str {
        "x86::AVXNECONVERT"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtneebf16_ps, "test_mm_cvtneebf16_ps"),
            (&test_mm256_cvtneebf16_ps, "test_mm256_cvtneebf16_ps"),
            (&test_mm_cvtneobf16_ps, "test_mm_cvtneobf16_ps"),
            (&test_mm256_cvtneobf16_ps, "test_mm256_cvtneobf16_ps"),
            (&test_mm_cvtneps_avx_pbh, "test_mm_cvtneps_avx_pbh"),
            (&test_mm256_cvtneps_avx_pbh, "test_mm256_cvtneps_avx_pbh"),
        ]
    }
}
