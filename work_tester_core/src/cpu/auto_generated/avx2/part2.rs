use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm256_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu32_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepu32_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepu8_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu8_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepu8_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepu8_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu8_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepu8_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepu8_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu8_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepu8_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_extracti128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_hadd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hadd_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_hadd_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_hadd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hadd_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[3, 7, 19, 23, 11, 15, 27, 31])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_hadd_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_hadds_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hadds_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_hadds_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_hsub_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hsub_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_hsub_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_hsub_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hsub_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_hsub_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_hsubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hsubs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_hsubs_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128_to_f32_array(_mm_i32gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm_mask_i32gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256_to_f32_array(_mm256_i32gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let result = unpack__m256_to_f32_array(_mm256_mask_i32gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128d_to_f64_array(_mm_i32gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128d_from([1.0, 2.0]);
        let result = unpack__m128d_to_f64_array(_mm_mask_i32gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m256d_to_f64_array(_mm256_i32gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_i32gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i64gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i64gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm256_i64gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm256_mask_i64gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128_to_f32_array(_mm_i64gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 0.0, 0.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm_mask_i64gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 0.0, 0.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m128_to_f32_array(_mm256_i64gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f32; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm256_mask_i64gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i64gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i64gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i64gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i64gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128d_to_f64_array(_mm_i64gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128d_from([1.0, 2.0]);
        let result = unpack__m128d_to_f64_array(_mm_mask_i64gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256d_to_f64_array(_mm256_i64gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_i64gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_inserti128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_inserti128_si256::<0>(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_madd_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 20, 33, 48, 65, 84, 105, 128])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_madd_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maddubs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 20, 33, 48, 65, 84, 105, 128])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maddubs_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskload_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i32; 1];
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskload_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i32; 1];
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskload_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i64; 1];
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi64(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskload_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i64; 1];
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi64(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}
