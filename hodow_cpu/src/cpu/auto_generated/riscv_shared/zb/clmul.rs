use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv_shared_zb_clmul_32() -> Result<Verdict, String> {
    unsafe {
        let result = clmul_32(1u32, 2u32);

        crate::cpu::fuzz(&mut || {
            let _ = clmul_32(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
