use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_mask_cvt_roundps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvt_roundps_epu64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundps_epu64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvt_roundps_epu64::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundps_epu64::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtps_epu64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtps_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtps_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtps_epu64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtps_epu64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtps_epu64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtps_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtps_epu64(create_random__m256i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtps_epu64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtps_epu64(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtps_epu64(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtps_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtps_epu64(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtps_epu64(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtps_epu64(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundpd_epi64::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtt_roundpd_epi64::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundpd_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtt_roundpd_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundpd_epi64::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtt_roundpd_epi64::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttpd_epi64(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttpd_epi64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttpd_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttpd_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttpd_epi64(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttpd_epi64(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttpd_epi64(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvttpd_epi64(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttpd_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvttpd_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttpd_epi64(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvttpd_epi64(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvttpd_epi64(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvttpd_epi64(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvttpd_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvttpd_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttpd_epi64(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvttpd_epi64(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundps_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundps_epi64::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtt_roundps_epi64::<0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundps_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundps_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtt_roundps_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundps_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundps_epi64::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtt_roundps_epi64::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttps_epi64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttps_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttps_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttps_epi64(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttps_epi64(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttps_epi64(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvttps_epi64(create_random__m128());
            }
        }
    }
    Ok(())
}
