use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_aes_vst1q_p64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([2, 3]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        check_array_equality(&result, &[2, 3, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vst1q_p64(ptr_ptr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}
