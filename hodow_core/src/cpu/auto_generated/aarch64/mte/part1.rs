use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_mte_create_random_tag() -> Result<(), String> {
    unsafe {
        let ptr_src = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let mask = 1u64;
        let _result = __arm_mte_create_random_tag(ptr_src.0.as_ptr(), mask);
    }
    Ok(())
}

pub(super) fn test_arm_mte_increment_tag() -> Result<(), String> {
    unsafe {
        let ptr_src = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let _result = __arm_mte_increment_tag::<0>(ptr_src.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_arm_mte_exclude_tag() -> Result<(), String> {
    unsafe {
        let ptr_src = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let excluded = 1u64;
        let result = __arm_mte_exclude_tag(ptr_src.0.as_ptr(), excluded);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_arm_mte_set_tag() -> Result<(), String> {
    unsafe {
        let ptr_tag_address = crate::cpu::common::Aligned64([0 /* T */; 64]);
        __arm_mte_set_tag(ptr_tag_address.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_arm_mte_get_tag() -> Result<(), String> {
    unsafe {
        let ptr_address = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let _result = __arm_mte_get_tag(ptr_address.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_arm_mte_ptrdiff() -> Result<(), String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let ptr_b = crate::cpu::common::Aligned64([0 /* U */; 64]);
        let result = __arm_mte_ptrdiff(ptr_a.0.as_ptr(), ptr_b.0.as_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}
