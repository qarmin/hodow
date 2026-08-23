#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi16_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi16_si128(1i16));
        check_array_equality(&result, &[0i32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi16_si128(rand::random::<i16>());
            }
        }
    }
    Ok(())
}
