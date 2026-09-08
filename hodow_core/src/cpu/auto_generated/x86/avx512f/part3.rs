#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 12.0, -3.0, 14.0, -5.0, 16.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 310.0, 400.0, 510.0, 600.0, 710.0, 800.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_roundscale_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_ps::<1>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_roundscale_ps::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_ps::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_ps::<1>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_roundscale_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_roundscale_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_ps::<1>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 12.0, -3.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 310.0, 400.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_roundscale_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_ps::<1>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_roundscale_ps::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_ps::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_ps::<1>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 0.0, f64::INFINITY, -f64::INFINITY, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_roundscale_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_roundscale_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_roundscale_pd::<1>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0, 12.0, -3.0, 14.0, -5.0, 16.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0, 310.0, 400.0, 510.0, 600.0, 710.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_roundscale_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_roundscale_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_roundscale_pd::<1>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -0.0, 0.0, f64::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_roundscale_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_roundscale_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_roundscale_pd::<1>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_roundscale_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_roundscale_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_roundscale_pd::<1>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0, 12.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0, 310.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_roundscale_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_roundscale_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_roundscale_pd::<1>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_roundscale_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_roundscale_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_roundscale_pd::<1>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<0>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<0>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_roundscale_pd::<1>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_roundscale_pd::<1>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_roundscale_pd::<1>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_roundscale_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_roundscale_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_roundscale_pd::<1>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_roundscale_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_roundscale_pd::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_roundscale_pd::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_roundscale_pd::<1>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[131072.0, 524288.0, 1572864.0, 4194304.0, 10485760.0, 25165824.0, 58720256.0, 134217730.0, 301989900.0, 671088640.0, 1476395000.0, 3221225500.0, 6979322000.0, 15032386000.0, 32212255000.0, 68719480000.0]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, -512.0, 8192.0, -384.0, 65536.0, -160.0, 393216.0, -56.0, 0.0, -512.0, 8192.0, -384.0, 65536.0, -160.0, 393216.0, -56.0]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[1.2980742e35, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, -0.0, 5.877472e-39, f32::INFINITY, f32::NAN, -0.0, 5.877472e-39, f32::INFINITY, f32::NAN, -0.0, 5.877472e-39, f32::INFINITY, f32::NAN, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0])));
        check_float_array_equality(&result, &[146028890000.0, 2.0, 652835000000.0, 4.0, 2886218000000.0, 6.0, 12644384000000.0, 8.0, 54975580000000.0, 10.0, 237494510000000.0, 12.0, 1020346800000000.0, 14.0, 4362862100000000.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[10485760.0, -1.0, 50331650.0, -3.0, 234881020.0, -5.0, 1073741800.0, -7.0, 10485760.0, -1.0, 50331650.0, -3.0, 234881020.0, -5.0, 1073741800.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32])));
        check_float_array_equality(&result, &[1.4621508e38, 200.0, f32::INFINITY, 400.0, f32::INFINITY, 600.0, f32::INFINITY, 800.0, f32::INFINITY, 1000.0, f32::INFINITY, 1200.0, f32::INFINITY, 1400.0, f32::INFINITY, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[131072.0, 0.0, 1572864.0, 0.0, 10485760.0, 0.0, 58720256.0, 0.0, 301989900.0, 0.0, 1476395000.0, 0.0, 6979322000.0, 0.0, 32212255000.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 8192.0, 0.0, 65536.0, 0.0, 393216.0, 0.0, 0.0, 0.0, 8192.0, 0.0, 65536.0, 0.0, 393216.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[1.2980742e35, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[512.0, 2048.0, 6144.0, 16384.0, 40960.0, 98304.0, 229376.0, 524288.0]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, -512.0, 8192.0, -384.0, 65536.0, -160.0, 393216.0, -56.0]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[1.2980742e35, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, -0.0, 5.877472e-39, f32::INFINITY, f32::NAN, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_ps(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[1179648.0, 2.0, 5767168.0, 4.0, 27262976.0, 6.0, 125829120.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[10485760.0, -1.0, 50331650.0, -3.0, 234881020.0, -5.0, 1073741800.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[1.4621508e38, 200.0, f32::INFINITY, 400.0, f32::INFINITY, 600.0, f32::INFINITY, 800.0]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38, -0.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[512.0, 0.0, 6144.0, 0.0, 40960.0, 0.0, 229376.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 8192.0, 0.0, 65536.0, 0.0, 393216.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[1.2980742e35, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[32.0, 128.0, 384.0, 1024.0]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -512.0, 8192.0, -384.0]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[1.2980742e35, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[2560.0, 2.0, 14336.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[10485760.0, -1.0, 50331650.0, -3.0]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[1.4621508e38, 200.0, f32::INFINITY, 400.0]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-0.0, -3.4028235e38, -0.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_scalef_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[32.0, 0.0, 384.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 8192.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[1.2980742e35, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[512.0, 2048.0, 6144.0, 16384.0, 40960.0, 98304.0, 229376.0, 524288.0]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[0.0, -512.0, 8192.0, -384.0, 65536.0, -160.0, 393216.0, -56.0]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[1.2980742146337069e35, 3.291009114642412e65, 6.257774519299541e95, 1.0576895500643978e126, 1.6759759912428246e156, 2.549462365520482e186, 3.770465414229874e216, 5.462437423415177e246]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN, -0.0, 1.1125369292536007e-308, f64::INFINITY, f64::NAN, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_scalef_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[1179648.0, 2.0, 5767168.0, 4.0, 27262976.0, 6.0, 125829120.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64, 24.0f64, 15.0f64, 26.0f64, 13.0f64])));
        check_float_array_equality(&result, &[10485760.0, -1.0, 50331648.0, -3.0, 234881024.0, -5.0, 1073741824.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64, 24.0f64, 15.0f64, 26.0f64, 13.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64, 520.0f64, 620.0f64, 720.0f64, 820.0f64])));
        check_float_array_equality(&result, &[1.4621507953634075e38, 200.0, 6.621559811354821e98, 400.0, 1.7505234033333055e159, 600.0, 3.916113106802411e219, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64, 520.0f64, 620.0f64, 720.0f64, 820.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-0.0, -1.7976931348623157e308, -0.0, -1.7976931348623157e308, -0.0, -1.7976931348623157e308, -0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_scalef_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_scalef_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[512.0, 0.0, 6144.0, 0.0, 40960.0, 0.0, 229376.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 8192.0, 0.0, 65536.0, 0.0, 393216.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[1.2980742146337069e35, 0.0, 6.257774519299541e95, 0.0, 1.6759759912428246e156, 0.0, 3.770465414229874e216, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -0.0, 0.0, f64::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_scalef_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[32.0, 128.0, 384.0, 1024.0]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[0.0, -512.0, 8192.0, -384.0]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[1.2980742146337069e35, 3.291009114642412e65, 6.257774519299541e95, 1.0576895500643978e126]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_scalef_pd(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[2560.0, 2.0, 14336.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[10485760.0, -1.0, 50331648.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[1.4621507953634075e38, 200.0, 6.621559811354821e98, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-0.0, -1.7976931348623157e308, -0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_scalef_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_scalef_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[32.0, 0.0, 384.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 8192.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[1.2980742146337069e35, 0.0, 6.257774519299541e95, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_scalef_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[8.0, 32.0]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -512.0]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[1.2980742146337069e35, 3.291009114642412e65]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_scalef_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[96.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[10485760.0, -1.0]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[1.4621507953634075e38, 200.0]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_scalef_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_scalef_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[8.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[1.2980742146337069e35, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_scalef_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_scalef_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_scalef_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 1600.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, -f32::INFINITY, f32::INFINITY, f32::INFINITY, -0.0, 0.0, -1.0, 1.0, 0.5, 90.0, 1.5707964, 3.4028235e38, -3.4028235e38, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<0>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_fixupimm_ps::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_ps::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_ps::<1>(create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::INFINITY, f32::NAN, -0.0, f32::NAN, -1.0, f32::NAN, 0.5, f32::NAN, 1.5707964, f32::NAN, -3.4028235e38, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_fixupimm_ps::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_ps::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_ps::<1>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0, 0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0, 900.0, 0.0, 1100.0, 0.0, 1300.0, 0.0, 1500.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::INFINITY, 0.0, -0.0, 0.0, -1.0, 0.0, 0.5, 0.0, 1.5707964, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<0>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_fixupimm_ps::<1>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_ps::<1>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_ps::<1>(create_random__mmask16(), create_random__m512(), create_random__m512(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, -f32::INFINITY, f32::INFINITY, f32::INFINITY, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<0>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fixupimm_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_ps::<1>(create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::INFINITY, f32::NAN, -0.0, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_fixupimm_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_ps::<1>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_fixupimm_ps::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_ps::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_ps::<1>(create_random__mmask8(), create_random__m256(), create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ps::<1>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ps::<1>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_ps_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ps::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_ps::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ps::<1>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::INFINITY, -0.0, -1.0, 0.5, 1.5707963267948966, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<0>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_fixupimm_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_fixupimm_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_fixupimm_pd::<1>(create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::INFINITY, f64::NAN, -1.0, f64::NAN, 1.5707963267948966, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_fixupimm_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_fixupimm_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_fixupimm_pd::<1>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::INFINITY, 0.0, -1.0, 0.0, 1.5707963267948966, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -0.0, 0.0, f64::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_fixupimm_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_fixupimm_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_fixupimm_pd::<1>(create_random__mmask8(), create_random__m512d(), create_random__m512d(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::INFINITY, -0.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<0>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fixupimm_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_fixupimm_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_fixupimm_pd::<1>(create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::INFINITY, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_fixupimm_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_fixupimm_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_fixupimm_pd::<1>(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_fixupimm_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_fixupimm_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_fixupimm_pd::<1>(create_random__mmask8(), create_random__m256d(), create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_fixupimm_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_pd::<1>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_fixupimm_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_pd::<1>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[100.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_fixupimm_pd_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_pd::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_fixupimm_pd::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_pd::<1>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}
