use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv64_zb_clmul_64() -> Result<Verdict, String> {
    unsafe {
        let result = clmul_64(1u64, 2u64);

        crate::cpu::fuzz(&mut || {
            let _ = clmul_64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
