use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_stream_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = 2i64;
        _mm_stream_si64(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi64_si128(1i64));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_si128(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi64x_si128(1i64));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_si128(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}
