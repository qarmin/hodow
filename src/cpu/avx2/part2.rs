use std::arch::x86_64::{
    __m128, __m128d, __m128i, __m256i, _mm256_broadcastd_epi32, _mm256_hsub_epi32, _mm256_permutevar8x32_epi32, _mm256_set_epi32, _mm_blend_epi32, _mm_broadcastb_epi8,
    _mm_broadcastq_epi64, _mm_broadcastsd_pd, _mm_broadcastsi128_si256, _mm_broadcastss_ps, _mm_broadcastw_epi16, _mm_i32gather_epi32, _mm_i32gather_epi64, _mm_i32gather_pd,
    _mm_i32gather_ps, _mm_i64gather_epi32, _mm_i64gather_epi64, _mm_i64gather_pd, _mm_i64gather_ps, _mm_mask_i32gather_epi32, _mm_mask_i32gather_epi64, _mm_mask_i32gather_pd,
    _mm_mask_i32gather_ps, _mm_mask_i64gather_epi32, _mm_mask_i64gather_epi64, _mm_mask_i64gather_pd, _mm_mask_i64gather_ps, _mm_maskload_epi32, _mm_maskload_epi64,
    _mm_maskstore_epi32, _mm_maskstore_epi64, _mm_set1_epi32, _mm_set1_epi64x, _mm_set1_pd, _mm_set1_ps, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x, _mm_set_epi8, _mm_set_pd,
    _mm_set_ps, _mm_sllv_epi32, _mm_sllv_epi64, _mm_srav_epi32, _mm_srlv_epi32, _mm_srlv_epi64,
};

use log::info;
use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm256_hsub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm256_hsub_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm256_set_epi32(rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random());
                let b = _mm256_set_epi32(rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm256_hsub_epi32(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_broadcastd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 0, 42);
        let result = _mm256_broadcastd_epi32(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[42, 42, 42, 42, 42, 42, 42, 42])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm256_broadcastd_epi32(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_permutevar8x32_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm256_set_epi32(0, 1, 2, 3, 4, 5, 6, 7);
        let result = _mm256_permutevar8x32_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[7, 6, 5, 4, 3, 2, 1, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm256_set_epi32(rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random());
                let b = _mm256_set_epi32(rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm256_permutevar8x32_epi32(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_blend_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_blend_epi32::<0b1010>(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[4, 7, 2, 5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let b = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_blend_epi32::<0b1010>(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_broadcastb_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42);
        let result = _mm_broadcastb_epi8(a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[42; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi8(rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_broadcastb_epi8(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_broadcastq_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0, 42);
        let result = _mm_broadcastq_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[42, 42])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_broadcastq_epi64(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_broadcastsd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 42.5);
        let result = _mm_broadcastsd_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[42.5, 42.5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_pd(rand::random());
                let _ = _mm_broadcastsd_pd(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_broadcastsi128_si256() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_broadcastsi128_si256(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[1, 2, 3, 4, 1, 2, 3, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_broadcastsi128_si256(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_broadcastss_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(0.0, 0.0, 0.0, 42.5);
        let result = _mm_broadcastss_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[42.5, 42.5, 42.5, 42.5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_ps(rand::random());
                let _ = _mm_broadcastss_ps(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 0, 0, 0, 42);
        let result = _mm_broadcastw_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[42; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi16(rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_broadcastw_epi16(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let result = _mm_i32gather_epi32::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[70, 50, 30, 10])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let _ = _mm_i32gather_epi32::<4>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi32(99);
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let result = _mm_mask_i32gather_epi32::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[99, 50, 99, 10])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_epi32(rand::random());
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let mask = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_mask_i32gather_epi32::<4>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i32gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let result = _mm_i32gather_ps::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[7.0, 5.0, 3.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let _ = _mm_i32gather_ps::<4>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_ps(99.0);
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let mask = _mm_set_ps(-1.0, 0.0, -1.0, 0.0);
        let result = _mm_mask_i32gather_ps::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality_with_error(&result, &[99.0, 5.0, 99.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_ps(rand::random());
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let mask = _mm_set_ps(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_mask_i32gather_ps::<4>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let result = _mm_i32gather_epi64::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[40, 20])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let _ = _mm_i32gather_epi64::<8>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi64x(99);
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let mask = _mm_set_epi64x(-1, 0);
        let result = _mm_mask_i32gather_epi64::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[99, 20])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_epi64x(rand::random());
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let mask = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_mask_i32gather_epi64::<8>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i32gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let result = _mm_i32gather_pd::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[4.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let _ = _mm_i32gather_pd::<8>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_pd(99.0);
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let mask = _mm_set_pd(-1.0, 0.0);
        let result = _mm_mask_i32gather_pd::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[99.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_pd(rand::random());
                let idx = _mm_set_epi32((rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32, (rand::random::<u32>() % 8) as i32);
                let mask = _mm_set_pd(rand::random(), rand::random());
                let _ = _mm_mask_i32gather_pd::<8>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi64x(0, 2);
        let result = _mm_i64gather_epi32::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[30, 10, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let _ = _mm_i64gather_epi32::<4>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi32(99);
        let indices = _mm_set_epi64x(0, 2);
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let result = _mm_mask_i64gather_epi32::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[99, 10, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_epi32(rand::random());
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let mask = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_mask_i64gather_epi32::<4>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i64gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi64x(0, 2);
        let result = _mm_i64gather_ps::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[3.0, 1.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let _ = _mm_i64gather_ps::<4>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_ps(99.0);
        let indices = _mm_set_epi64x(0, 2);
        let mask = _mm_set_ps(-1.0, 0.0, -1.0, 0.0);
        let result = _mm_mask_i64gather_ps::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[99.0, 1.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f32; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_ps(rand::random());
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let mask = _mm_set_ps(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_mask_i64gather_ps::<4>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi64x(0, 3);
        let result = _mm_i64gather_epi64::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[40, 10])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let _ = _mm_i64gather_epi64::<8>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi64x(99);
        let indices = _mm_set_epi64x(0, 3);
        let mask = _mm_set_epi64x(-1, 0);
        let result = _mm_mask_i64gather_epi64::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[99, 10])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_epi64x(rand::random());
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let mask = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_mask_i64gather_epi64::<8>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_i64gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi64x(0, 3);
        let result = _mm_i64gather_pd::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[4.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let _ = _mm_i64gather_pd::<8>(base.as_ptr(), idx);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_pd(99.0);
        let indices = _mm_set_epi64x(0, 3);
        let mask = _mm_set_pd(-1.0, 0.0);
        let result = _mm_mask_i64gather_pd::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[99.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [f64; 8] = [rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random(), rand::random()];
                let src = _mm_set1_pd(rand::random());
                let idx = _mm_set_epi64x((rand::random::<u32>() % 8) as i64, (rand::random::<u32>() % 8) as i64);
                let mask = _mm_set_pd(rand::random(), rand::random());
                let _ = _mm_mask_i64gather_pd::<8>(src, base.as_ptr(), idx, mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskload_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 4] = [10, 20, 30, 40];
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let result = _mm_maskload_epi32(arr.as_ptr(), mask);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0, 20, 0, 40])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i32; 4] = [rand::random(), rand::random(), rand::random(), rand::random()];
                let mask = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_maskload_epi32(base.as_ptr(), mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskload_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 2] = [10, 20];
        let mask = _mm_set_epi64x(-1, 0);
        let result = _mm_maskload_epi64(arr.as_ptr(), mask);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[0, 20])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let base: [i64; 2] = [rand::random(), rand::random()];
                let mask = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_maskload_epi64(base.as_ptr(), mask);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskstore_epi32() -> Result<(), String> {
    unsafe {
        let mut arr: [i32; 4] = [0; 4];
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let a = _mm_set_epi32(40, 30, 20, 10);
        _mm_maskstore_epi32(arr.as_mut_ptr(), mask, a);
        check_array_equality(&arr, &[0, 20, 0, 40])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut arr: [i32; 4] = [0; 4];
                let mask = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                _mm_maskstore_epi32(arr.as_mut_ptr(), mask, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskstore_epi64() -> Result<(), String> {
    unsafe {
        let mut arr: [i64; 2] = [0; 2];
        let mask = _mm_set_epi64x(-1, 0);
        let a = _mm_set_epi64x(20, 10);
        _mm_maskstore_epi64(arr.as_mut_ptr(), mask, a);
        check_array_equality(&arr, &[0, 20])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut arr: [i64; 2] = [0; 2];
                let mask = _mm_set_epi64x(rand::random(), rand::random());
                let a = _mm_set_epi64x(rand::random(), rand::random());
                _mm_maskstore_epi64(arr.as_mut_ptr(), mask, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sllv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let count = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_sllv_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 4, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi32(rand::random());
                let count = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_sllv_epi32(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sllv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let count = _mm_set_epi64x(2, 0);
        let result = _mm_sllv_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[1, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let count = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_sllv_epi64(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srav_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-8, -4, -2, -1);
        let count = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_srav_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[-1, -1, -1, -1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let count = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_srav_epi32(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srlv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(8);
        let count = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_srlv_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[8, 4, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi32(rand::random());
                let count = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_srlv_epi32(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srlv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(8);
        let count = _mm_set_epi64x(2, 0);
        let result = _mm_srlv_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[8, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let count = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_srlv_epi64(a, count);
            }
        }
    }

    Ok(())
}
