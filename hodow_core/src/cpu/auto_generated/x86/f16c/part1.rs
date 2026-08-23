#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_f16c_mm_cvtph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtph_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0f32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtph_ps(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_f16c_mm256_cvtph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cvtph_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0f32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtph_ps(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_f16c_mm_cvtps_ph() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtps_ph::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 1174422784, 1207977728])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_ph::<0>(create_random__m256());
            }
        }
    }
    Ok(())
}
