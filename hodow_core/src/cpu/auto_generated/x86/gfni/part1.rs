#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_gfni_mm512_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_gf2p8mul_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 36, 53, 80, 65, 116, 101, 192, 209, 228, 245, 144, 129, 180, 165, 54])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_gf2p8mul_epi8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_gf2p8mul_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[7, 82, 99, 230, 215, 130, 179, 237, 220, 137, 184, 61, 12, 89, 104, 90])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_gf2p8mul_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_gf2p8mul_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 36, 53, 80, 65, 116, 101, 192, 209, 228, 245, 144, 129, 180, 165, 54])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_gf2p8mul_epi8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_gf2p8mul_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 20, 29, 48, 57, 36, 45, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_gf2p8mul_epi8(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_gf2p8mul_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[153, 180, 173, 240, 233, 196, 221, 155])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_gf2p8mul_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_gf2p8mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 20, 29, 48, 57, 36, 45, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_gf2p8mul_epi8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_gf2p8mul_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 9, 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_gf2p8mul_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_gf2p8mul_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 60, 49, 96])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_gf2p8mul_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_gf2p8mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 9, 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_gf2p8mul_epi8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_gf2p8affine_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[128, 8, 0, 8, 8, 128, 128, 8, 8, 128, 136, 128, 128, 8, 0, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_gf2p8affine_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_gf2p8affine_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[128, 8, 0, 8, 8, 128, 128, 8, 8, 128, 136, 128, 128, 8, 0, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_gf2p8affine_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_gf2p8affine_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[128, 8, 0, 8, 8, 128, 128, 8, 8, 128, 136, 128, 128, 8, 8, 136])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_gf2p8affine_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_gf2p8affine_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[128, 8, 0, 8, 8, 128, 128, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_gf2p8affine_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_gf2p8affine_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[128, 8, 0, 8, 8, 128, 128, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_gf2p8affine_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_gf2p8affine_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[128, 8, 0, 8, 8, 128, 136, 136])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_gf2p8affine_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_gf2p8affine_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[128, 8, 0, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_gf2p8affine_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_gf2p8affine_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[128, 8, 0, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_gf2p8affine_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_gf2p8affine_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[128, 8, 8, 136])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_gf2p8affine_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[128, 128, 0, 0, 128, 0, 8, 8, 0, 8, 0, 136, 128, 8, 128, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[128, 128, 0, 0, 128, 0, 8, 8, 0, 8, 0, 136, 128, 8, 128, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[136, 128, 0, 128, 0, 136, 136, 8, 136, 128, 128, 8, 0, 128, 0, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[128, 8, 136, 136, 8, 0, 136, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[128, 8, 136, 136, 8, 0, 136, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[136, 128, 0, 136, 128, 8, 128, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[128, 8, 0, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[128, 8, 0, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[8, 0, 128, 136])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
