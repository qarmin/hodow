use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_aes_vld1_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x1_t_to_u64_array(vld1_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_aes_vld1q_p64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let result = unpack_poly64x2_t_to_u64_array(vld1q_p64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_p64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_aes_vmull_high_p64() -> Result<(), String> {
    unsafe {
        let _result = vmull_high_p64(create_poly64x2_t_from([1, 2]), create_poly64x2_t_from([3, 4]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmull_high_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_aes_vmull_p64() -> Result<(), String> {
    unsafe {
        let _result = vmull_p64(1u64, 2u64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmull_p64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_aes_vst1_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x1_t_from([2]);
        vst1_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_aarch64_aes_vst1q_p64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u64; 64]);
        let a = create_poly64x2_t_from([2, 3]);
        vst1q_p64(ptr_ptr.0.as_mut_ptr(), a);
    }
    Ok(())
}
