#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm256_maskz_cvt_roundps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvt_roundps_ph::<0>(
            create__mmask8_from(0b01010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[15360, 16896, 17664, 18176])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvt_roundps_ph::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvt_roundps_ph::<0>(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[17664, 18176, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvt_roundps_ph::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvt_roundps_ph::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[15360, 16896, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvt_roundps_ph::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtps_ph::<8>(create__m512_from([
            1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
        ])));
        check_array_equality(&result, &[1073757184, 1140867584, 1174422784, 1207977728, 1224755328, 1241532800, 1258310272, 1275087744])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtps_ph::<8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtps_ph::<8>(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask16_from(0b0101010101010101),
            create__m512_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]),
        ));
        check_array_equality(&result, &[18560, 18816, 19072, 19328, 19520, 19648, 19776, 19904])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_ph::<8>(create_random__m256i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtps_ph::<8>(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[15360, 16896, 17664, 18176, 18560, 18816, 19072, 19328])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtps_ph::<8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtps_ph::<0>(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m256_from([5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0]),
        ));
        check_array_equality(&result, &[17664, 18176, 18560, 18816])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_ph::<0>(create_random__m128i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtps_ph::<0>(
            create__mmask8_from(0b01010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[15360, 16896, 17664, 18176])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtps_ph::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_ph::<0>(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[17664, 18176, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_ph::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtps_ph() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtps_ph::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[15360, 16896, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtps_ph::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundph_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_cvt_roundph_ps::<8>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0f32; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundph_ps::<8>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundph_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvt_roundph_ps::<8>(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_float_array_equality(
            &result,
            &[
                1.013279e-6,
                2.0,
                1.0728836e-6,
                4.0,
                1.1324883e-6,
                6.0,
                1.1920929e-6,
                8.0,
                1.2516975e-6,
                10.0,
                1.3113022e-6,
                12.0,
                1.3709068e-6,
                14.0,
                1.4305115e-6,
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
                let _ = _mm512_mask_cvt_roundph_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundph_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_cvt_roundph_ps::<8>(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
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
                let _ = _mm512_maskz_cvt_roundph_ps::<8>(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtph_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_cvtph_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0f32; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtph_ps(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtph_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtph_ps(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_float_array_equality(
            &result,
            &[
                1.013279e-6,
                2.0,
                1.0728836e-6,
                4.0,
                1.1324883e-6,
                6.0,
                1.1920929e-6,
                8.0,
                1.2516975e-6,
                10.0,
                1.3113022e-6,
                12.0,
                1.3709068e-6,
                14.0,
                1.4305115e-6,
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
                let _ = _mm512_mask_cvtph_ps(create_random__m512(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtph_ps() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_cvtph_ps(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
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
                let _ = _mm512_maskz_cvtph_ps(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtph_ps(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_float_array_equality(&result, &[5.364418e-7, 2.0, 5.9604645e-7, 4.0, 6.556511e-7, 6.0, 7.1525574e-7, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtph_ps(create_random__m256(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_cvtph_ps(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[5.9604645e-8, 0.0, 1.1920929e-7, 0.0, 1.7881393e-7, 0.0, 2.3841858e-7, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtph_ps(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtph_ps(
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_float_array_equality(&result, &[2.9802322e-7, 2.0, 3.5762787e-7, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtph_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtph_ps(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[5.9604645e-8, 0.0, 1.1920929e-7, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtph_ps(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundps_epi32::<8>(create__m512_from([
            1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
        ])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundps_epi32::<8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundps_epi32::<8>(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        ));
        check_array_equality(&result, &[17, 2, 19, 4, 21, 6, 23, 8, 25, 10, 27, 12, 29, 14, 31, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundps_epi32::<8>(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundps_epi32::<8>(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundps_epi32::<8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundps_epu32::<8>(create__m512_from([
            1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
        ])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundps_epu32::<8>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundps_epu32::<8>(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        ));
        check_array_equality(&result, &[17, 2, 19, 4, 21, 6, 23, 8, 25, 10, 27, 12, 29, 14, 31, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundps_epu32::<8>(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundps_epu32::<8>(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundps_epu32::<8>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundpd_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtt_roundpd_epi32::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundpd_epi32::<8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundpd_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtt_roundpd_epi32::<8>(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi32::<8>(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundpd_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtt_roundpd_epi32::<8>(
            create__mmask8_from(0b01010101),
            create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundpd_epi32::<8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundpd_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtt_roundpd_epu32::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundpd_epu32::<8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundpd_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtt_roundpd_epu32::<8>(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epu32::<8>(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvttps_epi32(create__m512_from([
            1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
        ])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvttps_epi32(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvttps_epi32(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        ));
        check_array_equality(&result, &[17, 2, 19, 4, 21, 6, 23, 8, 25, 10, 27, 12, 29, 14, 31, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttps_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvttps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttps_epi32(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvttps_epi32(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttps_epi32(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttps_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttps_epi32(
            create__mmask8_from(0b01010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvttps_epi32(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttps_epi32(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[5, 2, 7, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttps_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttps_epi32(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvttps_epi32(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvttps_epu32(create__m512_from([
            1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
        ])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvttps_epu32(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvttps_epu32(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        ));
        check_array_equality(&result, &[17, 2, 19, 4, 21, 6, 23, 8, 25, 10, 27, 12, 29, 14, 31, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttps_epu32(create_random__m512i(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttps_epu32(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvttps_epu32(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttps_epu32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttps_epu32(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttps_epu32(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttps_epu32(
            create__mmask8_from(0b01010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvttps_epu32(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttps_epu32(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttps_epu32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttps_epu32(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[5, 2, 7, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttps_epu32(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 3, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvttps_epu32(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundpd_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtt_roundpd_epu32::<8>(
            create__mmask8_from(0b01010101),
            create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundpd_epu32::<8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttpd_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvttpd_epi32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvttpd_epi32(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttpd_epi32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvttpd_epi32(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}
