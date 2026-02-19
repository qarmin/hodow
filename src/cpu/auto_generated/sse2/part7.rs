use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_load_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_load_pd(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_load_sd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_load_sd(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadh_pd() -> Result<(), String> {
    unsafe {
        let a = create__m128d_from([1.0, 2.0]);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_loadh_pd(a, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadl_pd() -> Result<(), String> {
    unsafe {
        let a = create__m128d_from([1.0, 2.0]);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_stream_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_stream_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store_sd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_store_sd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_store_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_storeu_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_si16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_storeu_si16(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_si32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_storeu_si32(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_si64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_storeu_si64(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store1_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_store1_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store_pd1() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_store_pd1(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storer_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_storer_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeh_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_storeh_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storel_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_storel_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_load1_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_load1_pd(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_load_pd1() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_load_pd1(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadr_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_loadr_pd(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_loadu_pd(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_si16() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        let result = unpack__m128i_to_i32_array(_mm_loadu_si16(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_si32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        let result = unpack__m128i_to_i32_array(_mm_loadu_si32(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_si64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        let result = unpack__m128i_to_i32_array(_mm_loadu_si64(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_shuffle_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_shuffle_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_shuffle_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_move_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_move_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_move_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castpd_ps(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castpd_ps(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castpd_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castpd_si128(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castps_pd(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castps_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castps_si128(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castsi128_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castsi128_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castsi128_pd(create_random__m128i());
            }
        }
    }
    Ok(())
}
