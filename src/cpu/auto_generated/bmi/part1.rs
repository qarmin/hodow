use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_tzcnt_64() -> Result<(), String> {
    unsafe {
        let result = _mm_tzcnt_64(1u64);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_tzcnt_64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}
