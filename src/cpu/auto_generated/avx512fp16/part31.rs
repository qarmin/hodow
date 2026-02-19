use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtph_pd(0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtph_pd(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtph_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtph_pd(create_random__m128d(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtph_pd(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtph_pd(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cvtph_pd(0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtph_pd(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_cvtph_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtph_pd(create_random__m256d(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_cvtph_pd(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtph_pd(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvtph_pd(0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtph_pd(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvtph_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtph_pd(create_random__m512d(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvtph_pd(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtph_pd(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_cvt_roundph_pd::<0>(0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundph_pd::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_cvt_roundph_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundph_pd::<0>(create_random__m512d(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_cvt_roundph_pd::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundph_pd::<0>(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsh_sd(create__m128d_from([1.0, 2.0]), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsh_sd(create_random__m128d(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsh_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtsh_sd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtsh_sd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsh_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtsh_sd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtsh_sd(create_random__mmask8(), create_random__m128d(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsh_sd::<0>(create__m128d_from([1.0, 2.0]), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsh_sd::<0>(create_random__m128d(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsh_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvt_roundsh_sd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvt_roundsh_sd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsh_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvt_roundsh_sd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), 0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvt_roundsh_sd::<0>(create_random__mmask8(), create_random__m128d(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_h() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtsh_h(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsh_h(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtsh_h() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtsh_h(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtsh_h(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtsh_h() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtsh_h(0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtsh_h(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi128_si16() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsi128_si16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi16_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi16_si128(1i16));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsi16_si128(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti64_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvti64_sh(0 /* __m128h */, 1i64);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvti64_sh(0 /* __m128h */, rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvt_roundi64_sh::<0>(0 /* __m128h */, 1i64);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundi64_sh::<0>(0 /* __m128h */, rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtu64_sh(0 /* __m128h */, 1u64);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtu64_sh(0 /* __m128h */, rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu64_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvt_roundu64_sh::<0>(0 /* __m128h */, 1u64);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundu64_sh::<0>(0 /* __m128h */, rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsh_i64(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsh_i64(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsh_i64::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsh_i64::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsh_u64(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsh_u64(0 /* __m128h */);
            }
        }
    }
    Ok(())
}
