use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_avx_mm256_insert_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64));
        check_array_equality(&result, &[9, 17179869187, 25769803781, 34359738375]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([0, -1, 2, -3]), 1i64));
        check_array_equality(&result, &[1, -1, 2, -3]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from([0, -1, 2, -3]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([100, 200, 300, 400]), 1i64));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from([100, 200, 300, 400]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), 1i64));
        check_array_equality(&result, &[1, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([0, 0, 0, 0]), 1i64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from([0, 0, 0, 0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), 1i64));
        check_array_equality(&result, &[1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64));
        check_array_equality(&result, &[9, 17179869187, 25769803781, 34359738375]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64));
        check_array_equality(&result, &[8589934593, 9, 25769803781, 34359738375]).map_err(|e| format!("{e} | call: _mm256_insert_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_insert_epi64::<1>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([0, -1, 2, -3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from([0, -1, 2, -3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([100, 200, 300, 400]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from([100, 200, 300, 400]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([-1, -1, -1, -1]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_imm_0() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_imm_1() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: _mm256_extract_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extract_epi64::<1>(create_random__m256i());
            }
        }
    }
    Ok(())
}
