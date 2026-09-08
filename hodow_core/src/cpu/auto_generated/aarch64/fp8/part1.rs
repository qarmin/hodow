use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_fp8_vscale_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vscale_f32(create_float32x2_t_from([1.0, 2.0]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[0.0f32; 2]).map_err(|e| format!("{e} | call: vscale_f32(create_float32x2_t_from([1.0, 2.0]), create_int32x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vscale_f32(create_random_float32x2_t(), create_random_int32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_fp8_vscaleq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vscaleq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[0.0f32; 4]).map_err(|e| format!("{e} | call: vscaleq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vscaleq_f32(create_random_float32x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_fp8_vscaleq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vscaleq_f64(create_float64x2_t_from([1.0, 2.0]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[0.0f64; 2]).map_err(|e| format!("{e} | call: vscaleq_f64(create_float64x2_t_from([1.0, 2.0]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vscaleq_f64(create_random_float64x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}
