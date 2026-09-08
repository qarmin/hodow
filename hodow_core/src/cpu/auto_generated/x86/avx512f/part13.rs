#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512f_mm512_mask_i32loscatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i32loscatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_slice = crate::cpu::common::Aligned64([1i64; 64]);
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_i32scatter_epi64::<1>(ptr_slice.0.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_mask_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i32scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm256_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i32scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm256_mask_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i64scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm256_i64scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i64scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm256_mask_i64scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i64scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_i64scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i64scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_i64scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i64scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_i64scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i64scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_mask_i64scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_i64scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_i64scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_i64scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_mask_i64scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i32gather_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m256i_to_i32_array(_mm256_mmask_i32gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm256_mmask_i32gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i32gather_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m256i_to_i32_array(_mm256_mmask_i32gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mmask_i32gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i32gather_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m256d_to_f64_array(_mm256_mmask_i32gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mmask_i32gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i32gather_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m256_to_f32_array(_mm256_mmask_i32gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0]).map_err(|e| format!("{e} | call: _mm256_mmask_i32gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i64gather_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m128i_to_i32_array(_mm256_mmask_i64gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm256_mmask_i64gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i64gather_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m256i_to_i32_array(_mm256_mmask_i64gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mmask_i64gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i64gather_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m256d_to_f64_array(_mm256_mmask_i64gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mmask_i64gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mmask_i64gather_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m128_to_f32_array(_mm256_mmask_i64gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0]).map_err(|e| format!("{e} | call: _mm256_mmask_i64gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i32scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_i32scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i32scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_i32scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i32scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_mask_i32scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i32scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i32scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_mask_i32scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i64scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_i64scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i64scatter_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_i64scatter_epi32::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i64scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_i64scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i64scatter_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_i64scatter_epi64::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i64scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_i64scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i64scatter_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_mask_i64scatter_pd::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_i64scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_i64scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_i64scatter_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_mask_i64scatter_ps::<1>(ptr_base_addr.0.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i32gather_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m128i_to_i32_array(_mm_mmask_i32gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| format!("{e} | call: _mm_mmask_i32gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i32gather_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m128i_to_i32_array(_mm_mmask_i32gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mmask_i32gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i32gather_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m128d_to_f64_array(_mm_mmask_i32gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mmask_i32gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i32gather_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m128_to_f32_array(_mm_mmask_i32gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 4.0]).map_err(|e| format!("{e} | call: _mm_mmask_i32gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i64gather_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i32; 64]);
        let result = unpack__m128i_to_i32_array(_mm_mmask_i64gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mmask_i64gather_epi32::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i64gather_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1i64; 64]);
        let result = unpack__m128i_to_i32_array(_mm_mmask_i64gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mmask_i64gather_epi64::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i64gather_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f64; 64]);
        let result = unpack__m128d_to_f64_array(_mm_mmask_i64gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_mmask_i64gather_pd::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mmask_i64gather_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_base_addr = crate::cpu::common::Aligned64([1.0f32; 64]);
        let result = unpack__m128_to_f32_array(_mm_mmask_i64gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 2.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mmask_i64gather_ps::<1>(src, k, vindex, ptr_base_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 19, 21, 23, 25, 27, 29, 31, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 12, 14, 16, 10, 12, 14, 16, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[110, 310, 510, 710, 910, 1110, 1310, 1510, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_compress_epi32_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_compress_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_compress_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}
