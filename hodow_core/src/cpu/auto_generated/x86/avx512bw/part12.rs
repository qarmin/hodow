#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm256_maskz_sra_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_sra_epi16(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[0i32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_sra_epi16(create_random__mmask16(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sra_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_sra_epi16(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[0i32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_sra_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sra_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_sra_epi16(
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[0i32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_sra_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srai_epi16::<0>(create__m512i_from_i32_array([
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
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
                let _ = _mm512_srai_epi16::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srai_epi16::<0>(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srai_epi16::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srai_epi16::<0>(
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srai_epi16::<0>(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srai_epi16::<0>(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srai_epi16::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srai_epi16::<0>(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srai_epi16::<0>(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srai_epi16::<0>(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srai_epi16::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srai_epi16::<0>(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_srav_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(&result, &[0i32; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srav_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_srav_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(&result, &[0i32; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srav_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_srav_epi16(
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(&result, &[0i32; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srav_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srav_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[0i32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srav_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_srav_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[0i32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srav_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_srav_epi16(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[0i32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srav_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srav_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srav_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_srav_epi16(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[0i32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srav_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_srav_epi16(
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[0i32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srav_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_permutex2var_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(
            &result,
            &[
                65536, 65546, 65536, 65547, 65536, 65548, 65536, 65549, 65536, 65550, 65536, 65551, 65536, 65552, 65536, 65569,
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
                let _ = _mm512_permutex2var_epi16(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_permutex2var_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(&result, &[0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0, 33])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_permutex2var_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_permutex2var_epi16(
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(&result, &[0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0, 33])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_permutex2var_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask2_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask2_permutex2var_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(&result, &[0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0, 33])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask2_permutex2var_epi16(create_random__m512i(), create_random__m512i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutex2var_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[65536, 65542, 65536, 65543, 65536, 65544, 65536, 65553])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutex2var_epi16(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_permutex2var_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[0, 6, 0, 7, 0, 8, 0, 17])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_permutex2var_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_permutex2var_epi16(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[0, 6, 0, 7, 0, 8, 0, 17])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_permutex2var_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask2_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask2_permutex2var_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[0, 6, 0, 7, 0, 8, 0, 17])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask2_permutex2var_epi16(create_random__m256i(), create_random__m256i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_permutex2var_epi16(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[65536, 65540, 65536, 65545])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutex2var_epi16(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_permutex2var_epi16(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[0, 4, 0, 9])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_permutex2var_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_permutex2var_epi16(
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[0, 4, 0, 9])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_permutex2var_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask2_permutex2var_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask2_permutex2var_epi16(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[0, 4, 0, 9])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask2_permutex2var_epi16(create_random__m128i(), create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_permutexvar_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(
            &result,
            &[
                1114112, 1114130, 1114112, 1114131, 1114112, 1114132, 1114112, 1114133, 1114112, 1114134, 1114112, 1114135, 1114112, 1114136, 1114112, 1114137,
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
                let _ = _mm512_permutexvar_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_permutexvar_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(&result, &[0, 42, 0, 43, 0, 44, 0, 45, 0, 46, 0, 47, 0, 48, 0, 33])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_permutexvar_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_permutexvar_epi16(
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(&result, &[0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0, 24, 0, 25])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_permutexvar_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutexvar_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[589824, 589834, 589824, 589835, 589824, 589836, 589824, 589837])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutexvar_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_permutexvar_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[0, 22, 0, 23, 0, 24, 0, 17])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_permutexvar_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_permutexvar_epi16(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[0, 10, 0, 11, 0, 12, 0, 13])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_permutexvar_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_permutexvar_epi16(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[327680, 327686, 327680, 327687])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutexvar_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_permutexvar_epi16(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[0, 12, 0, 9])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_permutexvar_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_permutexvar_epi16() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_permutexvar_epi16(
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[0, 6, 0, 7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_permutexvar_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_blend_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_blend_epi16(
            create__mmask32_from(0x55555555u32),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_blend_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_blend_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_blend_epi16(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_blend_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_blend_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_blend_epi16(
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_blend_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_blend_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_blend_epi8(
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_blend_epi8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_blend_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_blend_epi8(
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_blend_epi8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_blend_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_blend_epi8(
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_blend_epi8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_broadcastw_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(
            &result,
            &[
                65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537,
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
                let _ = _mm512_broadcastw_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_broadcastw_epi16(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask32_from(0x55555555u32),
            create__m128i_from_i32_array([17, 18, 19, 20]),
        ));
        check_array_equality(&result, &[17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_broadcastw_epi16(
            create__mmask32_from(0x55555555u32),
            create__m128i_from_i32_array([1, 2, 3, 4]),
        ));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_broadcastw_epi16(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[9, 9, 9, 9, 9, 9, 9, 9])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}
