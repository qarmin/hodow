#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_kadd_mask16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kadd_mask16(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101));
        check_int_equality(result, 43690).map_err(|e| crate::cpu::with_call(e, "_kadd_mask16(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kadd_mask16(create_random__mmask16(), create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_kadd_mask16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_kadd_mask16_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_kadd_mask8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kadd_mask8(create__mmask8_from(0b01010101), create__mmask8_from(0b01010101));
        check_int_equality(result, 170).map_err(|e| crate::cpu::with_call(e, "_kadd_mask8(create__mmask8_from(0b01010101), create__mmask8_from(0b01010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kadd_mask8(create_random__mmask8(), create_random__mmask8());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_kadd_mask8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_kadd_mask8_impl() }
}
