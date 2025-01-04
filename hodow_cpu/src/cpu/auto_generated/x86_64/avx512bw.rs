mod cvtmask64;
mod cvtu64;

use crate::cpu::auto_generated::x86_64::avx512bw::cvtmask64::*;
use crate::cpu::auto_generated::x86_64::avx512bw::cvtu64::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AVX512BW;

impl ExtensionTest for AVX512BW {
    fn get_name() -> &'static str {
        "x86_64::AVX512BW"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_avx512bw_cvtmask64_u64, "test_x86_64_avx512bw_cvtmask64_u64"),
            (test_x86_64_avx512bw_cvtu64_mask64, "test_x86_64_avx512bw_cvtu64_mask64"),
        ]
    }
}
