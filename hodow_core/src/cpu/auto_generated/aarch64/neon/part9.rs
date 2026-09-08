use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_neon_vfmas_lane_f32() -> Result<(), String> {
    unsafe {
        let _result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32() -> Result<(), String> {
    unsafe {
        let _result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmad_laneq_f64() -> Result<(), String> {
    unsafe {
        let _result = vfmad_laneq_f64::<0>(1.0f64, 2.0f64, create_float64x2_t_from([3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmad_laneq_f64::<0>(rand::random::<f64>(), rand::random::<f64>(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfms_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vfms_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0])));
        check_array_equality(&result, &[-5.0]).map_err(|e| format!("{e} | call: vfms_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfms_f64(create_random_float64x1_t(), create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfms_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vfms_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[-14.0, -18.0]).map_err(|e| format!("{e} | call: vfms_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfms_lane_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfms_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vfms_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[-14.0, -18.0]).map_err(|e| format!("{e} | call: vfms_laneq_f32::<0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfms_laneq_f32::<0>(create_random_float32x2_t(), create_random_float32x2_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0])));
        check_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| format!("{e} | call: vfmsq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32() -> Result<(), String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| format!("{e} | call: vfmsq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[-14.0, -18.0]).map_err(|e| format!("{e} | call: vfmsq_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfms_lane_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vfms_lane_f64::<0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0])));
        check_array_equality(&result, &[-5.0]).map_err(|e| format!("{e} | call: vfms_lane_f64::<0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x1_t_from([3.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfms_lane_f64::<0>(create_random_float64x1_t(), create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfms_laneq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vfms_laneq_f64::<0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[-5.0]).map_err(|e| format!("{e} | call: vfms_laneq_f64::<0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfms_laneq_f64::<0>(create_random_float64x1_t(), create_random_float64x1_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfms_n_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vfms_n_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), 3.0f64));
        check_array_equality(&result, &[-5.0]).map_err(|e| format!("{e} | call: vfms_n_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfms_n_f64(create_random_float64x1_t(), create_random_float64x1_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0])));
        check_array_equality(&result, &[-14.0, -22.0]).map_err(|e| format!("{e} | call: vfmsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x1_t_from([5.0])));
        check_array_equality(&result, &[-14.0, -18.0]).map_err(|e| format!("{e} | call: vfmsq_lane_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x1_t_from([5.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), 5.0f64));
        check_array_equality(&result, &[-14.0, -18.0]).map_err(|e| format!("{e} | call: vfmsq_n_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), 5.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmss_lane_f32() -> Result<(), String> {
    unsafe {
        let _result = vfmss_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmss_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmss_laneq_f32() -> Result<(), String> {
    unsafe {
        let _result = vfmss_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmss_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsd_lane_f64() -> Result<(), String> {
    unsafe {
        let _result = vfmsd_lane_f64::<0>(1.0f64, 2.0f64, create_float64x1_t_from([3.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsd_lane_f64::<0>(rand::random::<f64>(), rand::random::<f64>(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vfmsd_laneq_f64() -> Result<(), String> {
    unsafe {
        let _result = vfmsd_laneq_f64::<0>(1.0f64, 2.0f64, create_float64x2_t_from([3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vfmsd_laneq_f64::<0>(rand::random::<f64>(), rand::random::<f64>(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vget_high_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vget_high_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vget_high_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vget_high_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vget_low_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vget_low_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vget_low_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vget_low_f64(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vgetq_lane_f64() -> Result<(), String> {
    unsafe {
        let _result = vgetq_lane_f64::<0>(create_float64x2_t_from([1.0, 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vgetq_lane_f64::<0>(create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x2_t_to_f32_array(vld1_f32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vld1_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_f32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack_float32x4_t_to_f32_array(vld1q_f32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: vld1q_f32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_f64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack_float64x1_t_to_f64_array(vld1_f64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: vld1_f64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_f64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack_float64x2_t_to_f64_array(vld1q_f64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: vld1q_f64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack_int8x8_t_to_i8_array(vld1_s8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_s8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_s8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack_int8x16_t_to_i8_array(vld1q_s8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_s8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack_int16x4_t_to_i16_array(vld1_s16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_s16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_s16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack_int16x8_t_to_i16_array(vld1q_s16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_s16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack_int32x2_t_to_i32_array(vld1_s32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1_s32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_s32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack_int32x4_t_to_i32_array(vld1q_s32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_s32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x1_t_to_i64_array(vld1_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_s64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_s64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack_int64x2_t_to_i64_array(vld1q_s64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_s64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x8_t_to_u8_array(vld1_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_u8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_uint8x16_t_to_u8_array(vld1q_u8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x4_t_to_u16_array(vld1_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_u16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 32]);
        let result = unpack_uint16x8_t_to_u16_array(vld1q_u16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x2_t_to_u32_array(vld1_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_u32() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u32; 16]);
        let result = unpack_uint32x4_t_to_u32_array(vld1q_u32(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_u32(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x1_t_to_u64_array(vld1_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: vld1_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_u64() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u64; 8]);
        let result = unpack_uint64x2_t_to_u64_array(vld1q_u64(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| format!("{e} | call: vld1q_u64(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x8_t_to_u8_array(vld1_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_p8() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack_poly8x16_t_to_u8_array(vld1q_p8(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_p8(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x4_t_to_u16_array(vld1_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vld1q_p16() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u16; 64]);
        let result = unpack_poly16x8_t_to_u16_array(vld1q_p16(ptr_ptr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| format!("{e} | call: vld1q_p16(ptr_ptr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmax_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmax_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmax_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmax_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vmaxq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 4.0]).map_err(|e| format!("{e} | call: vmaxq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxnm_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vmaxnm_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: vmaxnm_f64(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxnm_f64(create_random_float64x1_t(), create_random_float64x1_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_neon_vmaxnmq_f64() -> Result<(), String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vmaxnmq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_array_equality(&result, &[3.0, 4.0]).map_err(|e| format!("{e} | call: vmaxnmq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vmaxnmq_f64(create_random_float64x2_t(), create_random_float64x2_t());
            }
        }
    }
    Ok(())
}
