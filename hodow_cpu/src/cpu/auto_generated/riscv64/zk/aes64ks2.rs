use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv64_zk_aes64ks2() -> Result<Verdict, String> {
    unsafe {
        let result = aes64ks2(1u64, 2u64);

        crate::cpu::fuzz(&mut || {
            let _ = aes64ks2(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
