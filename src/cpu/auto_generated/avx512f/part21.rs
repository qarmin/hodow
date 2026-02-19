use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_load_ps() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_maskz_load_ps(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_pd() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_maskz_load_pd(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_ss() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_ss() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_maskz_load_ss(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_sd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_sd() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_maskz_load_sd(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_storeu_epi32(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i64; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_storeu_epi64(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f32; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_mask_storeu_ps(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_mask_storeu_pd(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_store_epi32(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i64; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_store_epi64(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f32; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_mask_store_ps(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_mask_store_pd(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_ss() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_mask_store_ss(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_sd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_mask_store_sd(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_expandloadu_epi32() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_expandloadu_epi32")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_epi32() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_expandloadu_epi32(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_expandloadu_epi64() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_expandloadu_epi64")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_epi64() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_expandloadu_epi64(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_expandloadu_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_mask_expandloadu_ps(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_ps() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_maskz_expandloadu_ps(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_expandloadu_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_mask_expandloadu_pd(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_pd() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_maskz_expandloadu_pd(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_move_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_move_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_move_ss(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_move_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_move_ss(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_move_ss(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_move_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_move_sd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_move_sd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_move_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_move_sd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_move_sd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_add_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_add_ss(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}
