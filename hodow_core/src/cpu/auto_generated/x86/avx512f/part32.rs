#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512f_mm512_extractf64x4_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm512_extractf64x4_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_extractf64x4_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_extractf64x4_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm512_mask_extractf64x4_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m512d_from([5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_extractf64x4_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_extractf64x4_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm512_maskz_extractf64x4_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_extractf64x4_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_extracti32x4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_extracti32x4_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_extracti32x4_epi32::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_extracti32x4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_mask_extracti32x4_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[5, 2, 7, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_extracti32x4_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_extracti32x4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_maskz_extracti32x4_epi32::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 3, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_extracti32x4_epi32::<0>(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_extracti32x4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti32x4_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extracti32x4_epi32::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_extracti32x4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_extracti32x4_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 2, 7, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_extracti32x4_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_extracti32x4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_extracti32x4_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 3, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_extracti32x4_epi32::<0>(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_moveldup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_moveldup_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 3.0, 5.0, 5.0, 7.0, 7.0, 9.0, 9.0, 11.0, 11.0, 13.0, 13.0, 15.0, 15.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_moveldup_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_moveldup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_moveldup_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[17.0, 2.0, 19.0, 4.0, 21.0, 6.0, 23.0, 8.0, 25.0, 10.0, 27.0, 12.0, 29.0, 14.0, 31.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_moveldup_ps(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_moveldup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_moveldup_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_moveldup_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_moveldup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_moveldup_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_moveldup_ps(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_moveldup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_moveldup_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_moveldup_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_moveldup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_moveldup_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_moveldup_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_moveldup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_moveldup_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_moveldup_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_movehdup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_movehdup_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[2.0, 2.0, 4.0, 4.0, 6.0, 6.0, 8.0, 8.0, 10.0, 10.0, 12.0, 12.0, 14.0, 14.0, 16.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movehdup_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_movehdup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_movehdup_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[18.0, 2.0, 20.0, 4.0, 22.0, 6.0, 24.0, 8.0, 26.0, 10.0, 28.0, 12.0, 30.0, 14.0, 32.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_movehdup_ps(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_movehdup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_movehdup_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[2.0, 0.0, 4.0, 0.0, 6.0, 0.0, 8.0, 0.0, 10.0, 0.0, 12.0, 0.0, 14.0, 0.0, 16.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_movehdup_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_movehdup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_movehdup_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[10.0, 2.0, 12.0, 4.0, 14.0, 6.0, 16.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_movehdup_ps(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_movehdup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_movehdup_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[2.0, 0.0, 4.0, 0.0, 6.0, 0.0, 8.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_movehdup_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_movehdup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_movehdup_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[6.0, 2.0, 8.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_movehdup_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_movehdup_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_movehdup_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 0.0, 4.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_movehdup_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_movedup_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_movedup_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 3.0, 5.0, 5.0, 7.0, 7.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movedup_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_movedup_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_movedup_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_movedup_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_movedup_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_movedup_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_movedup_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_movedup_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_movedup_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_movedup_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_movedup_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_movedup_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_movedup_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_movedup_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_movedup_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_movedup_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_movedup_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_movedup_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_movedup_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_inserti32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti32x4::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 18, 19, 20, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_inserti32x4::<0>(create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_inserti32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti32x4::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[33, 2, 35, 4, 21, 6, 23, 8, 25, 10, 27, 12, 29, 14, 31, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_inserti32x4::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_inserti32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti32x4::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 0, 19, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_inserti32x4::<0>(create_random__mmask16(), create_random__m512i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_inserti32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti32x4::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_inserti32x4::<0>(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_inserti32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti32x4::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 2, 19, 4, 13, 6, 15, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_inserti32x4::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_inserti32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti32x4::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 0, 11, 0, 5, 0, 7, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_inserti32x4::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_inserti64x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x4::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_inserti64x4::<0>(create_random__m512i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_inserti64x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x4::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m256i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[33, 34, 3, 4, 37, 38, 7, 8, 25, 26, 11, 12, 29, 30, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_inserti64x4::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_inserti64x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x4::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 18, 0, 0, 21, 22, 0, 0, 9, 10, 0, 0, 13, 14, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_inserti64x4::<0>(create_random__mmask8(), create_random__m512i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_insertf32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_insertf32x4::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m128_from([17.0, 18.0, 19.0, 20.0])));
        check_float_array_equality(&result, &[17.0, 18.0, 19.0, 20.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_insertf32x4::<0>(create_random__m512(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_insertf32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_insertf32x4::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m128_from([33.0, 34.0, 35.0, 36.0])));
        check_float_array_equality(&result, &[33.0, 2.0, 35.0, 4.0, 21.0, 6.0, 23.0, 8.0, 25.0, 10.0, 27.0, 12.0, 29.0, 14.0, 31.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_insertf32x4::<0>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_insertf32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_insertf32x4::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m128_from([17.0, 18.0, 19.0, 20.0])));
        check_float_array_equality(&result, &[17.0, 0.0, 19.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_insertf32x4::<0>(create_random__mmask16(), create_random__m512(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_insertf32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_insertf32x4::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[9.0, 10.0, 11.0, 12.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insertf32x4::<0>(create_random__m256(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_insertf32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_insertf32x4::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m128_from([17.0, 18.0, 19.0, 20.0])));
        check_float_array_equality(&result, &[17.0, 2.0, 19.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_insertf32x4::<0>(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_insertf32x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_insertf32x4::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[9.0, 0.0, 11.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_insertf32x4::<0>(create_random__mmask8(), create_random__m256(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_insertf64x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_insertf64x4::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[9.0, 10.0, 11.0, 12.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_insertf64x4::<0>(create_random__m512d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_insertf64x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_insertf64x4::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256d_from([17.0, 18.0, 19.0, 20.0])));
        check_float_array_equality(&result, &[17.0, 2.0, 19.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_insertf64x4::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_insertf64x4() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_insertf64x4::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[9.0, 0.0, 11.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_insertf64x4::<0>(create_random__mmask8(), create_random__m512d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_unpackhi_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[3, 19, 4, 20, 7, 23, 8, 24, 11, 27, 12, 28, 15, 31, 16, 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_unpackhi_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_unpackhi_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[19, 2, 20, 4, 23, 6, 24, 8, 27, 10, 28, 12, 31, 14, 32, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_unpackhi_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}
