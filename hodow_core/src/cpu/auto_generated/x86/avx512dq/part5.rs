#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512dq_mm_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtpd_epu64(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpd_epu64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtpd_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 0, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtpd_epu64(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtpd_epu64(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpd_epu64(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtpd_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 0, 3, 4, 11, 0, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtpd_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtpd_epu64(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtpd_epu64(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtpd_epu64(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtpd_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtpd_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtpd_epu64(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtpd_epu64(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvt_roundps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvt_roundps_epu64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvt_roundps_epu64::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvt_roundps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvt_roundps_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvt_roundps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvt_roundps_epu64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvt_roundps_epu64::<8>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtps_epu64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 0, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtps_epu64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_epu64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 0, 3, 4, 11, 0, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvtps_epu64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtps_epu64(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtps_epu64(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtps_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtps_epu64(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundpd_epi64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundpd_epi64::<8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundpd_epi64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundpd_epi64::<8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttpd_epi64(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttpd_epi64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 0, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttpd_epi64(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvttpd_epi64(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttpd_epi64(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttpd_epi64(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttpd_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 0, 3, 4, 11, 0, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttpd_epi64(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvttpd_epi64(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvttpd_epi64(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvttpd_epi64(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvttpd_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvttpd_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttpd_epi64(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvttpd_epi64(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundps_epi64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundps_epi64::<8>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundps_epi64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundps_epi64::<8>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttps_epi64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttps_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[5, 0, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_maskz_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttps_epi64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvttps_epi64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttps_epi64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_mask_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttps_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[9, 0, 3, 4, 11, 0, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvttps_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm256_maskz_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttps_epi64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_cvttps_epi64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvttps_epi64(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvttps_epi64(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvttps_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvttps_epi64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvttps_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttps_epi64(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvttps_epi64(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundpd_epu64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtt_roundpd_epu64::<8>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 0, 3, 4, 19, 0, 7, 8, 21, 0, 11, 12, 23, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundpd_epu64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtt_roundpd_epu64::<8>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_cvttpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttpd_epu64(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttpd_epu64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512dq_mm_mask_cvttpd_epu64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[5, 0, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvttpd_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}
