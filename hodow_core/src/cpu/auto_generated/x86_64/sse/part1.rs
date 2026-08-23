use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_sse_mm_cvtss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}
