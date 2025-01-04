use std::arch::riscv32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv32_zb_zip_32() -> Result<Verdict, String> {
    unsafe {
        let result = zip_32(1u32);

        crate::cpu::fuzz(&mut || {
            let _ = zip_32(rand::random::<u32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
