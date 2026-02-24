#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_undefined_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_undefined_ps());
        check_float_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_undefined_ps();
            }
        }
    }
    Ok(())
}

pub(super) fn test_MM_TRANSPOSE4_PS() -> Result<(), String> {
    unsafe {
        let mut ref_row0 = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let mut ref_row1 = create__m128_from([5.0, 6.0, 7.0, 8.0]);
        let mut ref_row2 = create__m128_from([9.0, 10.0, 11.0, 12.0]);
        let mut ref_row3 = create__m128_from([13.0, 14.0, 15.0, 16.0]);
        _MM_TRANSPOSE4_PS(&mut ref_row0, &mut ref_row1, &mut ref_row2, &mut ref_row3);
    }
    Ok(())
}

pub(super) fn test_mm_stream_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_stream_ps(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}
