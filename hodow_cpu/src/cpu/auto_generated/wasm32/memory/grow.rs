use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_memory_memory_grow() -> Result<Verdict, String> {
    unsafe {
        let result = memory_grow::<0>(0usize);

        crate::cpu::fuzz(&mut || {
            let _ = memory_grow::<0>(rand::random::<u64>() as usize);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
