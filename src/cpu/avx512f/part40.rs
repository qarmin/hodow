use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(-1, -2);
        let mut buf = [0i16; 2];
        _mm_mask_cvtsepi64_storeu_epi16(buf.as_mut_ptr(), 0, a);
        check_array_equality(&buf, &[-1i16, -2i16])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0i16; 2];
                _mm_mask_cvtsepi64_storeu_epi16(buf.as_mut_ptr(), 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0u16; 2];
        _mm_mask_cvtusepi64_storeu_epi16(buf.as_mut_ptr() as *mut i16, 0, a);
        check_array_equality(&buf, &[1u16, 2u16])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0u16; 2];
                _mm_mask_cvtusepi64_storeu_epi16(buf.as_mut_ptr() as *mut i16, 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0i8; 2];
        _mm_mask_cvtepi64_storeu_epi8(buf.as_mut_ptr(), 0, a);
        check_array_equality(&buf, &[1i8, 2i8])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0i8; 2];
                _mm_mask_cvtepi64_storeu_epi8(buf.as_mut_ptr(), 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(-1, -2);
        let mut buf = [0i8; 2];
        _mm_mask_cvtsepi64_storeu_epi8(buf.as_mut_ptr(), 0, a);
        check_array_equality(&buf, &[-1i8, -2i8])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0i8; 2];
                _mm_mask_cvtsepi64_storeu_epi8(buf.as_mut_ptr(), 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0u8; 2];
        _mm_mask_cvtusepi64_storeu_epi8(buf.as_mut_ptr() as *mut i8, 0, a);
        check_array_equality(&buf, &[1u8, 2u8])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0u8; 2];
                _mm_mask_cvtusepi64_storeu_epi8(buf.as_mut_ptr() as *mut i8, 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0i32; 4];
        _mm_mask_cvtepi64_storeu_epi32(buf.as_mut_ptr(), 0, a);
        check_array_equality(&buf, &[1i32, 2i32, 0i32, 0i32])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0i32; 4];
                _mm_mask_cvtepi64_storeu_epi32(buf.as_mut_ptr(), 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(-1, -2);
        let mut buf = [0i32; 4];
        _mm_mask_cvtsepi64_storeu_epi32(buf.as_mut_ptr(), 0, a);
        check_array_equality(&buf, &[-1i32, -2i32, 0i32, 0i32])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0i32; 4];
                _mm_mask_cvtsepi64_storeu_epi32(buf.as_mut_ptr(), 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0u32; 4];
        _mm_mask_cvtusepi64_storeu_epi32(buf.as_mut_ptr() as *mut i32, 0, a);
        check_array_equality(&buf, &[1u32, 2u32, 0u32, 0u32])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0u32; 4];
                _mm_mask_cvtusepi64_storeu_epi32(buf.as_mut_ptr() as *mut i32, 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let mut buf = [0i32; 4];
        _mm_storeu_epi32(buf.as_mut_ptr(), a);
        check_array_equality(&buf, &[1i32, 2i32, 3i32, 4i32])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                _mm_storeu_epi32(rnd.as_ptr() as *mut i32, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi64() -> Result<(), String> {
    unsafe {
        let data = [1i64, 2i64];
        let r = _mm_loadu_epi64(data.as_ptr());
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1i64, 2i64])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let _ = _mm_loadu_epi64(rnd.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0i64; 2];
        _mm_storeu_epi64(buf.as_mut_ptr(), a);
        check_array_equality(&buf, &[1i64, 2i64])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0i64; 2];
                _mm_storeu_epi64(buf.as_mut_ptr(), _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_load_epi32() -> Result<(), String> {
    unsafe {
        let data = [1i32, 2, 3, 4];
        let r = _mm_load_epi32(data.as_ptr());
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1i32, 2i32, 3i32, 4i32])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_load_epi32(rnd.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_store_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let mut buf = [0i32; 4];
        _mm_store_epi32(buf.as_mut_ptr(), a);
        check_array_equality(&buf, &[1i32, 2i32, 3i32, 4i32])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0i32; 4];
                _mm_store_epi32(buf.as_mut_ptr(), _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_load_epi64() -> Result<(), String> {
    unsafe {
        let data = [1i64, 2i64];
        let r = _mm_load_epi64(data.as_ptr());
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1i64, 2i64])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let _ = _mm_load_epi64(rnd.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_store_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0i64; 2];
        _mm_store_epi64(buf.as_mut_ptr(), a);
        check_array_equality(&buf, &[1i64, 2i64])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0i64; 2];
                _mm_store_epi64(buf.as_mut_ptr(), _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}
