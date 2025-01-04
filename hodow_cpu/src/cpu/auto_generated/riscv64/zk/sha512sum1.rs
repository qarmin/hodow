use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv64_zk_sha512sum1() -> Result<Verdict, String> {
    unsafe {
        let result = sha512sum1(1u64);

        crate::cpu::fuzz(&mut || {
            let _ = sha512sum1(rand::random::<u64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
