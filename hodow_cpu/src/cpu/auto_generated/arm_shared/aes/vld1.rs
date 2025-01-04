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

pub(super) fn test_arm_shared_aes_vld1_dup_p64() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_dup_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vld1_dup_p64(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vld1_lane_p64() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x1_t_from([2]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vld1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_aes_vld1_p64() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vld1_p64(ptr_ptr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}
