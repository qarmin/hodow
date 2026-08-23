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
            (&test_x86_avxneconvert_mm_cvtneebf16_ps, "test_x86_avxneconvert_mm_cvtneebf16_ps"),
            (&test_x86_avxneconvert_mm256_cvtneebf16_ps, "test_x86_avxneconvert_mm256_cvtneebf16_ps"),
            (&test_x86_avxneconvert_mm_cvtneobf16_ps, "test_x86_avxneconvert_mm_cvtneobf16_ps"),
            (&test_x86_avxneconvert_mm256_cvtneobf16_ps, "test_x86_avxneconvert_mm256_cvtneobf16_ps"),
            (&test_x86_avxneconvert_mm_cvtneps_avx_pbh, "test_x86_avxneconvert_mm_cvtneps_avx_pbh"),
            (&test_x86_avxneconvert_mm256_cvtneps_avx_pbh, "test_x86_avxneconvert_mm256_cvtneps_avx_pbh"),
        ]
    }
}
