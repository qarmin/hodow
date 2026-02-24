use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_crc32_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u64(1u64, 2u64);
        check_int_equality(result as i32, -616265879)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_crc32_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}
