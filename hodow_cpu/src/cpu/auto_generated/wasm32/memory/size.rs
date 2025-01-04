use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_memory_memory_size() -> Result<Verdict, String> {
    unsafe {
        let result = memory_size::<0>();

        crate::cpu::fuzz(&mut || {
            let _ = memory_size::<0>();
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
