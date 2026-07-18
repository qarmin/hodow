mod part1;

use crate::cpu::auto_generated::x86_64::avx512bw::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512BW;

impl ExtensionTest for AVX512BW {
    fn get_name() -> &'static str {
        "x86_64::AVX512BW"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_cvtmask64_u64, "test_cvtmask64_u64"), (&test_cvtu64_mask64, "test_cvtu64_mask64")]
    }
}
