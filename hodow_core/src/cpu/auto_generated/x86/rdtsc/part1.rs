#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_rdtsc() -> Result<(), String> {
    unsafe {
        let result = _rdtsc();
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_rdtscp() -> Result<(), String> {
    unsafe {
        let mut ptr_aux = [1u32; 1];
        let result = __rdtscp(ptr_aux.as_mut_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}
