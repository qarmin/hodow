use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv64_zb_xperm8_64() -> Result<Verdict, String> {
    unsafe {
        let result = xperm8_64(1u64, 2u64);

        crate::cpu::fuzz(&mut || {
            let _ = xperm8_64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
