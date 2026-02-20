use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_abs_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_abs_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
        let result = unpack__m128i_to_i32_array(_mm_abs_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
        let result = unpack__m128i_to_i32_array(_mm_maddubs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 21, 32])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
        let result = unpack__m128i_to_i32_array(_mm_mulhrs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
        let result = unpack__m128i_to_i32_array(_mm_sign_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
        let result = unpack__m128i_to_i32_array(_mm_sign_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
