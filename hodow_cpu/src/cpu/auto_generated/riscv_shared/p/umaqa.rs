use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_riscv_shared_p_umaqa() -> Result<Verdict, String> {
    unsafe {
        let result = umaqa(0usize, 0usize, 0usize);

        crate::cpu::fuzz(&mut || {
            let _ = umaqa(rand::random::<u64>() as usize, rand::random::<u64>() as usize, rand::random::<u64>() as usize);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
