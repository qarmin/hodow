#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm256_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtps_epi32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_epi32(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cvtps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtps_pd(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtsd_f64() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtsd_f64(create__m256d_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsd_f64(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvttpd_epi32(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttpd_epi32(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtpd_epi32(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtpd_epi32(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttps_epi32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvttps_epi32(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_extractf128_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_extractf128_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extractf128_ps::<0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_extractf128_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf128_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extractf128_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_extractf128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extractf128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extractf128_si256::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_extract_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi32::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtsi256_si32() -> Result<(), String> {
    unsafe {
        let result = _mm256_cvtsi256_si32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtsi256_si32(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_zeroall() -> Result<(), String> {
    unsafe {
        _mm256_zeroall();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm256_zeroall();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_zeroupper() -> Result<(), String> {
    unsafe {
        _mm256_zeroupper();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm256_zeroupper();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutevar_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[2.0, 3.0, 4.0, 1.0, 6.0, 7.0, 8.0, 5.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_ps(create_random__m256(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutevar_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_float_array_equality(&result, &[2.0, 3.0, 4.0, 1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permute_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 5.0, 5.0, 5.0, 5.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permute_ps::<0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permute_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permute_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutevar_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutevar_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permutevar_pd(create_random__m256d(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutevar_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([1.0, 2.0]), create__m128i_from_i32_array([3, 4, 5, 6])));
        check_float_array_equality(&result, &[2.0, 1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permute_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 3.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permute_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permute_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_permute_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permute2f128_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute2f128_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permute2f128_ps::<0>(create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permute2f128_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute2f128_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permute2f128_pd::<0>(create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permute2f128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permute2f128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_permute2f128_si256::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_ss() -> Result<(), String> {
    unsafe {
        let ref_f = 1.0f32;
        let result = unpack__m256_to_f32_array(_mm256_broadcast_ss(&ref_f));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_broadcast_ss() -> Result<(), String> {
    unsafe {
        let ref_f = 1.0f32;
        let result = unpack__m128_to_f32_array(_mm_broadcast_ss(&ref_f));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_sd() -> Result<(), String> {
    unsafe {
        let ref_f = 1.0f64;
        let result = unpack__m256d_to_f64_array(_mm256_broadcast_sd(&ref_f));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_ps() -> Result<(), String> {
    unsafe {
        let ref_a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256_to_f32_array(_mm256_broadcast_ps(&ref_a));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 1.0, 2.0, 3.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_pd() -> Result<(), String> {
    unsafe {
        let ref_a = create__m128d_from([1.0, 2.0]);
        let result = unpack__m256d_to_f64_array(_mm256_broadcast_pd(&ref_a));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 2.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_insertf128_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_insertf128_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[9.0, 10.0, 11.0, 12.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insertf128_ps::<0>(create_random__m256(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_insertf128_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_insertf128_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[5.0, 6.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insertf128_pd::<0>(create_random__m256d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_insertf128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insertf128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insertf128_si256::<0>(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_insert_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_insert_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi16::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_insert_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_load_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_load_pd(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_store_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([2.0, 3.0, 4.0, 5.0]);
        _mm256_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_load_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_load_ps(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_store_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]);
        _mm256_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_loadu_pd(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m256d_from([2.0, 3.0, 4.0, 5.0]);
        _mm256_storeu_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_loadu_ps(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m256_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]);
        _mm256_storeu_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_load_si256() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let result = unpack__m256i_to_i32_array(_mm256_load_si256(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_store_si256() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        _mm256_store_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_si256() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let result = unpack__m256i_to_i32_array(_mm256_loadu_si256(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_si256() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let a = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        _mm256_storeu_si256(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_maskload_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256d_to_f64_array(_mm256_maskload_pd(ptr_mem_addr.0.as_ptr(), mask));
        check_float_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskstore_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([10.0, 11.0, 12.0, 13.0]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_maskload_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128d_to_f64_array(_mm_maskload_pd(ptr_mem_addr.0.as_ptr(), mask));
        check_float_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}
