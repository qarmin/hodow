use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv_shared_p_ksll8() -> Result<Verdict, String> {
    unsafe {
        let result = ksll8(0usize, 1u32);

        crate::cpu::fuzz(&mut || {
            let _ = ksll8(rand::random::<u64>() as usize, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
