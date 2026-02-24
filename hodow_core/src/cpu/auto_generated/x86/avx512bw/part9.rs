use std::arch::x86::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_reduce_mul_epi16(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
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
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_mul_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_mul_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_mul_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_mul_epi8(create_random__mmask32(), create_random__m256i());
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
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
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
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_mul_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_or_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_or_epi16(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_or_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_or_epi16(create_random__mmask16(), create_random__m256i());
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
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
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
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_or_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_reduce_or_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_reduce_or_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_reduce_or_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_reduce_or_epi8(create_random__mmask32(), create_random__m256i());
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
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
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
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_reduce_or_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_loadu_epi16() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m512i_to_i32_array(_mm512_loadu_epi16(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_epi16() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m256i_to_i32_array(_mm256_loadu_epi16(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
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

pub(super) fn test_mm512_loadu_epi8() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m512i_to_i32_array(_mm512_loadu_epi8(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_epi8() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m256i_to_i32_array(_mm256_loadu_epi8(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
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

pub(super) fn test_mm512_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_storeu_epi16(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_storeu_epi16(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_storeu_epi16(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_storeu_epi8(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_storeu_epi8(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_storeu_epi8(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_loadu_epi16() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [17i16; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_loadu_epi16() -> Result<(), String> {
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m512i_to_i32_array(_mm512_maskz_loadu_epi16(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_loadu_epi8() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = [17i8; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_loadu_epi8() -> Result<(), String> {
    unsafe {
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m512i_to_i32_array(_mm512_maskz_loadu_epi8(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_epi16() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [9i16; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_epi16() -> Result<(), String> {
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_loadu_epi16(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_epi8() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [9i8; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_epi8() -> Result<(), String> {
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_loadu_epi8(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi16() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [5i16; 1];
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
        let ptr_mem_addr = [5i8; 1];
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

pub(super) fn test_mm512_mask_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let mask = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_storeu_epi16(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let mask = create__mmask64_from(0x5555555555555555u64);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_storeu_epi8(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_storeu_epi16(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let mask = create__mmask32_from(0x55555555u32);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_storeu_epi8(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_storeu_epi16(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_storeu_epi8(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm512_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_madd_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_madd_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_madd_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_madd_epi16(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_madd_epi16(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_madd_epi16(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_madd_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_madd_epi16(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_madd_epi16(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_madd_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_madd_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
