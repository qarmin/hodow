#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_comineq_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomieq_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomilt_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomile_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomigt_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomige_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ucomineq_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtpd_ps(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpd_ps(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtps_pd(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtpd_epi32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpd_epi32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_f64() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtsd_f64(create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_f64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtss_sd(create__m128d_from([1.0, 2.0]), create__m128_from([3.0, 4.0, 5.0, 6.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_sd(create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttpd_epi32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttpd_epi32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttps_epi32(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttps_epi32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set_sd(1.0f64));
        check_float_array_equality(&result, &[1.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_set_sd(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set1_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set1_pd(1.0f64));
        check_float_array_equality(&result, &[1.0, 1.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_set1_pd(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_pd1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set_pd1(1.0f64));
        check_float_array_equality(&result, &[1.0, 1.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_set_pd1(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set_pd(1.0f64, 2.0f64));
        check_float_array_equality(&result, &[2.0, 1.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_set_pd(rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_setr_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_setr_pd(1.0f64, 2.0f64));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_setr_pd(rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_setzero_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_setzero_pd());
        check_float_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_setzero_pd();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movemask_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_movemask_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_load_sd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_load_sd(ptr_mem_addr.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadh_pd() -> Result<(), String> {
    unsafe {
        let a = create__m128d_from([1.0, 2.0]);
        let ptr_mem_addr = [3.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_loadh_pd(a, ptr_mem_addr.as_ptr()));
        check_float_array_equality(&result, &[1.0, 3.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadl_pd() -> Result<(), String> {
    unsafe {
        let a = create__m128d_from([1.0, 2.0]);
        let ptr_mem_addr = [3.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.as_ptr()));
        check_float_array_equality(&result, &[3.0, 2.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_store_sd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([2.0, 3.0]);
        _mm_store_sd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeh_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([2.0, 3.0]);
        _mm_storeh_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storel_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let a = create__m128d_from([2.0, 3.0]);
        _mm_storel_pd(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_load1_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_load1_pd(ptr_mem_addr.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_load_pd1() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_load_pd1(ptr_mem_addr.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_shuffle_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_shuffle_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 3.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_shuffle_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_move_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_move_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_move_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castpd_ps(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, 1.875, 0.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castpd_ps(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castpd_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castpd_si128(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.000000473111868, 512.0001225471497])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castps_pd(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castps_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1065353216, 1073741824, 1077936128, 1082130432])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castps_si128(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castsi128_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castsi128_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castsi128_pd(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castsi128_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castsi128_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1e-45, 3e-45, 4e-45, 6e-45])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castsi128_ps(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_undefined_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_undefined_pd());
        check_float_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_undefined_pd();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_undefined_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_undefined_si128());
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_undefined_si128();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_unpackhi_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_unpackhi_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_unpackhi_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_unpacklo_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 3.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_unpacklo_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}
