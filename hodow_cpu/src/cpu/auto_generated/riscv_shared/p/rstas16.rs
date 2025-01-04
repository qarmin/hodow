use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv_shared_p_rstas16() -> Result<Verdict, String> {
    unsafe {
        let result = rstas16(0usize, 0usize);

        crate::cpu::fuzz(&mut || {
            let _ = rstas16(rand::random::<u64>() as usize, rand::random::<u64>() as usize);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
