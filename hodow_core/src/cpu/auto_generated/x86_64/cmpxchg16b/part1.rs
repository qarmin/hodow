use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_cmpxchg16b() -> Result<(), String> {
    unsafe {
        let mut ptr_dst = [0 /* u128 */; 1];
        let old = 0 /* u128 */;
        let new = 0 /* u128 */;
        let success = 0 /* Ordering */;
        let failure = 0 /* Ordering */;
        let _result = cmpxchg16b(ptr_dst.as_mut_ptr(), old, new, success, failure);
    }
    Ok(())
}
