#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_abs_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6, 7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[100, 56, 44, 112, 12, 88, 68, 32, 124, 24, 76, 80, 20, 120, 36, 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_abs_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, 1, -128, 127, 0, 1, -128, 127, 0, 1, -128, 127, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_abs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, 1, -32768, 32767, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 1, 2, 3])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 200, 300, 400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_abs_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_shuffle_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_shuffle_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[16843008, 16843008, 16843008, 16843011])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_shuffle_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_alignr_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_alignr_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_hadd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_hadd_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_hadd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_hadds_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_hadds_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_hadds_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_hadd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_hadd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[3, 7, 11, 15])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_hadd_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_hsub_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_hsub_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_hsub_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_hsubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_hsubs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_hsubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_hsub_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_hsub_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_hsub_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 12, 0, 21, 0, 32, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2295, 24, 1771, 56, 1255, 96, 747])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, -9200, 2377, -14687, -487, 8628, -10900, 1353])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, -510, -510, -510, -510, -510, -510, -510])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 15874, 0, -510, -16384, 15874, 0, -510])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maddubs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maddubs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0, 1, 3, 5, 8, 11, 15, 20])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32766, 32766, 32766, 32766, 32766, 32766, 32766, 32766])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32766, 0, 0, -32768, 32766, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-32767, -32767, -32767, -32767, -32767, -32767, -32767, -32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mulhrs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mulhrs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32767, -32767, -32767, -32767, -32767, -32767, -32767, -32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mulhrs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[100, 56, 44, 112, 12, 88, 68, 32, 124, 24, 76, 80, 20, -120, 36, 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, 1, -128, 127, 0, 1, -128, 127, 0, 1, -128, 127, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_sign_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-127, -127, -127, -127, -127, -127, -127, -127, -127, -127, -127, -127, -127, -127, -127, -127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, 1, -32768, 32767, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sign_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32767, -32767, -32767, -32767, -32767, -32767, -32767, -32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 2, -3])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 200, 300, 400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sign_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sign_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483647, -2147483647, -2147483647, -2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sign_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
