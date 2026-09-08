#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1115454548, 1601664833, 1266383704, -873270698, 2070637438, 2003791733, -1832532677, -1775226667]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-58065789, -1979938315, -1063393107, 1337903999, 1410887102, -1562013493, -393875327, 57870074]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[54739789, -84420963, 1248742992, 1717592575, 145462786, 1820213295, 1904039809, 464030427]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890]).map_err(|e| format!("{e} | call: _mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1667457909, 1667457917, 1667457904, 1667458046, 1667457894, 1667457889, 1667457994, 1667457824]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[375592553, 1662411551, 375592571, 1662411603, 375592700, 1662411530, 375592575, 1662411674]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[1667457837, 1667464250, 1667464519, 1667457786, 1667462721, 1667462408, 1667463587, 1667465117]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158]).map_err(|e| format!("{e} | call: _mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1368450932, -1051610861, -1800699598, -912388812, -206554351, -1448256351, -1846131385, 1460639283]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[587997958, 203623466, -1341145013, 1052935713, -1195344792, -558505326, -655151647, -1865959176]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[1137052007, 894036133, -494746748, -1117470177, -1981427411, -457501829, 1685617328, 1805593807]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459]).map_err(|e| format!("{e} | call: _mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1381126656, 1381126752, 1381126878, 1381126716, 1381126715, 1381126827, 1381126711, 1381126831]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2102558040, 1383944820, 2102558054, 1383944742, 2102558014, 1383944806, 2102558133, 1383944810]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[1381108194, 1381126755, 1381127028, 1381107724, 1381160004, 1381108540, 1381132478, 1381132670]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411]).map_err(|e| format!("{e} | call: _mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1115454540, 1601664857, 1266383680, -873270706, 2070637414, 2003791725, -1832532701, -1775226659, -989789762, 1869047665, -1154798616, -536936866, -1529358579, 548121590, 1551267414, -2083862006]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-58065789, -1979938315, -1063393107, 1337903999, 1410887102, -1562013493, -393875327, 57870074, -58065789, -1979938315, -1063393107, 1337903999, 1410887102, -1562013493, -393875327, 57870074]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[54739789, -84420963, 1248742992, 1717592575, 145462786, 1820213295, 1904039809, 464030427, 1061645501, -519396910, 750261257, -318778398, -604836020, 297052508, 1535810368, -721346587]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890]).map_err(|e| format!("{e} | call: _mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1667457901, 1667457893, 1667457896, 1667458022, 1667457918, 1667457913, 1667458002, 1667457832, 1667457816, 1667457917, 1667457840, 1667458018, 1667457994, 1667457973, 1667457897, 1667458026]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[375592553, 1662411551, 375592571, 1662411603, 375592700, 1662411530, 375592575, 1662411674, 375592553, 1662411551, 375592571, 1662411603, 375592700, 1662411530, 375592575, 1662411674]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[1667457837, 1667464250, 1667464519, 1667457786, 1667462721, 1667462408, 1667463587, 1667465117, 1667463377, 1667494249, 1667495551, 1667465053, 1667460836, 1667460670, 1667459680, 1667460419]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158]).map_err(|e| format!("{e} | call: _mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1368450924, -1051610869, -1800699606, -912388820, -206554359, -1448256327, -1846131361, 1460639291, -191311689, -1820104047, 666477805, -31308976, -717320997, -2102291653, -1923693399, 1269766141]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[587997958, 203623466, -1341145013, 1052935713, -1195344792, -558505326, -655151647, -1865959176, 587997958, 203623466, -1341145013, 1052935713, -1195344792, -558505326, -655151647, -1865959176]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[1137052007, 894036133, -494746748, -1117470177, -1981427411, -457501829, 1685617328, 1805593807, 1368182497, -1560732501, -1026930024, 1881839037, -7442139, -366575934, -1165915401, -880795294]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459]).map_err(|e| format!("{e} | call: _mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1381126680, 1381126776, 1381126854, 1381126692, 1381126691, 1381126835, 1381126703, 1381126823, 1381126745, 1381126841, 1381126789, 1381126813, 1381126894, 1381126857, 1381126884, 1381126748]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2102558040, 1383944820, 2102558054, 1383944742, 2102558014, 1383944806, 2102558133, 1383944810, 2102558040, 1383944820, 2102558054, 1383944742, 2102558014, 1383944806, 2102558133, 1383944810]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_normal2() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[1381108194, 1381126755, 1381127028, 1381107724, 1381160004, 1381108540, 1381132478, 1381132670, 1381118913, 1381160506, 1381159179, 1381119046, 1381146757, 1381118787, 1381118837, 1381118008]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_normal3() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411]).map_err(|e| format!("{e} | call: _mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min_impl() }
}
