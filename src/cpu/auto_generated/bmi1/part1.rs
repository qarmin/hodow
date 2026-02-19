use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_tzcnt_32() -> Result<(), String> {
    unsafe {
        let result = _mm_tzcnt_32(1u32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_tzcnt_32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}
