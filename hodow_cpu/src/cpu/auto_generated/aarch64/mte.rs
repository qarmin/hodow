use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_mte_arm_mte_exclude_tag() -> Result<Verdict, String> {
    unsafe {
        let ptr_src = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let excluded = 1u64;
        let result = __arm_mte_exclude_tag(ptr_src.0.as_ptr(), excluded);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "__arm_mte_exclude_tag(ptr_src.0.as_ptr(), excluded)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_mte_arm_mte_set_tag() -> Result<Verdict, String> {
    unsafe {
        let ptr_tag_address = crate::cpu::common::Aligned64([0 /* T */; 64]);
        __arm_mte_set_tag(ptr_tag_address.0.as_ptr());
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_aarch64_mte_arm_mte_get_tag() -> Result<Verdict, String> {
    unsafe {
        let ptr_address = crate::cpu::common::Aligned64([0 /* T */; 64]);
        let _result = core::hint::black_box(__arm_mte_get_tag(ptr_address.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct MTE;

impl ExtensionTest for MTE {
    fn get_name() -> &'static str {
        "aarch64::MTE"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_mte_arm_mte_exclude_tag, "test_aarch64_mte_arm_mte_exclude_tag"),
            (test_aarch64_mte_arm_mte_set_tag, "test_aarch64_mte_arm_mte_set_tag"),
            (test_aarch64_mte_arm_mte_get_tag, "test_aarch64_mte_arm_mte_get_tag"),
        ]
    }
}
