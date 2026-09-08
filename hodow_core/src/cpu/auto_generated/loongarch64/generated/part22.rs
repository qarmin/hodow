use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_generated_lsx_vpickve2gr_w() -> Result<(), String> {
    unsafe {
        let result = lsx_vpickve2gr_w::<0>(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_vpickve2gr_w::<0>(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickve2gr_w::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vpickve2gr_d() -> Result<(), String> {
    unsafe {
        let result = lsx_vpickve2gr_d::<0>(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_vpickve2gr_d::<0>(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickve2gr_d::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vpickve2gr_bu() -> Result<(), String> {
    unsafe {
        let result = lsx_vpickve2gr_bu::<0>(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_vpickve2gr_bu::<0>(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickve2gr_bu::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vpickve2gr_hu() -> Result<(), String> {
    unsafe {
        let result = lsx_vpickve2gr_hu::<0>(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_vpickve2gr_hu::<0>(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickve2gr_hu::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vpickve2gr_wu() -> Result<(), String> {
    unsafe {
        let result = lsx_vpickve2gr_wu::<0>(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_vpickve2gr_wu::<0>(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickve2gr_wu::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vpickve2gr_du() -> Result<(), String> {
    unsafe {
        let result = lsx_vpickve2gr_du::<0>(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_vpickve2gr_du::<0>(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickve2gr_du::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vinsgr2vr_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vinsgr2vr_b::<0>(0 /* m128i */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vinsgr2vr_b::<0>(0 /* m128i */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vinsgr2vr_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vinsgr2vr_h::<0>(0 /* m128i */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vinsgr2vr_h::<0>(0 /* m128i */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vinsgr2vr_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vinsgr2vr_w::<0>(0 /* m128i */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vinsgr2vr_w::<0>(0 /* m128i */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vinsgr2vr_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vinsgr2vr_d::<0>(0 /* m128i */, 1i64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vinsgr2vr_d::<0>(0 /* m128i */, rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfadd_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfadd_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfadd_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfadd_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfadd_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfadd_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfsub_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfsub_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfsub_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfsub_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfsub_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfsub_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmul_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmul_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmul_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmul_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmul_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmul_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfdiv_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfdiv_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfdiv_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfdiv_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfdiv_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfdiv_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcvt_h_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcvt_h_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcvt_h_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcvt_s_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcvt_s_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcvt_s_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmin_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmin_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmin_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmin_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmin_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmin_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmina_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmina_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmina_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmina_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmina_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmina_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmax_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmax_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmax_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmax_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmax_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmax_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmaxa_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmaxa_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmaxa_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfmaxa_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmaxa_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmaxa_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfclass_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfclass_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfclass_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfclass_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfclass_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfclass_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfsqrt_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfsqrt_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfsqrt_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfsqrt_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfsqrt_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfsqrt_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrecip_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrecip_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrecip_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrecip_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrecip_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrecip_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrecipe_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrecipe_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrecipe_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrecipe_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrecipe_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrecipe_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrsqrte_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrsqrte_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrsqrte_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrsqrte_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrsqrte_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrsqrte_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrint_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrint_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrint_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrint_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrint_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrint_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrsqrt_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrsqrt_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrsqrt_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrsqrt_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrsqrt_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrsqrt_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vflogb_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vflogb_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vflogb_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vflogb_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vflogb_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vflogb_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcvth_s_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcvth_s_h(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcvth_s_h(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcvth_d_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcvth_d_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcvth_d_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcvtl_s_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcvtl_s_h(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcvtl_s_h(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcvtl_d_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcvtl_d_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcvtl_d_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftint_w_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftint_w_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftint_w_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftint_l_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftint_l_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftint_l_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}
