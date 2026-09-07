mod part1;

use crate::cpu::auto_generated::x86::avx512fp16::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512FP16;

impl ExtensionTest for AVX512FP16 {
    fn get_name() -> &'static str {
        "x86::AVX512FP16"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_avx512fp16_mm_cvtsi128_si16, "test_x86_avx512fp16_mm_cvtsi128_si16"),
            (&test_x86_avx512fp16_mm_cvtsi128_si16_normal2, "test_x86_avx512fp16_mm_cvtsi128_si16_normal2"),
            (&test_x86_avx512fp16_mm_cvtsi128_si16_normal3, "test_x86_avx512fp16_mm_cvtsi128_si16_normal3"),
            (&test_x86_avx512fp16_mm_cvtsi128_si16_boundary_min, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_min"),
            (&test_x86_avx512fp16_mm_cvtsi128_si16_boundary_max, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_max"),
            (&test_x86_avx512fp16_mm_cvtsi128_si16_boundary_zero, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_zero"),
            (&test_x86_avx512fp16_mm_cvtsi128_si16_boundary_allones, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_allones"),
            (&test_x86_avx512fp16_mm_cvtsi128_si16_boundary_mixed, "test_x86_avx512fp16_mm_cvtsi128_si16_boundary_mixed"),
            (&test_x86_avx512fp16_mm_cvtsi16_si128, "test_x86_avx512fp16_mm_cvtsi16_si128"),
        ]
    }
}
