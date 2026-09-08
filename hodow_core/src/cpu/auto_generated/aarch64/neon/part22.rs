use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vrnd64xq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrnd64xq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrnd64xq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd64xq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd64xq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrnd64xq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrnd64xq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd64xq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd64x_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrnd64x_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrnd64x_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd64x_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd64z_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrnd64z_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrnd64z_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd64z_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd64zq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrnd64zq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrnd64zq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd64zq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd64zq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrnd64zq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrnd64zq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd64zq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd64z_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrnd64z_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrnd64z_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd64z_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrnd_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrnd_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrndq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrndq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnd_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrnd_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrnd_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnd_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrndq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnda_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrnda_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrnda_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnda_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndaq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrndaq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrndaq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndaq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrnda_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrnda_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrnda_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrnda_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndaq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrndaq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndaq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndaq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndi_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrndi_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndi_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndi_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndiq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrndiq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrndiq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndiq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndi_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrndi_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrndi_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndi_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndiq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrndiq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndiq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndiq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndm_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrndm_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndm_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndm_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndmq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrndmq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrndmq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndmq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndm_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrndm_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrndm_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndm_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndmq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrndmq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndmq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndmq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndn_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrndn_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrndn_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndn_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndnq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrndnq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndnq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndnq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndns_f32() -> Result<(), String> {
    unsafe {
        let _result = vrndns_f32(1.0f32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndns_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndp_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrndp_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndp_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndp_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndpq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrndpq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrndpq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndpq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndp_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrndp_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrndp_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndp_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndpq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrndpq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndpq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndpq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndx_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrndx_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndx_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndx_f32(create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndxq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vrndxq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: vrndxq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndxq_f32(create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndx_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrndx_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vrndx_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndx_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrndxq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrndxq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: vrndxq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrndxq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshld_s64() -> Result<(), String> {
    unsafe {
        let result = vrshld_s64(1i64, 2i64);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vrshld_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshld_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshld_u64() -> Result<(), String> {
    unsafe {
        let result = vrshld_u64(1u64, 2i64);
        check_int_equality(result as i32, 4).map_err(|e| format!("{e} | call: vrshld_u64(1u64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshld_u64(rand::random::<u64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrd_n_s64() -> Result<(), String> {
    unsafe {
        let result = vrshrd_n_s64::<1>(1i64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vrshrd_n_s64::<1>(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrd_n_s64::<1>(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrd_n_u64() -> Result<(), String> {
    unsafe {
        let result = vrshrd_n_u64::<1>(1u64);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: vrshrd_n_u64::<1>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrd_n_u64::<1>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrn_high_n_s16() -> Result<(), String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vrshrn_high_n_s16::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 6, 6, 7, 7, 8, 8]).map_err(|e| format!("{e} | call: vrshrn_high_n_s16::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrn_high_n_s16::<1>(create_random_int8x8_t(), create_random_int16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrn_high_n_s32() -> Result<(), String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vrshrn_high_n_s32::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 3, 3, 4, 4]).map_err(|e| format!("{e} | call: vrshrn_high_n_s32::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrn_high_n_s32::<1>(create_random_int16x4_t(), create_random_int32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrn_high_n_s64() -> Result<(), String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vrshrn_high_n_s64::<1>(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 2, 2]).map_err(|e| format!("{e} | call: vrshrn_high_n_s64::<1>(create_int32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrn_high_n_s64::<1>(create_random_int32x2_t(), create_random_int64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrn_high_n_u16() -> Result<(), String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vrshrn_high_n_u16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 6, 6, 7, 7, 8, 8]).map_err(|e| format!("{e} | call: vrshrn_high_n_u16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrn_high_n_u16::<1>(create_random_uint8x8_t(), create_random_uint16x8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrn_high_n_u32() -> Result<(), String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vrshrn_high_n_u32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 3, 3, 4, 4]).map_err(|e| format!("{e} | call: vrshrn_high_n_u32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrn_high_n_u32::<1>(create_random_uint16x4_t(), create_random_uint32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrshrn_high_n_u64() -> Result<(), String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vrshrn_high_n_u64::<1>(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 2, 2]).map_err(|e| format!("{e} | call: vrshrn_high_n_u64::<1>(create_uint32x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrshrn_high_n_u64::<1>(create_random_uint32x2_t(), create_random_uint64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrsqrte_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrsqrte_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0.998046875]).map_err(|e| format!("{e} | call: vrsqrte_f64(create_float64x1_t_from([1.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrte_f64(create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrsqrteq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrsqrteq_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0.998046875, 0.705078125]).map_err(|e| format!("{e} | call: vrsqrteq_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrteq_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrsqrted_f64() -> Result<(), String> {
    unsafe {
        let _result = vrsqrted_f64(1.0f64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrted_f64(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrsqrtes_f32() -> Result<(), String> {
    unsafe {
        let _result = vrsqrtes_f32(1.0f32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrtes_f32(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrsqrts_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vrsqrts_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[0.5]).map_err(|e| format!("{e} | call: vrsqrts_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrts_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vrsqrtsq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vrsqrtsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[0.0, -2.5]).map_err(|e| format!("{e} | call: vrsqrtsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vrsqrtsq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}
