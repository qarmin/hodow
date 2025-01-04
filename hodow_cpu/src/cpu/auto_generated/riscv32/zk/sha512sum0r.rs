use std::arch::riscv32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv32_zk_sha512sum0r() -> Result<Verdict, String> {
    unsafe {
        let result = sha512sum0r(1u32, 2u32);

        crate::cpu::fuzz(&mut || {
            let _ = sha512sum0r(rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
