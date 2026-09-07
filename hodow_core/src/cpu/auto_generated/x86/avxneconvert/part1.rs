#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avxneconvert_mm_cvtneebf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]); 4]);
        let result = unpack__m128_to_f32_array(_mm_cvtneebf16_ps(ptr_a.0.as_ptr()));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cvtneebf16_ps(ptr_a.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneebf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 2]);
        let result = unpack__m256_to_f32_array(_mm256_cvtneebf16_ps(ptr_a.0.as_ptr()));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cvtneebf16_ps(ptr_a.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneobf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]); 4]);
        let result = unpack__m128_to_f32_array(_mm_cvtneobf16_ps(ptr_a.0.as_ptr()));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cvtneobf16_ps(ptr_a.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneobf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 2]);
        let result = unpack__m256_to_f32_array(_mm256_cvtneobf16_ps(ptr_a.0.as_ptr()));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm256_cvtneobf16_ps(ptr_a.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal2() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal3() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_min() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_max() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_zero() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_allones() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_mixed() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal2() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal3() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_min() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_max() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_zero() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_allones() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_mixed() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}
