use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_f64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let val = create_float64x2_t_from([2.0, 3.0]);
        vstl1q_lane_f64::<0>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_f64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let val = create_float64x2_t_from([2.0, 3.0]);
        vstl1q_lane_f64::<1>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[f64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_u64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let val = create_uint64x2_t_from([2, 3]);
        vstl1q_lane_u64::<0>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_u64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let val = create_uint64x2_t_from([2, 3]);
        vstl1q_lane_u64::<1>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_p64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let val = create_poly64x2_t_from([2, 3]);
        vstl1q_lane_p64::<0>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_p64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let val = create_poly64x2_t_from([2, 3]);
        vstl1q_lane_p64::<1>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_s64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let val = create_int64x2_t_from([2, 3]);
        vstl1q_lane_s64::<0>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_s64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let val = create_int64x2_t_from([2, 3]);
        vstl1q_lane_s64::<1>(ptr_ptr.0.as_mut_ptr(), val);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
