#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm512_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_permutex2var_epi8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(
            &result,
            &[
                16843008, 16843008, 16843008, 16843014, 16843008, 16843008, 16843008, 16843015, 16843008, 16843008, 16843008, 16843016, 16843008, 16843008, 16843008, 16843017,
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
                let _ = _mm512_permutex2var_epi8(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_permutex2var_epi8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(
            &result,
            &[
                65536, 65536, 65536, 65542, 65536, 65536, 65536, 65543, 65536, 65536, 65536, 65544, 65536, 65536, 65536, 65545,
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
                let _ = _mm512_mask_permutex2var_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_permutex2var_epi8(
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(
            &result,
            &[
                65536, 65536, 65536, 65542, 65536, 65536, 65536, 65543, 65536, 65536, 65536, 65544, 65536, 65536, 65536, 65545,
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
                let _ = _mm512_maskz_permutex2var_epi8(create_random__mmask64(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask2_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask2_permutex2var_epi8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(
            &result,
            &[
                65536, 65536, 65536, 65542, 65536, 65536, 65536, 65543, 65536, 65536, 65536, 65544, 65536, 65536, 65536, 65545,
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
                let _ = _mm512_mask2_permutex2var_epi8(create_random__m512i(), create_random__m512i(), create_random__mmask64(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutex2var_epi8(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[16843008, 16843008, 16843008, 16843012, 16843008, 16843008, 16843008, 16843013])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutex2var_epi8(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_permutex2var_epi8(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[65536, 65536, 65536, 65540, 65536, 65536, 65536, 65541])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_permutex2var_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_permutex2var_epi8(
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[65536, 65536, 65536, 65540, 65536, 65536, 65536, 65541])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_permutex2var_epi8(create_random__mmask32(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask2_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask2_permutex2var_epi8(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[65536, 65536, 65536, 65540, 65536, 65536, 65536, 65541])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask2_permutex2var_epi8(create_random__m256i(), create_random__m256i(), create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_permutex2var_epi8(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[16843008, 16843008, 16843008, 16843011])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutex2var_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_permutex2var_epi8(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[65536, 65536, 65536, 65539])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_permutex2var_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_permutex2var_epi8(
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[65536, 65536, 65536, 65539])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_permutex2var_epi8(create_random__mmask16(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask2_permutex2var_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask2_permutex2var_epi8(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[65536, 65536, 65536, 65539])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask2_permutex2var_epi8(create_random__m128i(), create_random__m128i(), create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_permutexvar_epi8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(
            &result,
            &[
                286331136, 286331136, 286331136, 286331154, 286331136, 286331136, 286331136, 286331155, 286331136, 286331136, 286331136, 286331156, 286331136, 286331136,
                286331136, 286331157,
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
                let _ = _mm512_permutexvar_epi8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_permutexvar_epi8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(
            &result,
            &[
                2162688, 2162688, 2162688, 2162726, 2162688, 2162688, 2162688, 2162727, 2162688, 2162688, 2162688, 2162728, 2162688, 2162688, 2162688, 2162729,
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
                let _ = _mm512_mask_permutexvar_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_permutexvar_epi8(
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(
            &result,
            &[
                1114112, 1114112, 1114112, 1114130, 1114112, 1114112, 1114112, 1114131, 1114112, 1114112, 1114112, 1114132, 1114112, 1114112, 1114112, 1114133,
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
                let _ = _mm512_maskz_permutexvar_epi8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutexvar_epi8(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[151587072, 151587072, 151587072, 151587082, 151587072, 151587072, 151587072, 151587083])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutexvar_epi8(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_permutexvar_epi8(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[1114112, 1114112, 1114112, 1114132, 1114112, 1114112, 1114112, 1114133])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_permutexvar_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_permutexvar_epi8(
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[589824, 589824, 589824, 589834, 589824, 589824, 589824, 589835])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_permutexvar_epi8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_permutexvar_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[84215040, 84215040, 84215040, 84215046])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutexvar_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_permutexvar_epi8(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[589824, 589824, 589824, 589835])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_permutexvar_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_permutexvar_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_permutexvar_epi8(
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[327680, 327680, 327680, 327686])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_permutexvar_epi8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_multishift_epi64_epi8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(
            &result,
            &[
                286331144, 286331140, 320017154, 320017153, 353703168, 353703168, 387389184, 387389184, 421075200, 421075200, 454761216, 454761216, 488447232, 488447232,
                522133248, 522133248,
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
                let _ = _mm512_multishift_epi64_epi8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_multishift_epi64_epi8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
            create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]),
        ));
        check_array_equality(
            &result,
            &[
                2162688, 2162688, 2293760, 2293760, 2424832, 2424832, 2555904, 2555904, 2686976, 2687104, 2818176, 2818240, 2949232, 2949304, 3080288, 3080240,
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
                let _ = _mm512_mask_multishift_epi64_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_multishift_epi64_epi8(
            create__mmask64_from(0x5555555555555555u64),
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]),
        ));
        check_array_equality(
            &result,
            &[
                1114120, 1114116, 1245186, 1245185, 1376256, 1376256, 1507328, 1507328, 1638400, 1638400, 1769472, 1769472, 1900544, 1900544, 2031616, 2031616,
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
                let _ = _mm512_maskz_multishift_epi64_epi8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_multishift_epi64_epi8(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[151587076, 151587074, 185273089, 185273088, 218959104, 218959104, 252645120, 252645120])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_multishift_epi64_epi8(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_multishift_epi64_epi8(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[1114112, 1114112, 1245184, 1245184, 1376256, 1376256, 1507328, 1507328])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_multishift_epi64_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_multishift_epi64_epi8(
            create__mmask32_from(0x55555555u32),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]),
        ));
        check_array_equality(&result, &[589828, 589826, 720897, 720896, 851968, 851968, 983040, 983040])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_multishift_epi64_epi8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_multishift_epi64_epi8(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[84215042, 84215041, 117901056, 117901056])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_multishift_epi64_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_multishift_epi64_epi8(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[589824, 589824, 720896, 720896])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_multishift_epi64_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_multishift_epi64_epi8() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_multishift_epi64_epi8(
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[327682, 327681, 458752, 458752])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_multishift_epi64_epi8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
