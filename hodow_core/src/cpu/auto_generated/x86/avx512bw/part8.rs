#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm256_reduce_add_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_add_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_add_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_add_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_add_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_add_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_add_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_add_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 10)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_add_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_add_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_add_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 10)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_add_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_add_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_add_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_add_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_add_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_add_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 36)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_add_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_add_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_add_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 10)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_add_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_add_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_add_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 10)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_add_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_and_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_and_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_and_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_and_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_and_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_and_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_and_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_and_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_and_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_and_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_and_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_and_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_and_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_and_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_and_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_and_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_and_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_and_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_and_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_and_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_and_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_and_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_and_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_and_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_max_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_max_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_max_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_max_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_max_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_max_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_max_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_max_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_max_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_max_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_max_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_max_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_max_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_max_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_max_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_max_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_max_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_max_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_max_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_max_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_max_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_max_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_max_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_max_epu16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_max_epu16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_max_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_max_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_max_epu16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_max_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_max_epu16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_max_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_max_epu16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_max_epu16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_max_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_max_epu8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_max_epu8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_max_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_max_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 8)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_max_epu8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_max_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_max_epu8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_max_epu8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_max_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 4)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_max_epu8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_min_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_min_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_min_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_min_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_min_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_min_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_min_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_min_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_min_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_min_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_min_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_min_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_min_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_min_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_min_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_min_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_min_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_min_epu16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_min_epu16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_min_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_min_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_min_epu16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epu16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_min_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epu16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_min_epu16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_min_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_min_epu8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_min_epu8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_min_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_min_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_min_epu8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epu8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_reduce_min_epu8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_min_epu8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, -25216)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}
