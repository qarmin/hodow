use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_blend_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_blend_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_blend_epi32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcastb_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_broadcastb_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcastb_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcastd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_broadcastd_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcastd_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcastq_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_broadcastq_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcastq_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcastsd_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_broadcastsd_pd(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcastsd_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcastsi128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm_broadcastsi128_si256(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcastsi128_si256(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcastss_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_broadcastss_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcastss_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_broadcastw_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcastw_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_epi32() -> Result<(), String> {
    unsafe {
        todo!("_mm_i32gather_epi32")
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i32gather_epi32")
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128_to_f32_array(_mm_i32gather_ps::<0>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i32gather_ps")
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_epi64() -> Result<(), String> {
    unsafe {
        todo!("_mm_i32gather_epi64")
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i32gather_epi64")
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128d_to_f64_array(_mm_i32gather_pd::<0>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i32gather_pd")
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_epi32() -> Result<(), String> {
    unsafe {
        todo!("_mm_i64gather_epi32")
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i64gather_epi32")
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128_to_f32_array(_mm_i64gather_ps::<0>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i64gather_ps")
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_epi64() -> Result<(), String> {
    unsafe {
        todo!("_mm_i64gather_epi64")
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i64gather_epi64")
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128d_to_f64_array(_mm_i64gather_pd::<0>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_i64gather_pd")
    }
    Ok(())
}

pub(super) fn test_mm_maskload_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i32; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskload_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i64; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi64(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskstore_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_maskstore_epi32(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_maskstore_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i64; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_maskstore_epi64(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_sllv_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sllv_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sllv_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sllv_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sllv_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sllv_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
