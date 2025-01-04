#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_bt_bittest() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i32; 16]);
        let b = 2i32;
        let result = _bittest(ptr_p.0.as_ptr(), b);
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
