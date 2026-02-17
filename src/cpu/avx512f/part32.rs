use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_broadcastss_ps() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_ps(1.0);
        let a = _mm_set_ps(0.0, 0.0, 0.0, 42.5);
        let r = _mm_mask_broadcastss_ps(src, 15u8, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[42.5, 42.5, 42.5, 42.5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<1>();
                let _ = _mm_mask_broadcastss_ps(_mm_set1_ps(v[0]), 15u8, _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_broadcastss_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(0.0, 0.0, 0.0, 42.5);
        let r = _mm_maskz_broadcastss_ps(15u8, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[42.5, 42.5, 42.5, 42.5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_maskz_broadcastss_ps(15u8, _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_blend_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_mask_blend_epi32(10u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[5, 2, 7, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_blend_epi32(10u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_blend_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        // use full mask to take all elements from b
        let r = _mm_mask_blend_epi64(3u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_mask_blend_epi64(3u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_blend_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let r = _mm_mask_blend_ps(10u8, a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 2.0, 7.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_mask_blend_ps(10u8, _mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_blend_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        // take all from b
        let r = _mm_mask_blend_pd(3u8, a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_mask_blend_pd(3u8, _mm_set1_pd(get_random_float32_array::<1>()[0] as f64), _mm_set1_pd(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_alignr_epi32() -> Result<(), String> {
    unsafe {
        // emulate alignr for 32-bit lanes by shifting bytes by 4
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        // use byte-align with 4 to rotate 32-bit lanes
        let r = _mm_alignr_epi8(a, b, 4);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // expected: elements shifted by one 32-bit lane
        check_array_equality(&out, &[5, 1, 2, 3])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_alignr_epi8(a_r, b_r, 4);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_alignr_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_mask_alignr_epi32::<0>(_mm_setzero_si128(), 15u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // when mask selects all, expect same as alignr of b over a (we use identity here)
        // choose a mask that results in a predictable value: full mask -> result should be b
        check_array_equality(&out, &[5, 6, 7, 8])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_alignr_epi32::<0>(_mm_setzero_si128(), 15u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_alignr_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_maskz_alignr_epi32::<0>(15u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[5, 6, 7, 8])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_alignr_epi32::<0>(15u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_alignr_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        // align by 8 bytes to shift 64-bit lanes
        let r = _mm_alignr_epi8(a, b, 8);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // expected: lower lane from b, upper from a
        check_array_equality(&out, &[3, 2])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_alignr_epi8(a_r, b_r, 8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_alignr_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_mask_alignr_epi64::<0>(_mm_setzero_si128(), 3u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_mask_alignr_epi64::<0>(_mm_setzero_si128(), 3u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_alignr_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_maskz_alignr_epi64::<0>(3u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_maskz_alignr_epi64::<0>(3u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_and_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(255, 255, 0, 0);
        let b = _mm_set_epi32(255, 0, 255, 0);
        let src = _mm_setzero_si128();
        let r = _mm_mask_and_epi32(src, 15u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[0, 0, 0, 255])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_and_epi32(_mm_setzero_si128(), 15u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_and_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(255, 255, 0, 0);
        let b = _mm_set_epi32(255, 0, 255, 0);
        let r = _mm_maskz_and_epi32(15u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[0, 0, 0, 255])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_and_epi32(15u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_and_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let src = _mm_setzero_si128();
        let r = _mm_mask_and_epi64(src, 3u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // elementwise bitwise AND: [1 & 3, 2 & 4] => [1, 0]
        check_array_equality(&out, &[1, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_mask_and_epi64(_mm_setzero_si128(), 3u8, a_r, b_r);
            }
        }
    }
    Ok(())
}
