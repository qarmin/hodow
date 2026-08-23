#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx_mm256_set1_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_set1_pd(1.0f64));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set1_pd(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set1_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_set1_ps(1.0f32));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set1_ps(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi8(1i8));
        check_array_equality(&result, &[16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009, 16843009])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set1_epi8(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi16(1i16));
        check_array_equality(&result, &[65537, 65537, 65537, 65537, 65537, 65537, 65537, 65537])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set1_epi16(rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set1_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi32(1i32));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set1_epi32(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set1_epi64x() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set1_epi64x(1i64));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set1_epi64x(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castpd_ps(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 1.875, 0.0, 2.0, 0.0, 2.125, 0.0, 2.25])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castpd_ps(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castps_pd(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[2.000000473111868, 512.0001225471497, 8192.001972198486, 131072.0316772461])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castps_pd(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castps_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1065353216, 1073741824, 1077936128, 1082130432, 1084227584, 1086324736, 1088421888, 1090519040])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castps_si256(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castsi256_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castsi256_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1e-45, 3e-45, 4e-45, 6e-45, 7e-45, 8e-45, 1e-44, 1.1e-44])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castsi256_ps(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castpd_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824, 0, 1074266112, 0, 1074790400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castpd_si256(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castsi256_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castsi256_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314, 1.27319747483e-313, 1.6975966331e-313])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castsi256_pd(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castps256_ps128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm256_castps256_ps128(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castps256_ps128(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castpd256_pd128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_castpd256_pd128(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castpd256_pd128(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castsi256_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castsi256_si128(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castps128_ps256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castps128_ps256(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castps128_ps256(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castpd128_pd256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castpd128_pd256(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castpd128_pd256(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_castsi128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castsi128_si256(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_castsi128_si256(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_zextps128_ps256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_zextps128_ps256(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_zextps128_ps256(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_zextsi128_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_zextsi128_si256(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_zextsi128_si256(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_zextpd128_pd256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_zextpd128_pd256(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_zextpd128_pd256(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_undefined_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_undefined_ps());
        check_float_array_equality(&result, &[0.0f32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_undefined_ps();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_undefined_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_undefined_pd());
        check_float_array_equality(&result, &[0.0f64; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_undefined_pd();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_undefined_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_undefined_si256());
        check_array_equality(&result, &[0i32; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_undefined_si256();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set_m128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_set_m128(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 6.0, 7.0, 8.0, 1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set_m128(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set_m128d() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_set_m128d(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 4.0, 1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set_m128d(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_set_m128i() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_set_m128i(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8, 1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_set_m128i(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_setr_m128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_setr_m128d() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_setr_m128i() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_loadu2_m128() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_loadu2_m128(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr()));
        check_float_array_equality(&result, &[2.0, 2.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_loadu2_m128d() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_loadu2_m128d(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr()));
        check_float_array_equality(&result, &[2.0, 2.0, 1.0, 1.0])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_loadu2_m128i() -> Result<(), String> {
    unsafe {
        let ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let result = unpack__m256i_to_i32_array(_mm256_loadu2_m128i(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr()));
        check_array_equality(&result, &[5, 6, 7, 8, 1, 2, 3, 4])?;
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_storeu2_m128() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([3.0, 4.0, 5.0, 6.0]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i() -> Result<(), String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_avx_mm256_cvtss_f32() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtss_f32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtss_f32(create_random__m256());
            }
        }
    }
    Ok(())
}
