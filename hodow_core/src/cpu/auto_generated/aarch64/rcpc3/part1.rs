use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_rcpc3_vldap1_lane_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x1_t_from([2]);
        let result = unpack_int64x1_t_to_i64_array(vldap1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: vldap1_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vldap1q_lane_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let src = create_int64x2_t_from([2, 3]);
        let result = unpack_int64x2_t_to_i64_array(vldap1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0i64; 2]).map_err(|e| format!("{e} | call: vldap1q_lane_s64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vldap1q_lane_f64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let src = create_float64x2_t_from([2.0, 3.0]);
        let result = unpack_float64x2_t_to_f64_array(vldap1q_lane_f64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0.0f64; 2]).map_err(|e| format!("{e} | call: vldap1q_lane_f64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vldap1_lane_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x1_t_from([2]);
        let result = unpack_uint64x1_t_to_u64_array(vldap1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vldap1_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vldap1q_lane_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let src = create_uint64x2_t_from([2, 3]);
        let result = unpack_uint64x2_t_to_u64_array(vldap1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vldap1q_lane_u64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vldap1_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x1_t_from([2]);
        let result = unpack_poly64x1_t_to_u64_array(vldap1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: vldap1_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vldap1q_lane_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let src = create_poly64x2_t_from([2, 3]);
        let result = unpack_poly64x2_t_to_u64_array(vldap1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src));
        check_array_equality(&result, &[0u64; 2]).map_err(|e| format!("{e} | call: vldap1q_lane_p64::<0>(ptr_ptr.0.as_ptr(), src)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1_lane_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let val = create_float64x1_t_from([2.0]);
        vstl1_lane_f64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_f64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let val = create_float64x2_t_from([2.0, 3.0]);
        vstl1q_lane_f64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1_lane_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let val = create_uint64x1_t_from([2]);
        vstl1_lane_u64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_u64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let val = create_uint64x2_t_from([2, 3]);
        vstl1q_lane_u64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let val = create_poly64x1_t_from([2]);
        vstl1_lane_p64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let val = create_poly64x2_t_from([2, 3]);
        vstl1q_lane_p64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1_lane_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let val = create_int64x1_t_from([2]);
        vstl1_lane_s64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}

pub(super) fn test_aarch64_rcpc3_vstl1q_lane_s64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let val = create_int64x2_t_from([2, 3]);
        vstl1q_lane_s64::<0>(ptr_ptr.0.as_mut_ptr(), val);
    }
    Ok(())
}
