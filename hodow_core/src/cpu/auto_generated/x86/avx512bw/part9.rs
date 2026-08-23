#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 24)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result as i32, 18688)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_or_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 15)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_or_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_or_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 15)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_or_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_or_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 7)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_or_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_or_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 7)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_or_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_or_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 15)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_or_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_or_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 15)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_or_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_or_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 7)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_or_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_or_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 7)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_or_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i32_array(_mm512_loadu_epi16(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i32_array(_mm256_loadu_epi16(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i32_array(_mm_loadu_epi16(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[65537, 65537, 65537, 65537])?;
    }
    Ok(())
}

pub(super) fn test_mm512_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_loadu_epi8(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i32_array(_mm256_loadu_epi8(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i32_array(_mm_loadu_epi8(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[16843009, 16843009, 16843009, 16843009])?;
    }
    Ok(())
}

pub(super) fn test_mm512_storeu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([17i16; 32]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i32_array(_mm512_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([17i8; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129, 1114129])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i32_array(_mm512_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9i16; 32]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[9, 9, 9, 9, 9, 9, 9, 9])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i32_array(_mm256_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9i8; 64]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[589833, 589833, 589833, 589833, 589833, 589833, 589833, 589833])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i32_array(_mm256_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5i16; 32]);
        let result = unpack__m128i_to_i32_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[5, 5, 5, 5])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i32_array(_mm_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5i8; 64]);
        let result = unpack__m128i_to_i32_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[327685, 327685, 327685, 327685])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i32_array(_mm_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[65537, 65537, 65537, 65537])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_storeu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let mask = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let mask = create__mmask64_from(0x5555555555555555u64);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_storeu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let mask = create__mmask32_from(0x55555555u32);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_storeu_epi16(ptr_mem_addr.0.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 36, 0, 57, 0, 80, 0, 105, 0, 132, 0, 161, 0, 192, 0, 225, 0, 260, 0, 297, 0, 336, 0, 377, 0, 420, 0, 465, 0, 512, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-9, -1, 3, 0, 31, 0, 75, 0, -9, -1, 3, 0, 31, 0, 75, 0, -9, -1, 3, 0, 31, 0, 75, 0, -9, -1, 3, 0, 31, 0, 75, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[-12536, 0, -5144, 3, 31176, 9, 30888, 17, -6008, 27, -13976, 40, 6984, 56, -8664, 73, 4616, 94, -18712, 116, -13112, 141, 21416, 169, 19336, 199, -19352, 231, -29112, 266, -9944, 303])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_madd_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[561, 0, 2, 0, 665, 0, 4, 0, 777, 0, 6, 0, 897, 0, 8, 0, 1025, 0, 10, 0, 1161, 0, 12, 0, 1305, 0, 14, 0, 1457, 0, 16, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[371, 0, 2, -3, 411, 0, 6, -7, 371, 0, 2, -3, 411, 0, 6, -7, 371, 0, 2, -3, 411, 0, 6, -7, 371, 0, 2, -3, 411, 0, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]), create__m512i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420, 2520, 2620, 2720, 2820, 2920, 3020, 3120, 3220])));
        check_array_equality(&result, &[-6136, 0, 300, 400, -11960, 9, 700, 800, 32392, 28, 1100, 1200, -4152, 56, 1500, 1600, 9480, 95, 1900, 2000, 7752, 143, 2300, 2400, -9336, 200, 2700, 2800, 23752, 268, 3100, 3200])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32767, 0, -32768, -32768, 32765, 1, -32768, -32768, 32763, 2, -32768, -32768, 32761, 3, -32768, -32768, 32759, 4, -32768, -32768, 32757, 5, -32768, -32768, 32755, 6, -32768, -32768, 32753, 7, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_madd_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32768, -1, 32767, 32767, -32768, -2, 32767, 32767, -32768, -3, 32767, 32767, -32768, -4, 32767, 32767, -32768, -5, 32767, 32767, -32768, -6, 32767, 32767, -32768, -7, 32767, 32767, -32768, -8, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 0, 0, 57, 0, 0, 0, 105, 0, 0, 0, 161, 0, 0, 0, 225, 0, 0, 0, 297, 0, 0, 0, 377, 0, 0, 0, 465, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-9, -1, 0, 0, 31, 0, 0, 0, -9, -1, 0, 0, 31, 0, 0, 0, -9, -1, 0, 0, 31, 0, 0, 0, -9, -1, 0, 0, 31, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[-12536, 0, 0, 0, 31176, 9, 0, 0, -6008, 27, 0, 0, 6984, 56, 0, 0, 4616, 94, 0, 0, -13112, 141, 0, 0, 19336, 199, 0, 0, -29112, 266, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[153, 0, 2, 0, 209, 0, 4, 0, 273, 0, 6, 0, 345, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[371, 0, 2, -3, 411, 0, 6, -7, 371, 0, 2, -3, 411, 0, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m256i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[-6136, 0, 300, 400, -11960, 9, 700, 800, 32392, 28, 1100, 1200, -4152, 56, 1500, 1600])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768, 0, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767, 2, 32766, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1, 2, 0, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[32767, 0, -32768, -32768, 32765, 1, -32768, -32768, 32763, 2, -32768, -32768, 32761, 3, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_madd_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32768, -1, 32767, 32767, -32768, -2, 32767, 32767, -32768, -3, 32767, 32767, -32768, -4, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 0, 0, 33, 0, 0, 0, 65, 0, 0, 0, 105, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-9, -1, 0, 0, 31, 0, 0, 0, -9, -1, 0, 0, 31, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[-12536, 0, 0, 0, 31176, 9, 0, 0, -6008, 27, 0, 0, 6984, 56, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0, 0, -32768, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0, 2, 32766, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0, 1, 32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0, 0, -32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 0, 2, 0, 77, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[371, 0, 2, -3, 411, 0, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[-6136, 0, 300, 400, -11960, 9, 700, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, -32768, -32768, 0, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 32767, 32767, 2, 32766, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, -1, -1, 2, 0, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, -1, 1, 32767, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[32767, 0, -32768, -32768, 32765, 1, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_madd_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-32768, -1, 32767, 32767, -32768, -2, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
