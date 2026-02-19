use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128d_from([1.0, 2.0]);
        let result = unpack__m128d_to_f64_array(_mm_mask_i64gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256d_to_f64_array(_mm256_i64gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f64; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_i64gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_inserti128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_inserti128_si256::<0>(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_madd_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_madd_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maddubs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maddubs_epi16(create_random__m256i(), create_random__m256i());
            }
        }
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

pub(super) fn test_mm256_maskload_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i32; 1];
        let mask = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 8])?;
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

pub(super) fn test_mm256_maskload_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i64; 1];
        let mask = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi64(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0i32; 8])?;
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

pub(super) fn test_mm256_maskstore_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let mask = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_maskstore_epi32(ptr_mem_addr.as_mut_ptr(), mask, a);
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

pub(super) fn test_mm256_maskstore_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i64; 1];
        let mask = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_maskstore_epi64(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm256_max_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_max_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_max_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_max_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_max_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_max_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_max_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_max_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_max_epi8(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_max_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_max_epu16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_max_epu16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_max_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_max_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_max_epu32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_max_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_max_epu8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_max_epu8(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_min_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_min_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_min_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_min_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_min_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_min_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_min_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_min_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_min_epi8(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_min_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_min_epu16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_min_epu16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_min_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_min_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_min_epu32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_min_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_min_epu8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_min_epu8(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movemask_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_movemask_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_movemask_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mpsadbw_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mpsadbw_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mpsadbw_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}
