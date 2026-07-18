#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_fnmsub_round_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fnmsub_round_sd::<8>(
            create__mmask8_from(0b01010101),
            create__m128d_from([1.0, 2.0]),
            create__m128d_from([3.0, 4.0]),
            create__m128d_from([5.0, 6.0]),
        ));
        check_float_array_equality(&result, &[-8.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fnmsub_round_sd::<8>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_round_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask3_fnmsub_round_sd::<8>(
            create__m128d_from([1.0, 2.0]),
            create__m128d_from([3.0, 4.0]),
            create__m128d_from([5.0, 6.0]),
            create__mmask8_from(0b01010101),
        ));
        check_float_array_equality(&result, &[-8.0, 6.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask3_fnmsub_round_sd::<8>(create_random__m128d(), create_random__m128d(), create_random__m128d(), create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ss::<0>(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[1.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_ss::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_ss::<0>(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[1.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_ss::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_ss::<0>(
            create__mmask8_from(0b01010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[1.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_ss::<0>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_sd::<0>(
            create__m128d_from([1.0, 2.0]),
            create__m128d_from([3.0, 4.0]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_float_array_equality(&result, &[1.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_sd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_sd::<0>(
            create__m128d_from([1.0, 2.0]),
            create__mmask8_from(0b01010101),
            create__m128d_from([3.0, 4.0]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_float_array_equality(&result, &[1.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_sd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_sd::<0>(
            create__mmask8_from(0b01010101),
            create__m128d_from([1.0, 2.0]),
            create__m128d_from([3.0, 4.0]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_float_array_equality(&result, &[1.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_sd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_round_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_round_ss::<0, 8>(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[1.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_round_ss::<0, 8>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_round_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_fixupimm_round_ss::<0, 8>(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[1.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_round_ss::<0, 8>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_round_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_fixupimm_round_ss::<0, 8>(
            create__mmask8_from(0b01010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[1.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_round_ss::<0, 8>(create_random__mmask8(), create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_round_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_round_sd::<0, 8>(
            create__m128d_from([1.0, 2.0]),
            create__m128d_from([3.0, 4.0]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_float_array_equality(&result, &[1.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_fixupimm_round_sd::<0, 8>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_round_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_fixupimm_round_sd::<0, 8>(
            create__m128d_from([1.0, 2.0]),
            create__mmask8_from(0b01010101),
            create__m128d_from([3.0, 4.0]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_float_array_equality(&result, &[1.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_fixupimm_round_sd::<0, 8>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_round_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_fixupimm_round_sd::<0, 8>(
            create__mmask8_from(0b01010101),
            create__m128d_from([1.0, 2.0]),
            create__m128d_from([3.0, 4.0]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_float_array_equality(&result, &[1.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_fixupimm_round_sd::<0, 8>(create_random__mmask8(), create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtss_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtss_sd(
            create__m128d_from([1.0, 2.0]),
            create__mmask8_from(0b01010101),
            create__m128d_from([3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        ));
        check_float_array_equality(&result, &[5.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtss_sd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtss_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtss_sd(
            create__mmask8_from(0b01010101),
            create__m128d_from([1.0, 2.0]),
            create__m128_from([3.0, 4.0, 5.0, 6.0]),
        ));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtss_sd(create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsd_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtsd_ss(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128d_from([9.0, 10.0]),
        ));
        check_float_array_equality(&result, &[9.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsd_ss(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsd_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtsd_ss(
            create__mmask8_from(0b01010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128d_from([5.0, 6.0]),
        ));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsd_ss(create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundss_sd::<8>(create__m128d_from([1.0, 2.0]), create__m128_from([3.0, 4.0, 5.0, 6.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_sd::<8>(create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundss_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvt_roundss_sd::<8>(
            create__m128d_from([1.0, 2.0]),
            create__mmask8_from(0b01010101),
            create__m128d_from([3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        ));
        check_float_array_equality(&result, &[5.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvt_roundss_sd::<8>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundss_sd() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvt_roundss_sd::<8>(
            create__mmask8_from(0b01010101),
            create__m128d_from([1.0, 2.0]),
            create__m128_from([3.0, 4.0, 5.0, 6.0]),
        ));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvt_roundss_sd::<8>(create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsd_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_ss::<8>(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsd_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvt_roundsd_ss::<8>(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
            create__m128d_from([9.0, 10.0]),
        ));
        check_float_array_equality(&result, &[9.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvt_roundsd_ss::<8>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsd_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvt_roundsd_ss::<8>(
            create__mmask8_from(0b01010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128d_from([5.0, 6.0]),
        ));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvt_roundsd_ss::<8>(create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_si32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvt_roundss_si32::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_si32::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvt_roundss_i32::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_i32::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvt_roundss_u32::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundss_u32::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtss_i32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_i32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtss_u32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_u32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_si32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvt_roundsd_si32::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_si32::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvt_roundsd_i32::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_i32::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvt_roundsd_u32::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsd_u32::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtsd_i32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_i32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtsd_u32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_u32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi32_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi32_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i32));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundi32_ss::<8>(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi32_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi32_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i32));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundsi32_ss::<8>(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu32_ss() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu32_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u32));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_roundu32_ss::<8>(create_random__m128(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti32_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i32));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti32_ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti32_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti32_sd(create__m128d_from([1.0, 2.0]), 3i32));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvti32_sd(create_random__m128d(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_si32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtt_roundss_si32::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_si32::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtt_roundss_i32::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_i32::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtt_roundss_u32::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundss_u32::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvttss_i32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_i32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvttss_u32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_u32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_si32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtt_roundsd_si32::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_si32::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtt_roundsd_i32::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_i32::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvtt_roundsd_u32::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_roundsd_u32::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_i32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvttsd_i32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_i32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_u32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _mm_cvttsd_u32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_u32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu32_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u32));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtu32_ss(create_random__m128(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}
