#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_ktest_mask8_u8() -> Result<(), String> {
    unsafe {
        let a = create__mmask8_from(0b01010101);
        let b = create__mmask8_from(0b01010101);
        let mut ptr_and_not = [1u8; 1];
        let result = _ktest_mask8_u8(a, b, ptr_and_not.as_mut_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_ktestc_mask16_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestc_mask16_u8(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestc_mask16_u8(create_random__mmask16(), create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_ktestc_mask8_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestc_mask8_u8(create__mmask8_from(0b01010101), create__mmask8_from(0b01010101));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestc_mask8_u8(create_random__mmask8(), create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_ktestz_mask16_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestz_mask16_u8(create__mmask16_from(0b0101010101010101), create__mmask16_from(0b0101010101010101));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestz_mask16_u8(create_random__mmask16(), create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_ktestz_mask8_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestz_mask8_u8(create__mmask8_from(0b01010101), create__mmask8_from(0b01010101));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestz_mask8_u8(create_random__mmask8(), create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_load_mask8() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [create__mmask8_from(0b01010101); 1];
        let result = _load_mask8(ptr_mem_addr.as_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_store_mask8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [create__mmask8_from(0b01010101); 1];
        let a = create__mmask8_from(0b01010101);
        _store_mask8(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_movepi32_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_movepi32_mask(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movepi32_mask(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movepi32_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_movepi32_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movepi32_mask(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_movepi32_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_movepi32_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movepi32_mask(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movepi64_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_movepi64_mask(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movepi64_mask(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movepi64_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_movepi64_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movepi64_mask(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_movepi64_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_movepi64_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movepi64_mask(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movm_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_movm_epi32(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movm_epi32(create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movm_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_movm_epi32(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movm_epi32(create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_movm_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_movm_epi32(create__mmask16_from(0b0101010101010101)));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movm_epi32(create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movm_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_movm_epi64(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movm_epi64(create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movm_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_movm_epi64(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movm_epi64(create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_movm_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_movm_epi64(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movm_epi64(create_random__mmask8());
            }
        }
    }
    Ok(())
}
