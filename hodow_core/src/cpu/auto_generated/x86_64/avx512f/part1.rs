use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_avx512f_mm_cvtsd_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvti64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtu64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([1.0, 2.0]), 3u64));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvttss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([1.0, 2.0]), 3u64));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundsd_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u64::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_i64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx512f_mm_cvtt_roundss_u64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_cvtt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u64::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}
