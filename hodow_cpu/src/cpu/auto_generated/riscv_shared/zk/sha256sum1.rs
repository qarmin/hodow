use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv_shared_zk_sha256sum1() -> Result<Verdict, String> {
    unsafe {
        let result = sha256sum1(1u32);

        crate::cpu::fuzz(&mut || {
            let _ = sha256sum1(rand::random::<u32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
