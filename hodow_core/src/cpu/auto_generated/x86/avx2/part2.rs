#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx2_mm256_sll_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sll_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, -1024, 2048, -3072]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_sll_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sll_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_sra_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_sra_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_sra_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_sra_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_srl_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm256_srl_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi16(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_srl_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi32(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, 18014398509481983, 0, 18014398509481983]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([0, -1, 2, -3]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([100, 200, 300, 400]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([0, 0, 0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([-1, -1, -1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_srl_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_srl_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx2_mm256_stream_load_si256() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]); 2]);
        let result = unpack__m256i_to_i32_array(_mm256_stream_load_si256(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm256_stream_load_si256(ptr_mem_addr.0.as_ptr())"))?;
    }
    Ok(())
}
