mod cvtsi128;
mod cvtsi16;

use crate::cpu::auto_generated::x86::avx512fp16::cvtsi128::*;
use crate::cpu::auto_generated::x86::avx512fp16::cvtsi16::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AVX512FP16;

impl ExtensionTest for AVX512FP16 {
    fn get_name() -> &'static str {
        "x86::AVX512FP16"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_avx512fp16_mm_cvtsi128_si16, "test_x86_avx512fp16_mm_cvtsi128_si16"),
            (test_x86_avx512fp16_mm_cvtsi128_si16_normal2, "test_x86_avx512fp16_mm_cvtsi128_si16_normal2"),
            (test_x86_avx512fp16_mm_cvtsi128_si16_normal3, "test_x86_avx512fp16_mm_cvtsi128_si16_normal3"),
            (test_x86_avx512fp16_mm_cvtsi128_si16_boundary_min, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_min"),
            (test_x86_avx512fp16_mm_cvtsi128_si16_boundary_max, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_max"),
            (test_x86_avx512fp16_mm_cvtsi128_si16_boundary_zero, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_zero"),
            (test_x86_avx512fp16_mm_cvtsi128_si16_boundary_allones, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_allones"),
            (test_x86_avx512fp16_mm_cvtsi128_si16_boundary_mixed, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_mixed"),
            (test_x86_avx512fp16_mm_cvtsi16_si128, "test_x86_avx512fp16_mm_cvtsi16_si128"),
        ]
    }
}
