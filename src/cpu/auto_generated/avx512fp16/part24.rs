use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_maskz_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtepu64_ph(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtepu64_ph(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvt_roundepu64_ph::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundepu64_ph::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvt_roundepu64_ph::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundepu64_ph::<0>(0 /* __m128h */, create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvt_roundepu64_ph::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundepu64_ph::<0>(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtxps_ph(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtxps_ph(create_random__m128());
            }
        }
    }
    Ok(())
}

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

pub(super) fn test_mm256_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtxps_ph(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtxps_ph(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtxps_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtxps_ph(0 /* __m128h */, create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtxps_ph(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtxps_ph(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtxps_ph(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtxps_ph(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtxps_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtxps_ph(0 /* __m256h */, create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtxps_ph(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtxps_ph(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtx_roundps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtx_roundps_ph::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtx_roundps_ph::<0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtx_roundps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtx_roundps_ph::<0>(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtx_roundps_ph::<0>(0 /* __m256h */, create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtx_roundps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtx_roundps_ph::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtx_roundps_ph::<0>(create_random__mmask16(), create_random__m512());
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
        let _result = _mm_mask_cvt_roundss_sh::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvt_roundss_sh::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundss_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvt_roundss_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvt_roundss_sh::<0>(create_random__mmask8(), 0 /* __m128h */, create_random__m128());
            }
        }
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

pub(super) fn test_mm256_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtpd_ph(create__m256d_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtpd_ph(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtpd_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtpd_ph(0 /* __m128h */, create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtpd_ph(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtpd_ph(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtpd_ph(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtpd_ph(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtpd_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtpd_ph(0 /* __m128h */, create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}
