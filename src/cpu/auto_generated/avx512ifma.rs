mod part1;

use crate::cpu::auto_generated::avx512ifma::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512IFMA;

impl ExtensionTest for AVX512IFMA {
    fn get_name() -> &'static str {
        "AVX512IFMA"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm256_madd52hi_avx_epu64, "test_mm256_madd52hi_avx_epu64"),
        ]
    }
}
