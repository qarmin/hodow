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
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm256_maskz_sra_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_sra_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 16])?;

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
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_mask_sra_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7])?;

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

pub(super) fn test_mm_mask_sra_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800])?;

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

pub(super) fn test_mm_mask_sra_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768])?;

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

pub(super) fn test_mm_mask_sra_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767])?;

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

pub(super) fn test_mm_mask_sra_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_mask_sra_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_mask_sra_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 32767, 0, -1, -1, 32767, 0, -1])?;

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

pub(super) fn test_mm_mask_sra_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768])?;

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

pub(super) fn test_mm_mask_sra_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_sra_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, -1, 32767, -1, 32767])?;

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
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_sra_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_sra_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_sra_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm_maskz_sra_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_sra_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_sra_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm_maskz_sra_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0])?;

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

pub(super) fn test_mm_maskz_sra_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm_maskz_sra_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_sra_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8])?;

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
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0])?;

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

pub(super) fn test_mm512_srai_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])?;

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

pub(super) fn test_mm512_srai_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])?;

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

pub(super) fn test_mm512_srai_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

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

pub(super) fn test_mm512_srai_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

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

pub(super) fn test_mm512_srai_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_srai_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_srai_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

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

pub(super) fn test_mm512_srai_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0])?;

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

pub(super) fn test_mm512_srai_epi16_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 2, 0, 3, 0, 3, 0, 4, 0, 4, 0, 5, 0, 5, 0, 6, 0, 6, 0, 7, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srai_epi16::<1>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_srai_epi16_imm_width_m1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<15>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srai_epi16::<15>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_srai_epi16_imm_width() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srai_epi16::<16>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_srai_epi16::<16>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0, 24, 0, 25, 0, 26, 0, 27, 0, 28, 0, 29, 0, 30, 0, 31, 0, 32, 0])?;

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

pub(super) fn test_mm512_mask_srai_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm512_mask_srai_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[110, 200, 310, 400, 510, 600, 710, 800, 910, 1000, 1110, 1200, 1310, 1400, 1510, 1600, 1710, 1800, 1910, 2000, 2110, 2200, 2310, 2400, 2510, 2600, 2710, 2800, 2910, 3000, 3110, 3200])?;

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

pub(super) fn test_mm512_mask_srai_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

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

pub(super) fn test_mm512_mask_srai_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

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

pub(super) fn test_mm512_mask_srai_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_mask_srai_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_mask_srai_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

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

pub(super) fn test_mm512_mask_srai_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768])?;

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

pub(super) fn test_mm512_mask_srai_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767])?;

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

pub(super) fn test_mm512_mask_srai_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0, 24, 0, 25, 0, 26, 0, 27, 0, 28, 0, 29, 0, 30, 0, 31, 0, 32, 0])?;

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

pub(super) fn test_mm512_mask_srai_epi16_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[8, 0, 9, 0, 9, 0, 10, 0, 10, 0, 11, 0, 11, 0, 12, 0, 12, 0, 13, 0, 13, 0, 14, 0, 14, 0, 15, 0, 15, 0, 16, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srai_epi16::<1>(create_random__m512i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_srai_epi16_imm_width_m1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<15>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srai_epi16::<15>(create_random__m512i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_srai_epi16_imm_width() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srai_epi16::<16>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_srai_epi16::<16>(create_random__m512i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 2, 0, 4, 0, 6, 0, 0, 0, 2, 0, 4, 0, 6, 0, 0, 0, 2, 0, 4, 0, 6, 0, 0, 0, 2, 0, 4, 0, 6, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[100, 0, 300, 0, 500, 0, 700, 0, 900, 0, 1100, 0, 1300, 0, 1500, 0, 1700, 0, 1900, 0, 2100, 0, 2300, 0, 2500, 0, 2700, 0, 2900, 0, 3100, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0])?;

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

pub(super) fn test_mm512_maskz_srai_epi16_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<1>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 2, 0, 3, 0, 3, 0, 4, 0, 4, 0, 5, 0, 5, 0, 6, 0, 6, 0, 7, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srai_epi16::<1>(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_srai_epi16_imm_width_m1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<15>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srai_epi16::<15>(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_srai_epi16_imm_width() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srai_epi16::<16>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_srai_epi16::<16>(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0])?;

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

pub(super) fn test_mm256_mask_srai_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm256_mask_srai_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[110, 200, 310, 400, 510, 600, 710, 800, 910, 1000, 1110, 1200, 1310, 1400, 1510, 1600])?;

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

pub(super) fn test_mm256_mask_srai_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

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

pub(super) fn test_mm256_mask_srai_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

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

pub(super) fn test_mm256_mask_srai_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_mask_srai_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm256_mask_srai_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

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

pub(super) fn test_mm256_mask_srai_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768])?;

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

pub(super) fn test_mm256_mask_srai_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767])?;

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

pub(super) fn test_mm256_mask_srai_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0])?;

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

pub(super) fn test_mm256_mask_srai_epi16_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4, 0, 5, 0, 5, 0, 6, 0, 6, 0, 7, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srai_epi16::<1>(create_random__m256i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_srai_epi16_imm_width_m1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<15>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srai_epi16::<15>(create_random__m256i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_srai_epi16_imm_width() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srai_epi16::<16>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_srai_epi16::<16>(create_random__m256i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 2, 0, 4, 0, 6, 0, 0, 0, 2, 0, 4, 0, 6, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[100, 0, 300, 0, 500, 0, 700, 0, 900, 0, 1100, 0, 1300, 0, 1500, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

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

pub(super) fn test_mm256_maskz_srai_epi16_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<1>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 2, 0, 3, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srai_epi16::<1>(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_srai_epi16_imm_width_m1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<15>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srai_epi16::<15>(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_srai_epi16_imm_width() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srai_epi16::<16>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_srai_epi16::<16>(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0])?;

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

pub(super) fn test_mm_mask_srai_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm_mask_srai_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 310, 400, 510, 600, 710, 800])?;

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

pub(super) fn test_mm_mask_srai_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

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

pub(super) fn test_mm_mask_srai_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

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

pub(super) fn test_mm_mask_srai_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_mask_srai_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_mask_srai_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

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

pub(super) fn test_mm_mask_srai_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768])?;

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

pub(super) fn test_mm_mask_srai_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767])?;

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

pub(super) fn test_mm_mask_srai_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0])?;

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

pub(super) fn test_mm_mask_srai_epi16_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 0, 3, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srai_epi16::<1>(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_srai_epi16_imm_width_m1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<15>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srai_epi16::<15>(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_srai_epi16_imm_width() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srai_epi16::<16>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_srai_epi16::<16>(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srai_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 2, 0, 4, 0, 6, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 300, 0, 500, 0, 700, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_srai_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, 0, 0, -32768, 0, 0, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

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

pub(super) fn test_mm_maskz_srai_epi16_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<1>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srai_epi16::<1>(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srai_epi16_imm_width_m1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<15>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srai_epi16::<15>(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srai_epi16_imm_width() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srai_epi16::<16>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_srai_epi16::<16>(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_srav_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1])?;

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

pub(super) fn test_mm512_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1])?;

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

pub(super) fn test_mm512_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_srav_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 32])?;

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
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_mask_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7])?;

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

pub(super) fn test_mm512_mask_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]), create__m512i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420, 2520, 2620, 2720, 2820, 2920, 3020, 3120, 3220])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800, 0, 1000, 0, 1200, 0, 1400, 0, 1600, 0, 1800, 0, 2000, 0, 2200, 0, 2400, 0, 2600, 0, 2800, 0, 3000, 0, 3200])?;

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

pub(super) fn test_mm512_mask_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768])?;

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

pub(super) fn test_mm512_mask_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767])?;

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

pub(super) fn test_mm512_mask_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_mask_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_mask_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1])?;

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

pub(super) fn test_mm512_mask_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[16383, -32768, 8191, -32768, 4095, -32768, 2047, -32768, 1023, -32768, 511, -32768, 255, -32768, 127, -32768, 63, -32768, 31, -32768, 15, -32768, 7, -32768, 3, -32768, 1, -32768, 0, -32768, 0, -32768])?;

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

pub(super) fn test_mm512_mask_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_srav_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-16384, 32767, -8192, 32767, -4096, 32767, -2048, 32767, -1024, 32767, -512, 32767, -256, 32767, -128, 32767, -64, 32767, -32, 32767, -16, 32767, -8, 32767, -4, 32767, -2, 32767, -1, 32767, -1, 32767])?;

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
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm512_maskz_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_srav_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 32])?;

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
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1])?;

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

pub(super) fn test_mm256_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm256_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm256_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1])?;

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

pub(super) fn test_mm256_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm256_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srav_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 16])?;

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
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_mask_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7])?;

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

pub(super) fn test_mm256_mask_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m256i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800, 0, 1000, 0, 1200, 0, 1400, 0, 1600])?;

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

pub(super) fn test_mm256_mask_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768, -1, -32768])?;

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

pub(super) fn test_mm256_mask_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767])?;

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

pub(super) fn test_mm256_mask_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_mask_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm256_mask_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1, -1, 32767, 0, -1])?;

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

pub(super) fn test_mm256_mask_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[16383, -32768, 8191, -32768, 4095, -32768, 2047, -32768, 1023, -32768, 511, -32768, 255, -32768, 127, -32768])?;

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

pub(super) fn test_mm256_mask_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_srav_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-16384, 32767, -8192, 32767, -4096, 32767, -2048, 32767, -1024, 32767, -512, 32767, -256, 32767, -128, 32767])?;

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
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm256_maskz_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_srav_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 16])?;

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
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1])?;

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

pub(super) fn test_mm_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1])?;

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

pub(super) fn test_mm_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srav_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8])?;

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
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_mask_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7])?;

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

pub(super) fn test_mm_mask_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800])?;

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

pub(super) fn test_mm_mask_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -32768, -1, -32768, -1, -32768, -1, -32768])?;

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

pub(super) fn test_mm_mask_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767])?;

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

pub(super) fn test_mm_mask_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_mask_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_mask_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 32767, 0, -1, -1, 32767, 0, -1])?;

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

pub(super) fn test_mm_mask_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[16383, -32768, 8191, -32768, 4095, -32768, 2047, -32768])?;

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

pub(super) fn test_mm_mask_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_srav_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-16384, 32767, -8192, 32767, -4096, 32767, -2048, 32767])?;

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
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_srav_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_srav_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_srav_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm_maskz_srav_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_srav_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_maskz_srav_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm_maskz_srav_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, 0, -1, 0, 0, 0])?;

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

pub(super) fn test_mm_maskz_srav_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0])?;

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

pub(super) fn test_mm_maskz_srav_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_srav_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8])?;

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
        let result = unpack__m512i_to_i32_array(_mm512_permutex2var_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[65536, 65546, 65536, 65547, 65536, 65548, 65536, 65549, 65536, 65550, 65536, 65551, 65536, 65552, 65536, 65569])?;

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
        let result = unpack__m512i_to_i32_array(_mm512_mask_permutex2var_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
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
        let result = unpack__m512i_to_i32_array(_mm512_maskz_permutex2var_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
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
        let result = unpack__m512i_to_i32_array(_mm512_mask2_permutex2var_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
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
        let result = unpack__m256i_to_i32_array(_mm256_permutex2var_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
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
        let result = unpack__m256i_to_i32_array(_mm256_mask_permutex2var_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
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
        let result = unpack__m256i_to_i32_array(_mm256_maskz_permutex2var_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
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
        let result = unpack__m256i_to_i32_array(_mm256_mask2_permutex2var_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
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
        let result = unpack__m128i_to_i32_array(_mm_permutex2var_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
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
        let result = unpack__m128i_to_i32_array(_mm_mask_permutex2var_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
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
        let result = unpack__m128i_to_i32_array(_mm_maskz_permutex2var_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
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
        let result = unpack__m128i_to_i32_array(_mm_mask2_permutex2var_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12])));
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
        let result = unpack__m512i_to_i32_array(_mm512_permutexvar_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1114112, 1114130, 1114112, 1114131, 1114112, 1114132, 1114112, 1114133, 1114112, 1114134, 1114112, 1114135, 1114112, 1114136, 1114112, 1114137])?;

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
        let result = unpack__m512i_to_i32_array(_mm512_mask_permutexvar_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
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
        let result = unpack__m512i_to_i32_array(_mm512_maskz_permutexvar_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
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
        let result = unpack__m256i_to_i32_array(_mm256_permutexvar_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
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
        let result = unpack__m256i_to_i32_array(_mm256_mask_permutexvar_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
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
        let result = unpack__m256i_to_i32_array(_mm256_maskz_permutexvar_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
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
        let result = unpack__m128i_to_i32_array(_mm_permutexvar_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
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
        let result = unpack__m128i_to_i32_array(_mm_mask_permutexvar_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
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
        let result = unpack__m128i_to_i32_array(_mm_maskz_permutexvar_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
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
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0, 24, 0, 25, 0, 26, 0, 27, 0, 28, 0, 29, 0, 30, 0, 31, 0, 32, 0])?;

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

pub(super) fn test_mm512_mask_blend_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm512_mask_blend_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[110, 200, 310, 400, 510, 600, 710, 800, 910, 1000, 1110, 1200, 1310, 1400, 1510, 1600, 1710, 1800, 1910, 2000, 2110, 2200, 2310, 2400, 2510, 2600, 2710, 2800, 2910, 3000, 3110, 3200])?;

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

pub(super) fn test_mm512_mask_blend_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

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

pub(super) fn test_mm512_mask_blend_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

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

pub(super) fn test_mm512_mask_blend_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm512_mask_blend_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_mask_blend_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

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

pub(super) fn test_mm512_mask_blend_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768])?;

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

pub(super) fn test_mm512_mask_blend_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_blend_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767])?;

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
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0])?;

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

pub(super) fn test_mm256_mask_blend_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm256_mask_blend_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[110, 200, 310, 400, 510, 600, 710, 800, 910, 1000, 1110, 1200, 1310, 1400, 1510, 1600])?;

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

pub(super) fn test_mm256_mask_blend_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

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

pub(super) fn test_mm256_mask_blend_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

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

pub(super) fn test_mm256_mask_blend_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm256_mask_blend_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm256_mask_blend_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

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

pub(super) fn test_mm256_mask_blend_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768])?;

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

pub(super) fn test_mm256_mask_blend_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_blend_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767])?;

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
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0])?;

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

pub(super) fn test_mm_mask_blend_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm_mask_blend_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 310, 400, 510, 600, 710, 800])?;

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

pub(super) fn test_mm_mask_blend_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

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

pub(super) fn test_mm_mask_blend_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

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

pub(super) fn test_mm_mask_blend_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

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

pub(super) fn test_mm_mask_blend_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_mask_blend_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

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

pub(super) fn test_mm_mask_blend_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768])?;

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

pub(super) fn test_mm_mask_blend_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_blend_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767])?;

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
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 0, 0, 18, 0, 0, 0, 19, 0, 0, 0, 20, 0, 0, 0, 21, 0, 0, 0, 22, 0, 0, 0, 23, 0, 0, 0, 24, 0, 0, 0, 25, 0, 0, 0, 26, 0, 0, 0, 27, 0, 0, 0, 28, 0, 0, 0, 29, 0, 0, 0, 30, 0, 0, 0, 31, 0, 0, 0, 32, 0, 0, 0])?;

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

pub(super) fn test_mm512_mask_blend_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm512_mask_blend_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10])));
        check_array_equality(&result, &[110, -56, 54, -112, -2, 88, -58, 32, -114, -24, 86, -80, 30, 120, -26, 64, -82, 8, 118, -48, 62, -104, 6, 96, -50, 40, -106, -16, 94, -72, 38, -128, -18, 72, -74, 16, 126, -40, 70, -96, 14, 104, -42, 48, -98, -8, 102, -64, 46, -120, -10, 80, -66, 24, -122, -32, 78, -88, 22, 112, -34, 56, -90, 0])?;

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

pub(super) fn test_mm512_mask_blend_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

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

pub(super) fn test_mm512_mask_blend_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

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

pub(super) fn test_mm512_mask_blend_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 64])?;

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

pub(super) fn test_mm512_mask_blend_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm512_mask_blend_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1])?;

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

pub(super) fn test_mm512_mask_blend_epi8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128])?;

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

pub(super) fn test_mm512_mask_blend_epi8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_blend_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127])?;

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
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 0, 0, 10, 0, 0, 0, 11, 0, 0, 0, 12, 0, 0, 0, 13, 0, 0, 0, 14, 0, 0, 0, 15, 0, 0, 0, 16, 0, 0, 0])?;

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

pub(super) fn test_mm256_mask_blend_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm256_mask_blend_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118])));
        check_array_equality(&result, &[110, -56, 54, -112, -2, 88, -58, 32, -114, -24, 86, -80, 30, 120, -26, 64, -82, 8, 118, -48, 62, -104, 6, 96, -50, 40, -106, -16, 94, -72, 38, -128])?;

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

pub(super) fn test_mm256_mask_blend_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

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

pub(super) fn test_mm256_mask_blend_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

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

pub(super) fn test_mm256_mask_blend_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

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

pub(super) fn test_mm256_mask_blend_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm256_mask_blend_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1])?;

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

pub(super) fn test_mm256_mask_blend_epi8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128])?;

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

pub(super) fn test_mm256_mask_blend_epi8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_blend_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127])?;

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
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0])?;

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

pub(super) fn test_mm_mask_blend_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 12, -3, 14, -5, 16, -7, 10, -1, 12, -3, 14, -5, 16, -7])?;

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

pub(super) fn test_mm_mask_blend_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[110, -56, 54, -112, -2, 88, -58, 32, -114, -24, 86, -80, 30, 120, -26, 64])?;

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

pub(super) fn test_mm_mask_blend_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

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

pub(super) fn test_mm_mask_blend_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

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

pub(super) fn test_mm_mask_blend_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

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

pub(super) fn test_mm_mask_blend_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

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

pub(super) fn test_mm_mask_blend_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1])?;

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

pub(super) fn test_mm_mask_blend_epi8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128])?;

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

pub(super) fn test_mm_mask_blend_epi8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_blend_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127, -128, 127])?;

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
        check_array_equality(&result, &[65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537])?;

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
        let result = unpack__m512i_to_i32_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m128i_from_i32_array([17, 18, 19, 20])));
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
        let result = unpack__m512i_to_i32_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i32_array([1, 2, 3, 4])));
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
        let result = unpack__m256i_to_i32_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([9, 10, 11, 12])));
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
