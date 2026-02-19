use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_comile_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comile_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comilt_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comilt_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comineq_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comineq_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomieq_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_ucomieq_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomige_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_ucomige_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomigt_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_ucomigt_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomile_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_ucomile_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomilt_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_ucomilt_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomineq_sh() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sh(0 /* __m128h */, 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_ucomineq_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_load_ph() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm_load_ph(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm256_load_ph() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm256_load_ph(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm512_load_ph() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm512_load_ph(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm_load_sh() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm_load_sh(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_sh() -> Result<(), String> {
    unsafe {
        let src = 0;
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm_mask_load_sh(src, k, ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_sh() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm_maskz_load_sh(k, ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm_loadu_ph() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm_loadu_ph(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_ph() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm256_loadu_ph(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm512_loadu_ph() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [0 /* f16 */; 1];
        let _result = _mm512_loadu_ph(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm_mask_move_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_move_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_move_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_move_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_move_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_move_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_move_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_move_sh(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_move_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_store_ph() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let a = 0;
        _mm_store_ph(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_store_ph() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let a = 0;
        _mm256_store_ph(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_store_ph() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let a = 0;
        _mm512_store_ph(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store_sh() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let a = 0;
        _mm_store_sh(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_sh() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let k = create__mmask8_from(0b01010101);
        let a = 0;
        _mm_mask_store_sh(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_ph() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let a = 0;
        _mm_storeu_ph(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_ph() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let a = 0;
        _mm256_storeu_ph(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_storeu_ph() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [0 /* f16 */; 1];
        let a = 0;
        _mm512_storeu_ph(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_add_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_add_ph(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_add_ph(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}
