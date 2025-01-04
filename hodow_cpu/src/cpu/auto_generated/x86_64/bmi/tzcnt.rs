use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "bmi1")]
fn test_x86_64_bmi_tzcnt_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _tzcnt_u64(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_tzcnt_u64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _tzcnt_u64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_bmi_tzcnt_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_bmi_tzcnt_u64_impl() }
}

#[target_feature(enable = "bmi1")]
fn test_x86_64_bmi_mm_tzcnt_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_tzcnt_64(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_tzcnt_64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_tzcnt_64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_bmi_mm_tzcnt_64() -> Result<Verdict, String> {
    unsafe { test_x86_64_bmi_mm_tzcnt_64_impl() }
}
