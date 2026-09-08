#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]));
        check_int_equality(result as i32, -286331154).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]));
        check_int_equality(result as i32, 572522496).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, -268374016).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]));
        check_int_equality(result as i32, 1145324612).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1431655765).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 1342197760).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 1431655765).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 1431655765).map_err(|e| format!("{e} | call: _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, -286331154).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]));
        check_int_equality(result as i32, 572522496).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, -268374016).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 1145324612).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result as i32, 1431655765).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 1342197760).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 1431655765).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 1431655765).map_err(|e| format!("{e} | call: _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 61166).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 61440).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 65535).map_err(|e| format!("{e} | call: _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 17476).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, 20480).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, 21845).map_err(|e| format!("{e} | call: _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
