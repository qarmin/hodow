use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm512_mask_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepi32_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi32_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepi32_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepi32_epi64(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepi32_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 0, 3, 4, 11, 0, 7, 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi32_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepi32_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepi32_epi64(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepi32_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi32_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepi32_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepi32_epi64(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu32_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepu32_epi64(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu32_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu32_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu32_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepu32_epi64(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu32_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 0, 3, 4, 11, 0, 7, 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu32_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu32_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepu32_epi64(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu32_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu32_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu32_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepu32_epi64(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_cvtepi32_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi32_ps(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtepi32_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[17.0, 2.0, 19.0, 4.0, 21.0, 6.0, 23.0, 8.0, 25.0, 10.0, 27.0, 12.0, 29.0, 14.0, 31.0, 16.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi32_ps(create_random__m512(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_cvtepi32_ps(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepi32_ps(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtepi32_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi32_ps(create_random__m256(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_cvtepi32_ps(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepi32_ps(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtepi32_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi32_ps(create_random__m128(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtepi32_ps(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepi32_ps(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtepi32_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi32_pd(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi32_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi32_pd(create_random__m512d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvtepi32_pd(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepi32_pd(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepi32_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi32_pd(create_random__m256d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_cvtepi32_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepi32_pd(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepi32_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([3, 4, 5, 6])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepi32_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtepi32_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepi32_pd(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepu32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_cvtepu32_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepu32_ps(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepu32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtepu32_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[17.0, 2.0, 19.0, 4.0, 21.0, 6.0, 23.0, 8.0, 25.0, 10.0, 27.0, 12.0, 29.0, 14.0, 31.0, 16.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu32_ps(create_random__m512(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepu32_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_cvtepu32_ps(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepu32_ps(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtepu32_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepu32_pd(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu32_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu32_pd(create_random__m512d(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvtepu32_pd(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepu32_pd(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cvtepu32_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepu32_pd(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtepu32_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepu32_pd(create_random__m256d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_cvtepu32_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepu32_pd(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtepu32_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu32_pd(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtepu32_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([3, 4, 5, 6])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtepu32_pd(create_random__m128d(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtepu32_pd(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtepu32_pd(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi32lo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtepi32lo_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi32lo_pd(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi32lo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepi32lo_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi32lo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepu32lo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtepu32lo_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepu32lo_pd(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepu32lo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtepu32lo_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepu32lo_pd(create_random__m512d(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtepi32_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295, 655369, 786443, 917517, 1048591])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi32_epi16(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtepi32_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 11, 13, 15, 17, 19, 21, 23])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi32_epi16(create_random__m256i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtepi32_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 3, 5, 7, 9, 11, 13, 15])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepi32_epi16(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtepi32_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepi32_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtepi32_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 7, 9, 11])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi32_epi16(create_random__m128i(), create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvtepi32_epi16(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 3, 5, 7])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtepi32_epi16(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi32_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_cvtepi32_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[67305985, 134678021, 202050057, 269422093])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi32_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}
