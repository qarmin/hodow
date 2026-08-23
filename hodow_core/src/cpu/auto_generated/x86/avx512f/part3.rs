#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512f_mm512_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 57, 0, 105, 0, 161, 0, 225, 0, 297, 0, 377, 0, 465, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0, 0, 0, 24, 0, 56, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, 0, 93000, 0, 255000, 0, 497000, 0, 819000, 0, 1221000, 0, 1703000, 0, 2265000, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 1, 1073741823, 1, 1073741823, 1, 1073741823, 1, 1073741823, 1, 1073741823, 1, 1073741823, 1, 1073741823])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, 0, 0, 1073741824, 0, 0, 0, 1073741824, 0, 0, 0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mul_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[561, 0, 3, 4, 777, 0, 7, 8, 1025, 0, 11, 12, 1305, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, 0, 2, -3, 336, 0, 6, -7, 200, 0, 2, -3, 336, 0, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[13200, 0, 300, 400, 265200, 0, 700, 800, 837200, 0, 1100, 1200, 1729200, 0, 1500, 1600])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, -2147483648, -2147483648, 0, 1073741824, -2147483648, -2147483648, 0, 1073741824, -2147483648, -2147483648, 0, 1073741824, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 2147483647, 2147483647, 1, 1073741823, 2147483647, 2147483647, 1, 1073741823, 2147483647, 2147483647, 1, 1073741823, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, -1, -1, 1, 0, -1, -1, 1, 0, -1, -1, 1, 0, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, -1, 0, 1073741824, 0, -1, 0, 1073741824, 0, -1, 0, 1073741824, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483647, 0, -2147483648, -2147483648, 2147483643, 2, -2147483648, -2147483648, 2147483639, 4, -2147483648, -2147483648, 2147483635, 6, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mul_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483648, -1, 2147483647, 2147483647, -2147483648, -3, 2147483647, 2147483647, -2147483648, -5, 2147483647, 2147483647, -2147483648, -7, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epi32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 0, 0, 105, 0, 0, 0, 225, 0, 0, 0, 377, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, 56, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, 0, 0, 0, 255000, 0, 0, 0, 819000, 0, 0, 0, 1703000, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 0, 0, 1073741824, 0, 0, 0, 1073741824, 0, 0, 0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 0, 0, 1, 1073741823, 0, 0, 1, 1073741823, 0, 0, 1, 1073741823, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, 0, 0, 1073741824, 0, 0, 0, 1073741824, 0, 0, 0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epi32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[153, 0, 3, 4, 273, 0, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, 0, 2, -3, 336, 0, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[13200, 0, 300, 400, 265200, 0, 700, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, -2147483648, -2147483648, 0, 1073741824, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 2147483647, 2147483647, 1, 1073741823, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, -1, -1, 1, 0, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, -1, 0, 1073741824, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2147483647, 0, -2147483648, -2147483648, 2147483643, 2, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mul_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483648, -1, 2147483647, 2147483647, -2147483648, -3, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 0, 0, 65, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 56, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, 0, 0, 0, 255000, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 0, 0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 0, 0, 1, 1073741823, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, 0, 0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -1073741824, 0, 0, -2147483648, -1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 0, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[200, 0, 2, -3])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[13200, 0, 300, 400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[2147483647, 0, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mul_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483648, -1, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[11000, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mul_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 36, 57, 80, 105, 132, 161, 192, 225, 260, 297, 336, 377, 420, 465, 512])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -9, 24, -21, 56, -25, 96, -21, 0, -9, 24, -21, 56, -25, 96, -21])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, 42000, 93000, 164000, 255000, 366000, 497000, 648000, 819000, 1010000, 1221000, 1452000, 1703000, 1974000, 2265000, 2576000])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullo_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mullo_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullo_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[561, 2, 665, 4, 777, 6, 897, 8, 1025, 10, 1161, 12, 1305, 14, 1457, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, -1, 264, -3, 336, -5, 416, -7, 200, -1, 264, -3, 336, -5, 416, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[13200, 200, 99200, 400, 265200, 600, 511200, 800, 837200, 1000, 1243200, 1200, 1729200, 1400, 2295200, 1600])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1, 0, 2147483647, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483647, -2147483648, 2147483645, -2147483648, 2147483643, -2147483648, 2147483641, -2147483648, 2147483639, -2147483648, 2147483637, -2147483648, 2147483635, -2147483648, 2147483633, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullo_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mullo_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullo_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 57, 0, 105, 0, 161, 0, 225, 0, 297, 0, 377, 0, 465, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0, 0, 0, 24, 0, 56, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, 0, 93000, 0, 255000, 0, 497000, 0, 819000, 0, 1221000, 0, 1703000, 0, 2265000, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mullo_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mullo_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mullo_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[153, 2, 209, 4, 273, 6, 345, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, -1, 264, -3, 336, -5, 416, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[13200, 200, 99200, 400, 265200, 600, 511200, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1, 0, 2147483647, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2147483647, -2147483648, 2147483645, -2147483648, 2147483643, -2147483648, 2147483641, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mullo_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mullo_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647, -2147483648, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mullo_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 33, 0, 65, 0, 105, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, 0, 93000, 0, 255000, 0, 497000, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mullo_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mullo_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 2, 77, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[200, -1, 264, -3])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[13200, 200, 99200, 400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, -1, 1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[2147483647, -2147483648, 2147483645, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mullo_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mullo_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147483648, 2147483647, -2147483648, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mullo_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 21, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 0, 24, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[11000, 0, 93000, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mullo_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mullo_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mullo_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[223338299409, 584115552313, 1013612281961, 1511828488353, 2078764171489, 2714419331369, 3418793967993, 4191888081361])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -9, 24, -21, 56, -25, 96, -21])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, 42000, 93000, 164000, 255000, 366000, 497000, 648000])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1, 0, 1, 0, 1, 0, 1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mullox_epi64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mullox_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mullox_epi64(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[5033701671473, 17179869187, 6923487281929, 34359738375, 9088150799361, 51539607563, 11527692223769, 68719476751])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, -1, 264, -3, 336, -5, 416, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[13200, 200, 99200, 400, 265200, 600, 511200, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1, 0, 9223372036854775807, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9223372028264841215, -9223372036854775808, 9223372011084972027, -9223372036854775808, 9223371993905102839, -9223372036854775808, 9223371976725233651, -9223372036854775808])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mullox_epi64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_mullox_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mullox_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 57, 0, 105, 0, 161, 0, 225, 0, 297, 0, 377, 0, 465, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__m512i_from_u32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0, 0, 0, 24, 0, 56, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_u32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, 0, 93000, 0, 255000, 0, 497000, 0, 819000, 0, 1221000, 0, 1703000, 0, 2265000, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mul_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_epu32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[561, 0, 3, 4, 777, 0, 7, 8, 1025, 0, 11, 12, 1305, 0, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_u32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, 0, 2, 4294967293, 336, 0, 6, 4294967289, 200, 0, 2, 4294967293, 336, 0, 6, 4294967289])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_u32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[13200, 0, 300, 400, 265200, 0, 700, 800, 837200, 0, 1100, 1200, 1729200, 0, 1500, 1600])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 4294967295, 0, 0, 0, 4294967295, 0, 0, 0, 4294967295, 0, 0, 0, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967295, 0, 0, 0, 4294967291, 4, 0, 0, 4294967287, 8, 0, 0, 4294967283, 12, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_mask_mul_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 4294967295, 4294967295, 0, 0, 4294967295, 4294967295, 0, 0, 4294967295, 4294967295, 0, 0, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_epu32(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 0, 0, 105, 0, 0, 0, 225, 0, 0, 0, 377, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__m512i_from_u32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, 56, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_u32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, 0, 0, 0, 255000, 0, 0, 0, 819000, 0, 0, 0, 1703000, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 0, 0, 1, 4294967294, 0, 0, 1, 4294967294, 0, 0, 1, 4294967294, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 0, 0, 1, 4294967294, 0, 0, 1, 4294967294, 0, 0, 1, 4294967294, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u32_array(_mm512_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_epu32(create_random__mmask8(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[153, 0, 3, 4, 273, 0, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_u32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, 0, 2, 4294967293, 336, 0, 6, 4294967289])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_u32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[13200, 0, 300, 400, 265200, 0, 700, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 4294967295, 4294967295, 1, 4294967294, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 4294967295, 0, 0, 0, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[4294967295, 0, 0, 0, 4294967291, 4, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mask_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 4294967295, 4294967295, 0, 0, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_epu32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 0, 0, 65, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__m256i_from_u32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 56, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_u32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, 0, 0, 0, 255000, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 0, 0, 1, 4294967294, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 0, 0, 1, 4294967294, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_epu32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 0, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([10, 9, 12, 7]), create__m128i_from_u32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[200, 0, 2, 4294967293])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([110, 210, 310, 410]), create__m128i_from_u32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[13200, 0, 300, 400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_mask_mul_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_epu32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[11000, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_maskz_mul_epu32(create__mmask8_from(0b01010101), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_epu32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[17.0, 36.0, 57.0, 80.0, 105.0, 132.0, 161.0, 192.0, 225.0, 260.0, 297.0, 336.0, 377.0, 420.0, 465.0, 512.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, -9.0, 24.0, -21.0, 56.0, -25.0, 96.0, -21.0, 0.0, -9.0, 24.0, -21.0, 56.0, -25.0, 96.0, -21.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[11000.0, 42000.0, 93000.0, 164000.0, 255000.0, 366000.0, 497000.0, 648000.0, 819000.0, 1010000.0, 1221000.0, 1452000.0, 1703000.0, 1974000.0, 2265000.0, 2576000.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, 0.0, 0.0, f32::INFINITY, f32::INFINITY, 0.0, 0.0, f32::INFINITY, f32::INFINITY, 0.0, 0.0, f32::INFINITY, f32::INFINITY, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mul_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0])));
        check_float_array_equality(&result, &[561.0, 2.0, 665.0, 4.0, 777.0, 6.0, 897.0, 8.0, 1025.0, 10.0, 1161.0, 12.0, 1305.0, 14.0, 1457.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m512_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32, 20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[200.0, -1.0, 264.0, -3.0, 336.0, -5.0, 416.0, -7.0, 200.0, -1.0, 264.0, -3.0, 336.0, -5.0, 416.0, -7.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]), create__m512_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32, 920.0f32, 1020.0f32, 1120.0f32, 1220.0f32, 1320.0f32, 1420.0f32, 1520.0f32, 1620.0f32])));
        check_float_array_equality(&result, &[13200.0, 200.0, 99200.0, 400.0, 265200.0, 600.0, 511200.0, 800.0, 837200.0, 1000.0, 1243200.0, 1200.0, 1729200.0, 1400.0, 2295200.0, 1600.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_mul_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[17.0, 0.0, 57.0, 0.0, 105.0, 0.0, 161.0, 0.0, 225.0, 0.0, 297.0, 0.0, 377.0, 0.0, 465.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 24.0, 0.0, 56.0, 0.0, 96.0, 0.0, 0.0, 0.0, 24.0, 0.0, 56.0, 0.0, 96.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_float_array_equality(&result, &[11000.0, 0.0, 93000.0, 0.0, 255000.0, 0.0, 497000.0, 0.0, 819000.0, 0.0, 1221000.0, 0.0, 1703000.0, 0.0, 2265000.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[153.0, 2.0, 209.0, 4.0, 273.0, 6.0, 345.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[200.0, -1.0, 264.0, -3.0, 336.0, -5.0, 416.0, -7.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[13200.0, 200.0, 99200.0, 400.0, 265200.0, 600.0, 511200.0, 800.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_mul_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38, -f32::INFINITY, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 0.0, 33.0, 0.0, 65.0, 0.0, 105.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 24.0, 0.0, 56.0, 0.0, 96.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[11000.0, 0.0, 93000.0, 0.0, 255000.0, 0.0, 497000.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0, f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_mul_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0, -f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[45.0, 2.0, 77.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[200.0, -1.0, 264.0, -3.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[13200.0, 200.0, 99200.0, 400.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, -3.4028235e38, f32::INFINITY, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 3.4028235e38, f32::INFINITY, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, f32::INFINITY, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_mul_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, -f32::INFINITY, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 0.0, 21.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 24.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[11000.0, 0.0, 93000.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_mul_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 20.0, 33.0, 48.0, 65.0, 84.0, 105.0, 128.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[0.0, -9.0, 24.0, -21.0, 56.0, -25.0, 96.0, -21.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[11000.0, 42000.0, 93000.0, 164000.0, 255000.0, 366000.0, 497000.0, 648000.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, 0.0, 0.0, f64::INFINITY, f64::INFINITY, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mul_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mul_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mul_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[153.0, 2.0, 209.0, 4.0, 273.0, 6.0, 345.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]), create__m512d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64, 24.0f64, 15.0f64, 26.0f64, 13.0f64])));
        check_float_array_equality(&result, &[200.0, -1.0, 264.0, -3.0, 336.0, -5.0, 416.0, -7.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]), create__m512d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64, 520.0f64, 620.0f64, 720.0f64, 820.0f64])));
        check_float_array_equality(&result, &[13200.0, 200.0, 99200.0, 400.0, 265200.0, 600.0, 511200.0, 800.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, 0.0, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, 0.0, 1.1125369292536007e-308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_mul_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_mul_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_mul_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 0.0, 33.0, 0.0, 65.0, 0.0, 105.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 24.0, 0.0, 56.0, 0.0, 96.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[11000.0, 0.0, 93000.0, 0.0, 255000.0, 0.0, 497000.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, 0.0, 0.0, f64::INFINITY, 0.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_mul_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0, -f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_mul_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[45.0, 2.0, 77.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[200.0, -1.0, 264.0, -3.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[13200.0, 200.0, 99200.0, 400.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308, f64::INFINITY, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, 0.0, 1.1125369292536007e-308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, f64::INFINITY, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_mul_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_mul_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -f64::INFINITY, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_mul_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 0.0, 21.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 24.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[11000.0, 0.0, 93000.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, 0.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_mul_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_mul_pd(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0, -f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_mul_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[15.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[200.0, -1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[13200.0, 200.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_mul_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_mul_pd(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_mul_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[11000.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_mul_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_mul_pd(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_mul_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_div_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[0.05882353, 0.11111111, 0.15789473, 0.2, 0.23809524, 0.27272728, 0.3043478, 0.33333334, 0.36, 0.3846154, 0.4074074, 0.42857143, 0.44827586, 0.46666667, 0.48387095, 0.5])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_div_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_div_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0])));
        check_float_array_equality(&result, &[0.5151515, 2.0, 0.54285717, 4.0, 0.5675676, 6.0, 0.5897436, 8.0, 0.6097561, 10.0, 0.627907, 12.0, 0.64444447, 14.0, 0.65957445, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_div_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_div_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_float_array_equality(&result, &[0.05882353, 0.0, 0.15789473, 0.0, 0.23809524, 0.0, 0.3043478, 0.0, 0.36, 0.0, 0.4074074, 0.0, 0.44827586, 0.0, 0.48387095, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_div_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_div_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[0.5294118, 2.0, 0.57894737, 4.0, 0.61904764, 6.0, 0.65217394, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_div_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_div_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.11111111, 0.0, 0.27272728, 0.0, 0.3846154, 0.0, 0.46666667, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_div_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_div_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[0.5555556, 2.0, 0.6363636, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_div_ps(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_maskz_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_div_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.2, 0.0, 0.42857143, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_div_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_div_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_div_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.1111111111111111, 0.2, 0.2727272727272727, 0.3333333333333333, 0.38461538461538464, 0.42857142857142855, 0.4666666666666667, 0.5])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_div_pd(create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_mask_div_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_div_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[0.5294117647058824, 2.0, 0.5789473684210527, 4.0, 0.6190476190476191, 6.0, 0.6521739130434783, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_div_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm512_maskz_div_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_div_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[0.1111111111111111, 0.0, 0.2727272727272727, 0.0, 0.38461538461538464, 0.0, 0.4666666666666667, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_div_pd(create_random__mmask8(), create_random__m512d(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_mask_div_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_div_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[0.5555555555555556, 2.0, 0.6363636363636364, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_div_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm256_maskz_div_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_div_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.2, 0.0, 0.42857142857142855, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_div_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512f_mm_mask_div_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_div_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[0.6, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_div_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}
