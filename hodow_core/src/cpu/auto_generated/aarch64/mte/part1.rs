use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_mte_arm_mte_exclude_tag() -> Result<(), String> {
    unsafe {
        let ptr_src = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let excluded = 1u64;
        let result = __arm_mte_exclude_tag(ptr_src.0.as_ptr(), excluded);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: __arm_mte_exclude_tag(ptr_src.0.as_ptr(), excluded)"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_mte_arm_mte_set_tag() -> Result<(), String> {
    unsafe {
        let ptr_tag_address = crate::cpu::common::Aligned64([0 /* T */; 64]);
        __arm_mte_set_tag(ptr_tag_address.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_aarch64_mte_arm_mte_get_tag() -> Result<(), String> {
    unsafe {
        let ptr_address = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let _result = __arm_mte_get_tag(ptr_address.0.as_ptr());
    }
    Ok(())
}
