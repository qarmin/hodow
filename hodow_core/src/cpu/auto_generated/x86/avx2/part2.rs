#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx2_mm256_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu32_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_cvtepu8_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu8_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_cvtepu8_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu8_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_cvtepu8_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepu8_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_extracti128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_hadd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hadd_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_hadd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hadd_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[3, 7, 19, 23, 11, 15, 27, 31])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_hadds_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hadds_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_hsub_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hsub_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_hsub_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hsub_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_hsubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hsubs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_i32gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128_to_f32_array(_mm_i32gather_ps::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm_mask_i32gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i32gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256_to_f32_array(_mm256_i32gather_ps::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let result = unpack__m256_to_f32_array(_mm256_mask_i32gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_i32gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128d_to_f64_array(_mm_i32gather_pd::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128d_from([1.0, 2.0]);
        let result = unpack__m128d_to_f64_array(_mm_mask_i32gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i32gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m256d_to_f64_array(_mm256_i32gather_pd::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_i32gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i64gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i64gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm256_i64gather_epi32::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm256_mask_i64gather_epi32::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_i64gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128_to_f32_array(_mm_i64gather_ps::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 0.0, 0.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm_mask_i64gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 0.0, 0.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i64gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m128_to_f32_array(_mm256_i64gather_ps::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f32; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm256_mask_i64gather_ps::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_i64gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i64gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_i64gather_epi64::<1>(ptr_slice.0.as_ptr(), offsets));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i64gather_epi64::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_i64gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128d_to_f64_array(_mm_i64gather_pd::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128d_from([1.0, 2.0]);
        let result = unpack__m128d_to_f64_array(_mm_mask_i64gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_i64gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256d_to_f64_array(_mm256_i64gather_pd::<1>(ptr_slice.0.as_ptr(), offsets));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = crate::cpu::common::Aligned64([1.0f64; 64]);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_i64gather_pd::<1>(src, ptr_slice.0.as_ptr(), offsets, mask));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_inserti128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 20, 0, 33, 0, 48, 0, 65, 0, 84, 0, 105, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-9, -1, 3, 0, 31, 0, 75, 0, -9, -1, 3, 0, 31, 0, 75, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[-12536, 0, -5144, 3, 31176, 9, 30888, 17, -6008, 27, -13976, 40, 6984, 56, -8664, 73])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766, 2, 32766])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0, 1, 32767, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_madd_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767, 0, -32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 20, 0, 33, 0, 48, 0, 65, 0, 84, 0, 105, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2295, 24, 1771, 56, 1255, 96, 747, 0, 2295, 24, 1771, 56, 1255, 96, 747])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, -9200, 2377, -14687, -487, 8628, -10900, 1353, -15039, -3239, 6552, -12304, 625, -15095, -5695, 4772])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm256_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maddubs_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
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

pub(super) fn test_x86_avx2_mm_maskload_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm_maskload_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}
