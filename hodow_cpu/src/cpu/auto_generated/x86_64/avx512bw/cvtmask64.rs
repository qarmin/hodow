use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx512bw")]
fn test_x86_64_avx512bw_cvtmask64_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _cvtmask64_u64(create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result, 6148914691236517205).map_err(|e| crate::cpu::with_call(e, "_cvtmask64_u64(create__mmask64_from(0x5555555555555555u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _cvtmask64_u64(create_random__mmask64());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512bw_cvtmask64_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512bw_cvtmask64_u64_impl() }
}
