use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_castsi512_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_castsi512_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_ph(create_random__m512i());
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

pub(super) fn test_mm256_castph_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castph_si256(0 /* __m256h */));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castph_si256(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castph_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castph_si512(0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castph_si512(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castph256_ph128() -> Result<(), String> {
    unsafe {
        let _result = _mm256_castph256_ph128(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castph256_ph128(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castph512_ph128() -> Result<(), String> {
    unsafe {
        let _result = _mm512_castph512_ph128(0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castph512_ph128(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castph512_ph256() -> Result<(), String> {
    unsafe {
        let _result = _mm512_castph512_ph256(0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castph512_ph256(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castph128_ph256() -> Result<(), String> {
    unsafe {
        let _result = _mm256_castph128_ph256(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castph128_ph256(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castph128_ph512() -> Result<(), String> {
    unsafe {
        let _result = _mm512_castph128_ph512(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castph128_ph512(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castph256_ph512() -> Result<(), String> {
    unsafe {
        let _result = _mm512_castph256_ph512(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castph256_ph512(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_zextph128_ph256() -> Result<(), String> {
    unsafe {
        let _result = _mm256_zextph128_ph256(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_zextph128_ph256(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextph256_ph512() -> Result<(), String> {
    unsafe {
        let _result = _mm512_zextph256_ph512(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextph256_ph512(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextph128_ph512() -> Result<(), String> {
    unsafe {
        let _result = _mm512_zextph128_ph512(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextph128_ph512(0 /* __m128h */);
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

pub(super) fn test_mm256_cmp_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_cmp_ph_mask::<0>(0 /* __m256h */, 0 /* __m256h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cmp_ph_mask::<0>(0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cmp_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_cmp_ph_mask::<0>(create__mmask16_from(0b0101010101010101), 0 /* __m256h */, 0 /* __m256h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cmp_ph_mask::<0>(create_random__mmask16(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cmp_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_cmp_ph_mask::<0>(0 /* __m512h */, 0 /* __m512h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cmp_ph_mask::<0>(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cmp_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_mask_cmp_ph_mask::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cmp_ph_mask::<0>(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cmp_round_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_cmp_round_ph_mask::<0, 0>(0 /* __m512h */, 0 /* __m512h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cmp_round_ph_mask::<0, 0>(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cmp_round_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_mask_cmp_round_ph_mask::<0, 0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cmp_round_ph_mask::<0, 0>(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
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
        let result = _mm_mask_cmp_round_sh_mask::<0, 0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cmp_round_sh_mask::<0, 0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
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

pub(super) fn test_mm_comi_round_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comi_round_sh::<0, 0>(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comi_round_sh::<0, 0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comi_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comi_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comi_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comieq_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comieq_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comige_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comige_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comigt_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comigt_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}
