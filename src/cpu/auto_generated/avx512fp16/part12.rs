use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtxps_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtxps_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtxps_ph(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtxps_ph(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtss_sh(0 /* __m128h */, create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_sh(0 /* __m128h */, create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtss_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtss_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtss_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtss_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtss_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtss_sh(create_random__mmask8(), 0 /* __m128h */, create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvt_roundss_sh::<0>(0 /* __m128h */, create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_sh::<0>(0 /* __m128h */, create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundss_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cvt_roundss_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundss_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_cvt_roundss_sh")
    }
    Ok(())
}

pub(super) fn test_mm_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtpd_ph(create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtpd_ph(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtpd_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtpd_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtpd_ph(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtpd_ph(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtsd_sh(0 /* __m128h */, create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsd_sh(0 /* __m128h */, create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsd_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtsd_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtsd_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsd_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtsd_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtsd_sh(create_random__mmask8(), 0 /* __m128h */, create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvt_roundsd_sh::<0>(0 /* __m128h */, create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_sh::<0>(0 /* __m128h */, create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsd_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cvt_roundsd_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsd_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_cvt_roundsd_sh")
    }
    Ok(())
}

pub(super) fn test_mm_cvtph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtph_epi16(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtph_epi16(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtph_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtph_epi16(create_random__m128i(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtph_epi16(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtph_epi16(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtph_epu16(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtph_epu16(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtph_epu16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtph_epu16(create_random__m128i(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtph_epu16(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtph_epu16(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttph_epi16(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttph_epi16(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttph_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttph_epi16(create_random__m128i(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttph_epi16(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttph_epi16(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttph_epu16(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttph_epu16(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttph_epu16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttph_epu16(create_random__m128i(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttph_epu16(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttph_epu16(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtph_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtph_epi32(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtph_epi32(0 /* __m128h */);
            }
        }
    }
    Ok(())
}
