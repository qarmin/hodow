#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm256_movepi16_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_movepi16_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movepi16_mask(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movepi16_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_movepi16_mask(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movepi16_mask(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_movepi8_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movepi8_mask(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movepi8_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movepi8_mask(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movepi8_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movepi8_mask(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_movm_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_movm_epi16(create__mmask32_from(0x55555555u32)));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movm_epi16(create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movm_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_movm_epi16(create__mmask16_from(0b0101010101010101)));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movm_epi16(create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movm_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_movm_epi16(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[65535, 65535, 65535, 65535])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movm_epi16(create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_movm_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_movm_epi8(create__mmask64_from(0x5555555555555555u64)));
        check_array_equality(&result, &[16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_movm_epi8(create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_movm_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_movm_epi8(create__mmask32_from(0x55555555u32)));
        check_array_equality(&result, &[16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_movm_epi8(create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movm_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_movm_epi8(create__mmask16_from(0b0101010101010101)));
        check_array_equality(&result, &[16711935, 16711935, 16711935, 16711935])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movm_epi8(create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_cvtmask32_u32() -> Result<(), String> {
    unsafe {
        let result = _cvtmask32_u32(create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _cvtmask32_u32(create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_cvtu32_mask32() -> Result<(), String> {
    unsafe {
        let result = _cvtu32_mask32(1u32);
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _cvtu32_mask32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kadd_mask32() -> Result<(), String> {
    unsafe {
        let result = _kadd_mask32(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, -1431655766)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kadd_mask32(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kadd_mask64() -> Result<(), String> {
    unsafe {
        let result = _kadd_mask64(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, -1431655766)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kadd_mask64(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kand_mask32() -> Result<(), String> {
    unsafe {
        let result = _kand_mask32(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kand_mask32(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kand_mask64() -> Result<(), String> {
    unsafe {
        let result = _kand_mask64(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kand_mask64(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_knot_mask32() -> Result<(), String> {
    unsafe {
        let result = _knot_mask32(create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, -1431655766)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _knot_mask32(create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_knot_mask64() -> Result<(), String> {
    unsafe {
        let result = _knot_mask64(create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, -1431655766)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _knot_mask64(create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kandn_mask32() -> Result<(), String> {
    unsafe {
        let result = _kandn_mask32(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kandn_mask32(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kandn_mask64() -> Result<(), String> {
    unsafe {
        let result = _kandn_mask64(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kandn_mask64(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kor_mask32() -> Result<(), String> {
    unsafe {
        let result = _kor_mask32(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kor_mask32(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kor_mask64() -> Result<(), String> {
    unsafe {
        let result = _kor_mask64(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kor_mask64(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kxor_mask32() -> Result<(), String> {
    unsafe {
        let result = _kxor_mask32(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kxor_mask32(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kxor_mask64() -> Result<(), String> {
    unsafe {
        let result = _kxor_mask64(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kxor_mask64(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kxnor_mask32() -> Result<(), String> {
    unsafe {
        let result = _kxnor_mask32(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, -1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kxnor_mask32(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kxnor_mask64() -> Result<(), String> {
    unsafe {
        let result = _kxnor_mask64(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, -1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kxnor_mask64(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kortest_mask32_u8() -> Result<(), String> {
    unsafe {
        let a = create__mmask32_from(0x55555555u32);
        let b = create__mmask32_from(0x55555555u32);
        let mut ptr_all_ones = [1u8; 1];
        let result = _kortest_mask32_u8(a, b, ptr_all_ones.as_mut_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_kortest_mask64_u8() -> Result<(), String> {
    unsafe {
        let a = create__mmask64_from(0x5555555555555555u64);
        let b = create__mmask64_from(0x5555555555555555u64);
        let mut ptr_all_ones = [1u8; 1];
        let result = _kortest_mask64_u8(a, b, ptr_all_ones.as_mut_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_kortestc_mask32_u8() -> Result<(), String> {
    unsafe {
        let result = _kortestc_mask32_u8(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kortestc_mask32_u8(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kortestc_mask64_u8() -> Result<(), String> {
    unsafe {
        let result = _kortestc_mask64_u8(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kortestc_mask64_u8(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kortestz_mask32_u8() -> Result<(), String> {
    unsafe {
        let result = _kortestz_mask32_u8(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kortestz_mask32_u8(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kortestz_mask64_u8() -> Result<(), String> {
    unsafe {
        let result = _kortestz_mask64_u8(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kortestz_mask64_u8(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kshiftli_mask32() -> Result<(), String> {
    unsafe {
        let result = _kshiftli_mask32::<0>(create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kshiftli_mask32::<0>(create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kshiftli_mask64() -> Result<(), String> {
    unsafe {
        let result = _kshiftli_mask64::<0>(create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kshiftli_mask64::<0>(create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kshiftri_mask32() -> Result<(), String> {
    unsafe {
        let result = _kshiftri_mask32::<0>(create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kshiftri_mask32::<0>(create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_kshiftri_mask64() -> Result<(), String> {
    unsafe {
        let result = _kshiftri_mask64::<0>(create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _kshiftri_mask64::<0>(create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_ktest_mask32_u8() -> Result<(), String> {
    unsafe {
        let a = create__mmask32_from(0x55555555u32);
        let b = create__mmask32_from(0x55555555u32);
        let mut ptr_and_not = [1u8; 1];
        let result = _ktest_mask32_u8(a, b, ptr_and_not.as_mut_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_ktest_mask64_u8() -> Result<(), String> {
    unsafe {
        let a = create__mmask64_from(0x5555555555555555u64);
        let b = create__mmask64_from(0x5555555555555555u64);
        let mut ptr_and_not = [1u8; 1];
        let result = _ktest_mask64_u8(a, b, ptr_and_not.as_mut_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_ktestc_mask32_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestc_mask32_u8(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestc_mask32_u8(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_ktestc_mask64_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestc_mask64_u8(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestc_mask64_u8(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_ktestz_mask32_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestz_mask32_u8(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestz_mask32_u8(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_ktestz_mask64_u8() -> Result<(), String> {
    unsafe {
        let result = _ktestz_mask64_u8(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _ktestz_mask64_u8(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_kunpackw() -> Result<(), String> {
    unsafe {
        let result = _mm512_kunpackw(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_kunpackw(create_random__mmask32(), create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_kunpackd() -> Result<(), String> {
    unsafe {
        let result = _mm512_kunpackd(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 1431655765)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_kunpackd(create_random__mmask64(), create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi16_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_cvtepi16_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295, 655369, 786443, 917517, 1048591])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_cvtepi16_epi8(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi16_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_cvtepi16_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[655369, 786443, 917517, 1048591, 1179665, 1310739, 1441813, 1572887])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_cvtepi16_epi8(create_random__m256i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi16_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_maskz_cvtepi16_epi8(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295, 655369, 786443, 917517, 1048591])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_cvtepi16_epi8(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepi16_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtepi16_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtepi16_epi8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi16_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_mask_cvtepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[393221, 524295, 655369, 786443])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_cvtepi16_epi8(create_random__m128i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}
