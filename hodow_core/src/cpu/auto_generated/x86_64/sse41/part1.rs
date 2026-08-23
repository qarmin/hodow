use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_sse41_mm_extract_epi64() -> Result<(), String> {
    unsafe {
        let result = _mm_extract_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_extract_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extract_epi64::<0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i64));
        check_array_equality(&result, &[5, 0, 3, 4]).map_err(|e| format!("{e} | call: _mm_insert_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}
