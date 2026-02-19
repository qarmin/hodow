use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm256_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm256_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm256_mask_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm256_maskz_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm512_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm512_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm512_mask_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm512_maskz_cvtph_pd")
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm512_cvt_roundph_pd")
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm512_mask_cvt_roundph_pd")
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundph_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm512_maskz_cvt_roundph_pd")
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvtsh_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsh_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cvtsh_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsh_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_cvtsh_sd")
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvt_roundsh_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsh_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cvt_roundsh_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsh_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_cvt_roundsh_sd")
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_h() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvtsh_h")
    }
    Ok(())
}

pub(super) fn test_mm256_cvtsh_h() -> Result<(), String> {
    unsafe {
        todo!("_mm256_cvtsh_h")
    }
    Ok(())
}

pub(super) fn test_mm512_cvtsh_h() -> Result<(), String> {
    unsafe {
        todo!("_mm512_cvtsh_h")
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
        todo!("_mm_cvti64_sh")
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvt_roundi64_sh")
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvtu64_sh")
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu64_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvt_roundu64_sh")
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_i64() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvtsh_i64")
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_i64() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvt_roundsh_i64")
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_u64() -> Result<(), String> {
    unsafe {
        todo!("_mm_cvtsh_u64")
    }
    Ok(())
}
