use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv_shared_zk_sm3p1() -> Result<Verdict, String> {
    unsafe {
        let result = sm3p1(1u32);

        crate::cpu::fuzz(&mut || {
            let _ = sm3p1(rand::random::<u32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
