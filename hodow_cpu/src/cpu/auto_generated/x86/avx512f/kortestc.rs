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

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_kortestc_mask16_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kortestc_mask16_u8(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_kortestc_mask16_u8(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kortestc_mask16_u8(create_random__mmask16(), create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_kortestc_mask16_u8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_kortestc_mask16_u8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_kortestc_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_kortestc(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_kortestc(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_kortestc(create_random__mmask16(), create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_kortestc() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_kortestc_impl() }
}
