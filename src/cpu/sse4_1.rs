#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use log::info;

use crate::cpu::{check_f32_array_equality, check_float_equality, check_int_array_equality, check_int_equality, ExtensionTest, get_iterations, DEFAULT_FLOAT_DIFF};
use crate::{get_four_random_floats, get_fuzzing};

pub struct SSE41;

impl ExtensionTest for SSE41 {
    fn get_name() -> &'static str {
        "SSE4.1"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_blend_ps, "test_mm_blend_ps"),
            (&test_mm_blendv_ps, "test_mm_blendv_ps"),
            (&test_mm_dp_ps, "test_mm_dp_ps"),
            (&test_mm_max_epi32, "test_mm_max_epi32"),
            (&test_mm_min_epi32, "test_mm_min_epi32"),
            (&test_mm_max_epi8, "test_mm_max_epi8"),
            (&test_mm_min_epi8, "test_mm_min_epi8"),
            (&test_mm_mullo_epi32, "test_mm_mullo_epi32"),
            (&test_mm_mul_epi32, "test_mm_mul_epi32"),
            (&test_mm_round_ps, "test_mm_round_ps"),
            (&test_mm_ceil_ps, "test_mm_ceil_ps"),
            (&test_mm_floor_ps, "test_mm_floor_ps"),
            (&test_mm_extract_ps, "test_mm_extract_ps"),
            (&test_mm_insert_ps, "test_mm_insert_ps"),
            (&test_mm_testz_si128, "test_mm_testz_si128"),
            (&test_mm_testc_si128, "test_mm_testc_si128"),
        ]
    }
}

fn test_mm_blend_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        
        let result = _mm_blend_ps::<0b0101>(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        
        check_f32_array_equality(&result, &[8.0, 3.0, 6.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let _result = _mm_blend_ps::<0b1010>(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_blendv_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let mask = _mm_set_ps(-1.0, 0.0, -1.0, 0.0);
        let result = _mm_blendv_ps(a, b, mask);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 7.0, 2.0, 5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let mask = get_four_random_floats();
                let _result = _mm_blendv_ps(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                    _mm_set_ps(mask[3], mask[2], mask[1], mask[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_dp_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 3.0, 4.0, 5.0);
        
        let result = _mm_dp_ps::<0xFF>(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        
        
        check_f32_array_equality(&result, &[40.0, 40.0, 40.0, 40.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let b = get_four_random_floats();
                let _result = _mm_dp_ps::<0xFF>(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                    _mm_set_ps(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_max_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, -2, 3, 4);
        let b = _mm_set_epi32(2, 3, -4, 5);
        let result = _mm_max_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[5, 3, 3, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let b = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _result = _mm_max_epi32(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_min_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, -2, 3, 4);
        let b = _mm_set_epi32(2, 3, -4, 5);
        let result = _mm_min_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[4, -4, -2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let b = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _result = _mm_min_epi32(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_max_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_max_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_int_array_equality(&result, &[16, 15, 14, 13, 12, 11, 10, 9, 9, 10, 11, 12, 13, 14, 15, 16])?;
    }

    Ok(())
}

fn test_mm_min_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_min_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_int_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm_mullo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_mullo_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[32, 21, 12, 5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let b = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _result = _mm_mullo_epi32(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_mul_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 2, 0, 4);
        let b = _mm_set_epi32(0, 3, 0, 5);
        let result = _mm_mul_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_int_array_equality(&result, &[20, 6])?;
    }

    Ok(())
}

fn test_mm_round_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.5, 2.4, 3.7, 4.2);
        let result = _mm_round_ps::<_MM_FROUND_TO_NEAREST_INT>(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 4.0, 2.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let _result = _mm_round_ps::<_MM_FROUND_TO_NEAREST_INT>(
                    _mm_set_ps(a[3], a[2], a[1], a[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_ceil_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.5, 2.4, 3.7, 4.2);
        let result = _mm_ceil_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[5.0, 4.0, 3.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let _result = _mm_ceil_ps(_mm_set_ps(a[3], a[2], a[1], a[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_floor_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.5, 2.4, 3.7, 4.2);
        let result = _mm_floor_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats();
                let _result = _mm_floor_ps(_mm_set_ps(a[3], a[2], a[1], a[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_extract_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_extract_ps::<2>(a);
        let result_float = f32::from_bits(result as u32);
        check_float_equality(result_float, 2.0, DEFAULT_FLOAT_DIFF)?;
    }

    Ok(())
}

fn test_mm_insert_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        
        let result = _mm_insert_ps::<0b00100000>(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[4.0, 3.0, 8.0, 1.0])?;
    }

    Ok(())
}

fn test_mm_testz_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x00FF0000, 0, 0, 0);
        let b = _mm_set_epi32(0xFF00FFFFu32 as i32, -1, -1, -1);
        let result = _mm_testz_si128(a, b);
        
        
        check_int_equality(result, 1)?;
    }

    unsafe {
        let a = _mm_set_epi32(0x00FF0000, 0, 0, 0);
        let b = _mm_set_epi32(0xFF00FFFFu32 as i32, 0, 0, 0);
        let result = _mm_testz_si128(a, b);
        
        check_int_equality(result, 1)?;
    }

    Ok(())
}

fn test_mm_testc_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-1, -1, -1, -1);
        let b = _mm_set_epi32(0x00FF0000, 0, 0, 0);
        let result = _mm_testc_si128(a, b);
        check_int_equality(result, 1)?; 
    }

    Ok(())
}
