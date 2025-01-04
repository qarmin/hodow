use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv_shared_p_kslra8() -> Result<Verdict, String> {
    unsafe {
        let result = kslra8(0usize, 1i32);

        crate::cpu::fuzz(&mut || {
            let _ = kslra8(rand::random::<u64>() as usize, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
