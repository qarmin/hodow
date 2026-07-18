#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm_cvtne2ps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm_mask_cvtne2ps_pbh(
            create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m128_from([9.0, 10.0, 11.0, 12.0]),
            create__m128_from([13.0, 14.0, 15.0, 16.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm_maskz_cvtne2ps_pbh(
            create__mmask8_from(0b01010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm256_cvtne2ps_pbh(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm256_mask_cvtne2ps_pbh(
            create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]),
            create__m256_from([25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm256_maskz_cvtne2ps_pbh(
            create__mmask16_from(0b0101010101010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm512_cvtne2ps_pbh(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm512_mask_cvtne2ps_pbh(
            create__m512bh_from([
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
            ]),
            create__mmask32_from(0x55555555u32),
            create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]),
            create__m512_from([49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0, 64.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtne2ps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm512_maskz_cvtne2ps_pbh(
            create__mmask32_from(0x55555555u32),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm256_cvtneps_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm256_mask_cvtneps_pbh(
            create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm512_cvtneps_pbh(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtneps_pbh(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm512_mask_cvtneps_pbh(
            create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm512_maskz_cvtneps_pbh(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]),
            create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]),
        ));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]),
            create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]),
        ));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(
            create__mmask8_from(0b01010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]),
            create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]),
        ));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]),
            create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]),
        ));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__mmask8_from(0b01010101),
            create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]),
            create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]),
        ));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(
            create__mmask8_from(0b01010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]),
            create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]),
        ));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__m512bh_from([
                17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
            ]),
            create__m512bh_from([
                49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
            ]),
        ));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__mmask16_from(0b0101010101010101),
            create__m512bh_from([
                17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
            ]),
            create__m512bh_from([
                49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
            ]),
        ));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_dpbf16_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__m512bh_from([
                17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
            ]),
            create__m512bh_from([
                49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
            ]),
        ));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_cvtpbh_ps(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0f32; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpbh_ps(create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__mmask16_from(0b0101010101010101),
            create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_float_array_equality(
            &result,
            &[
                1.561203e-39,
                2.0,
                1.744874e-39,
                4.0,
                1.928545e-39,
                6.0,
                2.112216e-39,
                8.0,
                2.295887e-39,
                10.0,
                2.479558e-39,
                12.0,
                2.66323e-39,
                14.0,
                2.8469e-39,
                16.0,
            ],
        )?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_cvtpbh_ps(
            create__mmask16_from(0b0101010101010101),
            create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_float_array_equality(&result, &[0.0f32; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpbh_ps(create_random__mmask16(), create_random__m256bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0f32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpbh_ps(create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__mmask8_from(0b01010101),
            create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_float_array_equality(&result, &[8.2652e-40, 2.0, 1.01019e-39, 4.0, 1.193861e-39, 6.0, 1.377532e-39, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0f32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpbh_ps(create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0f32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpbh_ps(create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[4.59177e-40, 2.0, 6.42848e-40, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0f32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpbh_ps(create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(
            create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m128_from([9.0, 10.0, 11.0, 12.0]),
        );

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtneps_pbh() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}
