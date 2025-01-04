use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_rand_rndrrs() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_value = crate::cpu::common::Aligned64([1u64; 8]);
        let result = __rndrrs(ptr_value.0.as_mut_ptr());
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "__rndrrs(ptr_value.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}
