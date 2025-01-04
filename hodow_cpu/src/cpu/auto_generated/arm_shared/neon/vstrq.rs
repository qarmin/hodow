#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_arm_shared_neon_vstrq_p128() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_a = crate::cpu::common::Aligned64([1u128; 64]);
        let b = 2u128;
        vstrq_p128(ptr_a.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_a);
        let result = core::ptr::read(ptr_a.0.as_ptr().cast::<[u128; 4]>());
        check_array_equality(&result, &[2, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vstrq_p128(ptr_a.0.as_mut_ptr(), b)"))?;
        Ok(Verdict::Checked)
    }
}
