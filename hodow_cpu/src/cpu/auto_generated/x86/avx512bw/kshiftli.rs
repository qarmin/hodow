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

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_kshiftli_mask32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kshiftli_mask32::<0>(create__mmask32_from(0x55555555u32));
        check_int_equality(result, 1431655765).map_err(|e| crate::cpu::with_call(e, "_kshiftli_mask32::<0>(create__mmask32_from(0x55555555u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kshiftli_mask32::<0>(create_random__mmask32());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_kshiftli_mask32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_kshiftli_mask32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_kshiftli_mask64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kshiftli_mask64::<0>(create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result, 6148914691236517205).map_err(|e| crate::cpu::with_call(e, "_kshiftli_mask64::<0>(create__mmask64_from(0x5555555555555555u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kshiftli_mask64::<0>(create_random__mmask64());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_kshiftli_mask64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_kshiftli_mask64_impl() }
}
