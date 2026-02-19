use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

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

pub(super) fn test_mm_cvt_roundsh_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsh_u64::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsh_u64::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsh_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsh_i64(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsh_i64(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsh_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsh_i64::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsh_i64::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsh_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsh_u64(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsh_u64(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsh_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsh_u64::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsh_u64::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_ph() -> Result<(), String> {
    unsafe {
        todo!("_mm_set_ph")
    }
    Ok(())
}

pub(super) fn test_mm_set_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_set_sh(0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set_sh(0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set1_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_set1_ph(0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set1_ph(0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_setr_ph() -> Result<(), String> {
    unsafe {
        todo!("_mm_setr_ph")
    }
    Ok(())
}

pub(super) fn test_mm_setzero_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_setzero_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_setzero_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_undefined_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_undefined_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_undefined_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_castpd_ph(create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castpd_ph(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castph_pd(0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castph_pd(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_castps_ph(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castps_ph(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castph_ps(0 /* __m128h */));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castph_ps(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castsi128_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_castsi128_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castsi128_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castph_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castph_si128(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castph_si128(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_cmp_ph_mask::<0>(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmp_ph_mask::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_cmp_ph_mask::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cmp_ph_mask::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_round_sh_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_cmp_round_sh_mask::<0, 0>(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmp_round_sh_mask::<0, 0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_round_sh_mask() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cmp_round_sh_mask")
    }
    Ok(())
}

pub(super) fn test_mm_cmp_sh_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_cmp_sh_mask::<0>(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmp_sh_mask::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_sh_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_cmp_sh_mask::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cmp_sh_mask::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}
