use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv64_zk_aes64ks1i() -> Result<Verdict, String> {
    unsafe {
        let result = aes64ks1i::<0>(1u64);

        crate::cpu::fuzz(&mut || {
            let _ = aes64ks1i::<0>(rand::random::<u64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
