use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_64_bt_bittest64() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i64; 8]);
        let b = 2i64;
        let result = _bittest64(ptr_p.0.as_ptr(), b);
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
