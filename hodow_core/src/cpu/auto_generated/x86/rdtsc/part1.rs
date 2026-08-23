#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_rdtsc_rdtsc() -> Result<(), String> {
    unsafe {
        let result = _rdtsc();
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _rdtsc()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _rdtsc();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_rdtsc_rdtscp() -> Result<(), String> {
    unsafe {
        let mut ptr_aux = crate::cpu::common::Aligned64([1u32; 16]);
        let result = __rdtscp(ptr_aux.0.as_mut_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __rdtscp(ptr_aux.0.as_mut_ptr())"))?;
    }
    Ok(())
}
