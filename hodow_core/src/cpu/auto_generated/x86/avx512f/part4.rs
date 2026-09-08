#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_ternarylogic_epi32::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-50, -51, -52, -53, -54, -55, -56, -57, -58, -59, -60, -61, -62, -63, -64, -49]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi32::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi32::<1>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7, 0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800, 0, 1000, 0, 1200, 0, 1400, 0, 1600]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<0>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_ternarylogic_epi32::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-50, 2, -52, 4, -54, 6, -56, 8, -58, 10, -60, 12, -62, 14, -64, 16]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi32::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi32::<1>(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<0>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_ternarylogic_epi32::<1>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-50, 0, -52, 0, -54, 0, -56, 0, -58, 0, -60, 0, -62, 0, -64, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi32::<1>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi32::<1>(create_random__mmask16(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_ternarylogic_epi32::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-26, -27, -28, -29, -30, -31, -32, -25]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi32::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi32::<1>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_ternarylogic_epi32::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-26, 2, -28, 4, -30, 6, -32, 8]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi32::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi32::<1>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_ternarylogic_epi32::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-26, 0, -28, 0, -30, 0, -32, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi32::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi32::<1>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_ternarylogic_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[-14, -15, -16, -13]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi32::<1>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 2, 0, 4]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 2, 0, 4]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_ternarylogic_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[-14, 2, -16, 4]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi32::<1>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi32_imm_1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_ternarylogic_epi32::<1>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[-14, 0, -16, 0]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi32::<1>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi32::<1>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<0>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_ternarylogic_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-214748364850, -223338299444, -231928234038, -240518168632, -249108103226, -257698037820, -266287972414, -206158430272]).map_err(|e| format!("{e} | call: _mm512_ternarylogic_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_ternarylogic_epi64::<1>(create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375, 0, 51539607563, 0, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 0, -3, 0, -5, 0, -7]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0, 200, 0, 400, 0, 600, 0, 800]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1, 0, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375, 0, 51539607563, 0, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_ternarylogic_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-214748364850, 17179869187, -231928234038, 34359738375, -249108103226, 51539607563, -266287972414, 68719476751]).map_err(|e| format!("{e} | call: _mm512_mask_ternarylogic_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_ternarylogic_epi64::<1>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_ternarylogic_epi64::<1>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-214748364850, 0, -231928234038, 0, -249108103226, 0, -266287972414, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_ternarylogic_epi64::<1>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_ternarylogic_epi64::<1>(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<0>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_ternarylogic_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-111669149722, -120259084316, -128849018910, -103079215136]).map_err(|e| format!("{e} | call: _mm256_ternarylogic_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_ternarylogic_epi64::<1>(create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 0, -3]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420])));
        check_array_equality(&result, &[0, 200, 0, 400]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0, 17179869187, 0, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_ternarylogic_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-111669149722, 17179869187, -128849018910, 34359738375]).map_err(|e| format!("{e} | call: _mm256_mask_ternarylogic_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_ternarylogic_epi64::<1>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_ternarylogic_epi64::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-111669149722, 0, -128849018910, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_ternarylogic_epi64::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_ternarylogic_epi64::<1>(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_ternarylogic_epi64::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[-60129542158, -51539607568]).map_err(|e| format!("{e} | call: _mm_ternarylogic_epi64::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ternarylogic_epi64::<1>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0, 200]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, -1]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, -9223372036854775808]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_ternarylogic_epi64::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[-60129542158, 17179869187]).map_err(|e| format!("{e} | call: _mm_mask_ternarylogic_epi64::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_ternarylogic_epi64::<1>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_ternarylogic_epi64_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_ternarylogic_epi64::<1>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[-60129542158, 0]).map_err(|e| format!("{e} | call: _mm_maskz_ternarylogic_epi64::<1>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_ternarylogic_epi64::<1>(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.5, 1.0, 1.25, 1.5, 1.75, 1.0, 1.125, 1.25, 1.375, 1.5, 1.625, 1.75, 1.875, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -1.5, 1.0, -1.25, 1.5, -1.75, 1.0, -1.0, 1.0, -1.5, 1.0, -1.25, 1.5, -1.75]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32])));
        check_float_array_equality(&result, &[1.5625, 1.5625, 1.171875, 1.5625, 1.953125, 1.171875, 1.3671875, 1.5625, 1.7578125, 1.953125, 1.0742188, 1.171875, 1.2695313, 1.3671875, 1.4648438, 1.5625]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getmant_ps::<0, 0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_ps::<0, 0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_ps::<0, 0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[1.0625, 2.0, 1.1875, 4.0, 1.3125, 6.0, 1.4375, 8.0, 1.5625, 10.0, 1.6875, 12.0, 1.8125, 14.0, 1.9375, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[1.25, -1.0, 1.5, -3.0, 1.75, -5.0, 1.0, -7.0, 1.25, -1.0, 1.5, -3.0, 1.75, -5.0, 1.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[1.71875, 200.0, 1.2109375, 400.0, 1.9921875, 600.0, 1.3867188, 800.0, 1.7773438, 1000.0, 1.0839844, 1200.0, 1.2792969, 1400.0, 1.4746094, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -1.0, 5.877472e-39, 1.0, -f32::INFINITY, -1.0, 5.877472e-39, 1.0, -f32::INFINITY, -1.0, 5.877472e-39, 1.0, -f32::INFINITY, -1.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_ps::<0, 0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_ps::<0, 0>(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.5, 0.0, 1.25, 0.0, 1.75, 0.0, 1.125, 0.0, 1.375, 0.0, 1.625, 0.0, 1.875, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.5, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.5, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32])));
        check_float_array_equality(&result, &[1.5625, 0.0, 1.171875, 0.0, 1.953125, 0.0, 1.3671875, 0.0, 1.7578125, 0.0, 1.0742188, 0.0, 1.2695313, 0.0, 1.4648438, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_ps::<0, 0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_ps::<0, 0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.5, 1.0, 1.25, 1.5, 1.75, 1.0]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -1.5, 1.0, -1.25, 1.5, -1.75]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[1.5625, 1.5625, 1.171875, 1.5625, 1.953125, 1.171875, 1.3671875, 1.5625]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999, -1.9999999]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999, 1.9999999]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getmant_ps::<0, 0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0]).map_err(|e| format!("{e} | call: _mm256_getmant_ps::<0, 0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_ps::<0, 0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.125, 2.0, 1.375, 4.0, 1.625, 6.0, 1.875, 8.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[1.25, -1.0, 1.5, -3.0, 1.75, -5.0, 1.0, -7.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[1.71875, 200.0, 1.2109375, 400.0, 1.9921875, 600.0, 1.3867188, 800.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -1.0, 5.877472e-39, 1.0, -f32::INFINITY, -1.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_ps::<0, 0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_ps::<0, 0>(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.5, 0.0, 1.25, 0.0, 1.75, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.5, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[1.5625, 0.0, 1.171875, 0.0, 1.953125, 0.0, 1.3671875, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0, -1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0, 1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.5, 1.0]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -1.5]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[1.5625, 1.5625, 1.171875, 1.5625]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -1.9999999, -1.9999999, -1.9999999]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 1.9999999, 1.9999999, 1.9999999]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getmant_ps::<0, 0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, -1.0, 1.0]).map_err(|e| format!("{e} | call: _mm_getmant_ps::<0, 0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_ps::<0, 0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.25, 2.0, 1.75, 4.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[1.25, -1.0, 1.5, -3.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[1.71875, 200.0, 1.2109375, 400.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, -3.4028235e38, -1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 3.4028235e38, 1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -1.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, -3.4028235e38, 1.9999999, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 3.4028235e38, -1.9999999, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_mask_getmant_ps::<0, 0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_ps::<0, 0>(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.5, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[1.5625, 0.0, 1.171875, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.9999999, 0.0, -1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.9999999, 0.0, 1.9999999, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_ps::<0, 0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_ps::<0, 0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.5, 1.0, 1.25, 1.5, 1.75, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -1.5, 1.0, -1.25, 1.5, -1.75]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[1.5625, 1.5625, 1.171875, 1.5625, 1.953125, 1.171875, 1.3671875, 1.5625]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_getmant_pd::<0, 0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0]).map_err(|e| format!("{e} | call: _mm512_getmant_pd::<0, 0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_getmant_pd::<0, 0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[1.125, 2.0, 1.375, 4.0, 1.625, 6.0, 1.875, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[1.25, -1.0, 1.5, -3.0, 1.75, -5.0, 1.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[1.71875, 200.0, 1.2109375, 400.0, 1.9921875, 600.0, 1.38671875, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.7976931348623157e308, -1.9999999999999998, -1.7976931348623157e308, -1.9999999999999998, -1.7976931348623157e308, -1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.7976931348623157e308, 1.9999999999999998, 1.7976931348623157e308, 1.9999999999999998, 1.7976931348623157e308, 1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY, -1.0, 1.1125369292536007e-308, 1.0, -f64::INFINITY, -1.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, -1.7976931348623157e308, 1.9999999999999998, -1.7976931348623157e308, 1.9999999999999998, -1.7976931348623157e308, 1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_getmant_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 1.7976931348623157e308, -1.9999999999999998, 1.7976931348623157e308, -1.9999999999999998, 1.7976931348623157e308, -1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_getmant_pd::<0, 0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_getmant_pd::<0, 0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.5, 0.0, 1.25, 0.0, 1.75, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.5, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[1.5625, 0.0, 1.171875, 0.0, 1.953125, 0.0, 1.3671875, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 0.0, -1.9999999999999998, 0.0, -1.9999999999999998, 0.0, -1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 0.0, 1.9999999999999998, 0.0, 1.9999999999999998, 0.0, 1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.5, 1.0]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -1.5]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[1.5625, 1.5625, 1.171875, 1.5625]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.9999999999999998, -1.9999999999999998, -1.9999999999999998]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.9999999999999998, 1.9999999999999998, 1.9999999999999998]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_getmant_pd::<0, 0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, -1.0, 1.0]).map_err(|e| format!("{e} | call: _mm256_getmant_pd::<0, 0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_getmant_pd::<0, 0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.25, 2.0, 1.75, 4.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[1.25, -1.0, 1.5, -3.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[1.71875, 200.0, 1.2109375, 400.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.7976931348623157e308, -1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.7976931348623157e308, 1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY, -1.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, -1.7976931348623157e308, 1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_getmant_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 1.7976931348623157e308, -1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm256_mask_getmant_pd::<0, 0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_getmant_pd::<0, 0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.5, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[1.5625, 0.0, 1.171875, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 0.0, -1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 0.0, 1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, -1.0, 0.0]).map_err(|e| format!("{e} | call: _mm256_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[1.5625, 1.5625]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.9999999999999998]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.9999999999999998]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_getmant_pd::<0, 0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_getmant_pd::<0, 0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_getmant_pd::<0, 0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.5, 2.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[1.25, -1.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[1.71875, 200.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_getmant_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_mask_getmant_pd::<0, 0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_getmant_pd::<0, 0>(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[1.5625, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.9999999999999998, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_getmant_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_maskz_getmant_pd::<0, 0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_getmant_pd::<0, 0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[18.0, 20.0, 22.0, 24.0, 26.0, 28.0, 30.0, 32.0, 34.0, 36.0, 38.0, 40.0, 42.0, 44.0, 46.0, 48.0]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[10.0, 8.0, 14.0, 4.0, 18.0, 0.0, 22.0, -4.0, 10.0, 8.0, 14.0, 4.0, 18.0, 0.0, 22.0, -4.0]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[210.0, 410.0, 610.0, 810.0, 1010.0, 1210.0, 1410.0, 1610.0, 1810.0, 2010.0, 2210.0, 2410.0, 2610.0, 2810.0, 3010.0, 3210.0]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 1.1754944e-38, f32::INFINITY, -f32::INFINITY, -0.0, 1.1754944e-38, f32::INFINITY, -f32::INFINITY, -0.0, 1.1754944e-38, f32::INFINITY, -f32::INFINITY, -0.0, 1.1754944e-38]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0])));
        check_float_array_equality(&result, &[50.0, 2.0, 54.0, 4.0, 58.0, 6.0, 62.0, 8.0, 66.0, 10.0, 70.0, 12.0, 74.0, 14.0, 78.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[30.0, -1.0, 34.0, -3.0, 38.0, -5.0, 42.0, -7.0, 30.0, -1.0, 34.0, -3.0, 38.0, -5.0, 42.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32])));
        check_float_array_equality(&result, &[230.0, 200.0, 630.0, 400.0, 1030.0, 600.0, 1430.0, 800.0, 1830.0, 1000.0, 2230.0, 1200.0, 2630.0, 1400.0, 3030.0, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -3.4028235e38, -f32::INFINITY, -3.4028235e38, -f32::INFINITY, -3.4028235e38, -f32::INFINITY, -3.4028235e38, -f32::INFINITY, -3.4028235e38, -f32::INFINITY, -3.4028235e38, -f32::INFINITY, -3.4028235e38, -f32::INFINITY, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[18.0, 0.0, 22.0, 0.0, 26.0, 0.0, 30.0, 0.0, 34.0, 0.0, 38.0, 0.0, 42.0, 0.0, 46.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[10.0, 0.0, 14.0, 0.0, 18.0, 0.0, 22.0, 0.0, 10.0, 0.0, 14.0, 0.0, 18.0, 0.0, 22.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[210.0, 0.0, 610.0, 0.0, 1010.0, 0.0, 1410.0, 0.0, 1810.0, 0.0, 2210.0, 0.0, 2610.0, 0.0, 3010.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0, f32::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[10.0, 12.0, 14.0, 16.0, 18.0, 20.0, 22.0, 24.0]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[10.0, 8.0, 14.0, 4.0, 18.0, 0.0, 22.0, -4.0]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[210.0, 410.0, 610.0, 810.0, 1010.0, 1210.0, 1410.0, 1610.0]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 2.2250738585072014e-308, f64::INFINITY, -f64::INFINITY, -0.0, 2.2250738585072014e-308]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_add_round_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_add_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[26.0, 2.0, 30.0, 4.0, 34.0, 6.0, 38.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64, 24.0f64, 15.0f64, 26.0f64, 13.0f64])));
        check_float_array_equality(&result, &[30.0, -1.0, 34.0, -3.0, 38.0, -5.0, 42.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64, 24.0f64, 15.0f64, 26.0f64, 13.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64, 520.0f64, 620.0f64, 720.0f64, 820.0f64])));
        check_float_array_equality(&result, &[230.0, 200.0, 630.0, 400.0, 1030.0, 600.0, 1430.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64, 520.0f64, 620.0f64, 720.0f64, 820.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -1.7976931348623157e308, -f64::INFINITY, -1.7976931348623157e308, -f64::INFINITY, -1.7976931348623157e308, -f64::INFINITY, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_add_round_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_add_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_add_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[10.0, 0.0, 14.0, 0.0, 18.0, 0.0, 22.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[10.0, 0.0, 14.0, 0.0, 18.0, 0.0, 22.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[210.0, 0.0, 610.0, 0.0, 1010.0, 0.0, 1410.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, -0.0, 0.0, f64::INFINITY, 0.0, -0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_add_round_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_add_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_add_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[-16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0, -16.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[-10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[-10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 0.0, 0.0, f32::NAN, f32::NAN, 0.0, 0.0, f32::NAN, f32::NAN, 0.0, 0.0, f32::NAN, f32::NAN, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0])));
        check_float_array_equality(&result, &[-16.0, 2.0, -16.0, 4.0, -16.0, 6.0, -16.0, 8.0, -16.0, 10.0, -16.0, 12.0, -16.0, 14.0, -16.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[-10.0, -1.0, -10.0, -3.0, -10.0, -5.0, -10.0, -7.0, -10.0, -1.0, -10.0, -3.0, -10.0, -5.0, -10.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32])));
        check_float_array_equality(&result, &[-10.0, 200.0, -10.0, 400.0, -10.0, 600.0, -10.0, 800.0, -10.0, 1000.0, -10.0, 1200.0, -10.0, 1400.0, -10.0, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, 0.0, 5.877472e-39, f32::NAN, -f32::INFINITY, 0.0, 5.877472e-39, f32::NAN, -f32::INFINITY, 0.0, 5.877472e-39, f32::NAN, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38, -3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[-16.0, 0.0, -16.0, 0.0, -16.0, 0.0, -16.0, 0.0, -16.0, 0.0, -16.0, 0.0, -16.0, 0.0, -16.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[-10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[-10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0, f32::NAN, 0.0, 0.0, 0.0, f32::NAN, 0.0, 0.0, 0.0, f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_ps::<8>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_ps::<8>(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[-8.0, -8.0, -8.0, -8.0, -8.0, -8.0, -8.0, -8.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[-10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[-10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0, -10.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, 0.0, 0.0, f64::NAN, f64::NAN, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_sub_round_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| format!("{e} | call: _mm512_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_sub_round_pd::<8>(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[-8.0, 2.0, -8.0, 4.0, -8.0, 6.0, -8.0, 8.0]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64, 24.0f64, 15.0f64, 26.0f64, 13.0f64])));
        check_float_array_equality(&result, &[-10.0, -1.0, -10.0, -3.0, -10.0, -5.0, -10.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64, 24.0f64, 15.0f64, 26.0f64, 13.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64, 520.0f64, 620.0f64, 720.0f64, 820.0f64])));
        check_float_array_equality(&result, &[-10.0, 200.0, -10.0, 400.0, -10.0, 600.0, -10.0, 800.0]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64, 520.0f64, 620.0f64, 720.0f64, 820.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY, 0.0, 1.1125369292536007e-308, f64::NAN, -f64::INFINITY, 0.0, 1.1125369292536007e-308]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_sub_round_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm512_mask_sub_round_pd::<8>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_sub_round_pd::<8>(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[-8.0, 0.0, -8.0, 0.0, -8.0, 0.0, -8.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[-10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[-10.0, 0.0, -10.0, 0.0, -10.0, 0.0, -10.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, 0.0, 0.0, f64::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_sub_round_pd_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0]).map_err(|e| format!("{e} | call: _mm512_maskz_sub_round_pd::<8>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_sub_round_pd::<8>(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[17.0, 36.0, 57.0, 80.0, 105.0, 132.0, 161.0, 192.0, 225.0, 260.0, 297.0, 336.0, 377.0, 420.0, 465.0, 512.0]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, -9.0, 24.0, -21.0, 56.0, -25.0, 96.0, -21.0, 0.0, -9.0, 24.0, -21.0, 56.0, -25.0, 96.0, -21.0]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[11000.0, 42000.0, 93000.0, 164000.0, 255000.0, 366000.0, 497000.0, 648000.0, 819000.0, 1010000.0, 1221000.0, 1452000.0, 1703000.0, 1974000.0, 2265000.0, 2576000.0]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, 0.0, 0.0, f32::INFINITY, f32::INFINITY, 0.0, 0.0, f32::INFINITY, f32::INFINITY, 0.0, 0.0, f32::INFINITY, f32::INFINITY, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| format!("{e} | call: _mm512_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_round_ps::<8>(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0])));
        check_float_array_equality(&result, &[561.0, 2.0, 665.0, 4.0, 777.0, 6.0, 897.0, 8.0, 1025.0, 10.0, 1161.0, 12.0, 1305.0, 14.0, 1457.0, 16.0]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[200.0, -1.0, 264.0, -3.0, 336.0, -5.0, 416.0, -7.0, 200.0, -1.0, 264.0, -3.0, 336.0, -5.0, 416.0, -7.0]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32])));
        check_float_array_equality(&result, &[13200.0, 200.0, 99200.0, 400.0, 265200.0, 600.0, 511200.0, 800.0, 837200.0, 1000.0, 1243200.0, 1200.0, 1729200.0, 1400.0, 2295200.0, 1600.0]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_round_ps_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm512_mask_mul_round_ps::<8>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_round_ps::<8>(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}
