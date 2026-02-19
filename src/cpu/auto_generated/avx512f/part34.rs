use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_maskz_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttps_epu32(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvttps_epu32(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttps_epu32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvttps_epu32(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttps_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvttps_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttps_epu32(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvttps_epu32(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttps_epu32(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttps_epu32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttps_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttps_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttps_epu32(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttps_epu32(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtt_roundpd_epu32::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtt_roundpd_epu32::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvttpd_epi32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvttpd_epi32(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvttpd_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvttpd_epi32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvttpd_epi32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvttpd_epi32(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvttpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvttpd_epi32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvttpd_epi32(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttpd_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttpd_epi32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttpd_epi32(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvttpd_epu32(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvttpd_epu32(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvttpd_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvttpd_epu32(create_random__m256i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvttpd_epu32(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvttpd_epu32(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvttpd_epu32(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvttpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvttpd_epu32(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttpd_epu32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttpd_epu32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttpd_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttpd_epu32(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttpd_epu32(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setzero_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_setzero_pd());
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setzero_pd();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_setzero_ps());
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setzero_ps();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setzero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_setzero());
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setzero();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setzero_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_setzero_si512());
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setzero_si512();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setzero_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_setzero_epi32());
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setzero_epi32();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setr_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_setr_epi32(1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32, 1i32));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setr_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}
