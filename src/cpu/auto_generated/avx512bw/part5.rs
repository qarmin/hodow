use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_reduce_max_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_max_epu16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_max_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_max_epu16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_max_epu16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_max_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_max_epu8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_max_epu8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_max_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_max_epu8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_min_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_min_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_min_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_min_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epu16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_min_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epu16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epu16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_min_epu16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_min_epu8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_min_epu8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epu8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_min_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_min_epu8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_mul_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_mul_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_mul_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_or_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_or_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_or_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_or_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_or_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_or_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_reduce_or_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_or_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi16() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m128i_to_i32_array(_mm_loadu_epi16(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi8() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m128i_to_i32_array(_mm_loadu_epi8(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_storeu_epi16(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_storeu_epi8(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi16() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m128i_to_i32_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi16() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_loadu_epi16(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi8() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m128i_to_i32_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi8() -> Result<(), String> {
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_loadu_epi8(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_storeu_epi16(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_storeu_epi8(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}
