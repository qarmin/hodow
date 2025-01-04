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
fn test_x86_avx512f_kor_mask16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kor_mask16(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101));
        check_int_equality(result, 21845).map_err(|e| crate::cpu::with_call(e, "_kor_mask16(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kor_mask16(create_random__mmask16(), create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_kor_mask16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_kor_mask16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_kor_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_kor(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101));
        check_int_equality(result, 21845).map_err(|e| crate::cpu::with_call(e, "_mm512_kor(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_kor(create_random__mmask16(), create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_kor() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_kor_impl() }
}
