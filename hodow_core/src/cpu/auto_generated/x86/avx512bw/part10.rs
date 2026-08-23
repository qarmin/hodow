#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0, 21, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-9, -1, 0, 0, 31, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[-12536, 0, 0, 0, 31176, 9, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, 0, 0, -32768, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 0, 0, 2, 32766, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, 0, 0, 2, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, 0, 1, 32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, -32767, 0, 0, 0, -32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_madd_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32767, 0, 0, 0, -32767, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_madd_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 36, 0, 57, 0, 80, 0, 105, 0, 132, 0, 161, 0, 192, 0, 225, 0, 260, 0, 297, 0, 336, 0, 377, 0, 420, 0, 465, 0, 512, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2295, 24, 1771, 56, 1255, 96, 747, 0, 2295, 24, 1771, 56, 1255, 96, 747, 0, 2295, 24, 1771, 56, 1255, 96, 747, 0, 2295, 24, 1771, 56, 1255, 96, 747])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[11000, -9200, 2377, -14687, -487, 8628, -10900, 1353, -15039, -3239, 6552, -12304, 625, -15095, -5695, 4772, -13412, 193, 12793, -7855, 3288, -14224, 1584, 10257, -9719, 2100, -14740, -1340, 8017, -11287, 1208, -14960])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384, -16384])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874, 15874])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510, -510])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510, -16384, 15874, 0, -510])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256, 16256])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maddubs_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256, -16256])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maddubs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[561, 0, 612, 0, 665, 0, 720, 0, 777, 0, 836, 0, 897, 0, 960, 0, 1025, 0, 1092, 0, 1161, 0, 1232, 0, 1305, 0, 1380, 0, 1457, 0, 1536, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, -1, 264, -3, 336, -5, 416, -7, 200, -1, 264, -3, 336, -5, 416, -7, 200, -1, 264, -3, 336, -5, 416, -7, 200, -1, 264, -3, 336, -5, 416, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]), create__m512i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420, 2520, 2620, 2720, 2820, 2920, 3020, 3120, 3220])));
        check_array_equality(&result, &[13200, 200, 3457, 400, 2034, 600, -9500, 800, -14759, 1000, 8272, 1200, 1225, 1400, -3655, 1600, -12492, 1800, -15055, 2000, 4528, 2200, 177, 2400, -8159, 2600, -14300, 2800, 9897, 3000, 1968, 3200])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[255, -32768, 510, -32768, 765, -32768, 1020, -32768, 1275, -32768, 1530, -32768, 1785, -32768, 2040, -32768, 2295, -32768, 2550, -32768, 2805, -32768, 3060, -32768, 3315, -32768, 3570, -32768, 3825, -32768, 4080, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_maddubs_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_maddubs_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 36, 0, 57, 0, 80, 0, 105, 0, 132, 0, 161, 0, 192, 0, 225, 0, 260, 0, 297, 0, 336, 0, 377, 0, 420, 0, 465, 0, 512, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0, 0, 0, 24, 0, 56, 0, 96, 0, 0, 0, 24, 0, 56, 0, 96, 0, 0, 0, 24, 0, 56, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[11000, 0, 2377, 0, -487, 0, -10900, 0, -15039, 0, 6552, 0, 625, 0, -5695, 0, -13412, 0, 12793, 0, 3288, 0, 1584, 0, -9719, 0, -14740, 0, 8017, 0, 1208, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_maddubs_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_maddubs_epi16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[153, 0, 180, 0, 209, 0, 240, 0, 273, 0, 308, 0, 345, 0, 384, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, -1, 264, -3, 336, -5, 416, -7, 200, -1, 264, -3, 336, -5, 416, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m256i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[13200, 200, 3457, 400, 2034, 600, -9500, 800, -14759, 1000, 8272, 1200, 1225, 1400, -3655, 1600])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1, -510, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1, -16384, 32767, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[255, -32768, 510, -32768, 765, -32768, 1020, -32768, 1275, -32768, 1530, -32768, 1785, -32768, 2040, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_maddubs_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_maddubs_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 20, 0, 33, 0, 48, 0, 65, 0, 84, 0, 105, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0, 0, 0, 24, 0, 56, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[11000, 0, 2377, 0, -487, 0, -10900, 0, -15039, 0, 6552, 0, 625, 0, -5695, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0, -16384, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0, 15874, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0, -510, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0, -16384, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0, 16256, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_maddubs_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0, -16256, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_maddubs_epi16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 0, 60, 0, 77, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[200, -1, 264, -3, 336, -5, 416, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[13200, 200, 3457, 400, 2034, 600, -9500, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, -32768, -16384, -32768, -16384, -32768, -16384, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 32767, 15874, 32767, 15874, 32767, 15874, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, -1, -510, -1, -510, -1, -510, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 32767, 0, -1, -16384, 32767, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[255, -32768, 510, -32768, 765, -32768, 1020, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_maddubs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_maddubs_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 12, 0, 21, 0, 32, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, 0, 2377, 0, -487, 0, -10900, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, 0, -16384, 0, -16384, 0, -16384, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15874, 0, 15874, 0, 15874, 0, 15874, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-510, 0, -510, 0, -510, 0, -510, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 0, 0, 0, -16384, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[16256, 0, 16256, 0, 16256, 0, 16256, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_maddubs_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16256, 0, -16256, 0, -16256, 0, -16256, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_maddubs_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packs_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[131073, 262147, 1179665, 1310739, 393221, 524295, 1441813, 1572887, 655369, 786443, 1703961, 1835035, 917517, 1048591, 1966109, 2097183])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_packs_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packs_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[17, 19, 33, 35, 21, 23, 37, 39, 25, 27, 41, 43, 29, 31, 45, 47])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_packs_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packs_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 3, 17, 19, 5, 7, 21, 23, 9, 11, 25, 27, 13, 15, 29, 31])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_packs_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packs_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 11, 17, 19, 13, 15, 21, 23])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_packs_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packs_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 3, 9, 11, 5, 7, 13, 15])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_packs_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packs_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 7, 9, 11])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_packs_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packs_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 3, 5, 7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_packs_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packs_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[131073, 262147, 1179665, 1310739, 393221, 524295, 1441813, 1572887, 655369, 786443, 1703961, 1835035, 917517, 1048591, 1966109, 2097183])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_packs_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packs_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[1179665, 1310739, 2228257, 2359331, 1441813, 1572887, 2490405, 2621479, 1703961, 1835035, 2752553, 2883627, 1966109, 2097183, 3014701, 3145775])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_packs_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packs_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[131073, 262147, 1179665, 1310739, 393221, 524295, 1441813, 1572887, 655369, 786443, 1703961, 1835035, 917517, 1048591, 1966109, 2097183])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_packs_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[655369, 786443, 1179665, 1310739, 917517, 1048591, 1441813, 1572887])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_packs_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packs_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_packs_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[393221, 524295, 655369, 786443])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_packs_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packs_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_packs_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[131073, 262147, 1179665, 1310739, 393221, 524295, 1441813, 1572887, 655369, 786443, 1703961, 1835035, 917517, 1048591, 1966109, 2097183])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[17, 19, 33, 35, 21, 23, 37, 39, 25, 27, 41, 43, 29, 31, 45, 47])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 3, 17, 19, 5, 7, 21, 23, 9, 11, 25, 27, 13, 15, 29, 31])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 11, 17, 19, 13, 15, 21, 23])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 3, 9, 11, 5, 7, 13, 15])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 7, 9, 11])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 3, 5, 7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[131073, 262147, 1179665, 1310739, 393221, 524295, 1441813, 1572887, 655369, 786443, 1703961, 1835035, 917517, 1048591, 1966109, 2097183])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[1179665, 1310739, 2228257, 2359331, 1441813, 1572887, 2490405, 2621479, 1703961, 1835035, 2752553, 2883627, 1966109, 2097183, 3014701, 3145775])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[131073, 262147, 1179665, 1310739, 393221, 524295, 1441813, 1572887, 655369, 786443, 1703961, 1835035, 917517, 1048591, 1966109, 2097183])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[655369, 786443, 1179665, 1310739, 917517, 1048591, 1441813, 1572887])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[131073, 262147, 655369, 786443, 393221, 524295, 917517, 1048591])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[393221, 524295, 655369, 786443])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0, 17, 0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0, 24, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__m512i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 32772, 7, 32770, 9, 32768, 11, 32766, 5, 32772, 7, 32770, 9, 32768, 11, 32766, 5, 32772, 7, 32770, 9, 32768, 11, 32766, 5, 32772, 7, 32770, 9, 32768, 11, 32766])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[105, 205, 305, 405, 505, 605, 705, 805, 905, 1005, 1105, 1205, 1305, 1405, 1505, 1605, 1705, 1805, 1905, 2005, 2105, 2205, 2305, 2405, 2505, 2605, 2705, 2805, 2905, 3005, 3105, 3205])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m512i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_avg_epu16(create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768, 32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu16(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[25, 0, 26, 0, 27, 0, 28, 0, 29, 0, 30, 0, 31, 0, 32, 0, 33, 0, 34, 0, 35, 0, 36, 0, 37, 0, 38, 0, 39, 0, 40, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_u16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[15, 65535, 17, 65533, 19, 65531, 21, 65529, 15, 65535, 17, 65533, 19, 65531, 21, 65529, 15, 65535, 17, 65533, 19, 65531, 21, 65529, 15, 65535, 17, 65533, 19, 65531, 21, 65529])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]), create__m512i_from_u16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420, 2520, 2620, 2720, 2820, 2920, 3020, 3120, 3220])));
        check_array_equality(&result, &[115, 200, 315, 400, 515, 600, 715, 800, 915, 1000, 1115, 1200, 1315, 1400, 1515, 1600, 1715, 1800, 1915, 2000, 2115, 2200, 2315, 2400, 2515, 2600, 2715, 2800, 2915, 3000, 3115, 3200])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m512i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32768, 0, 32769, 0, 32769, 0, 32770, 0, 32770, 0, 32771, 0, 32771, 0, 32772, 0, 32772, 0, 32773, 0, 32773, 0, 32774, 0, 32774, 0, 32775, 0, 32775, 0, 32776, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_mask_avg_epu16(create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 65535, 1, 65535, 2, 65535, 2, 65535, 3, 65535, 3, 65535, 4, 65535, 4, 65535, 5, 65535, 5, 65535, 6, 65535, 6, 65535, 7, 65535, 7, 65535, 8, 65535, 8, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu16(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 0, 17, 0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0, 24, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__m512i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[105, 0, 305, 0, 505, 0, 705, 0, 905, 0, 1105, 0, 1305, 0, 1505, 0, 1705, 0, 1905, 0, 2105, 0, 2305, 0, 2505, 0, 2705, 0, 2905, 0, 3105, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m512i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u16_array(_mm512_maskz_avg_epu16(create__mmask32_from(0x55555555u32), create__m512i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m512i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu16(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[13, 0, 14, 0, 15, 0, 16, 0, 17, 0, 18, 0, 19, 0, 20, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_u16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[15, 65535, 17, 65533, 19, 65531, 21, 65529, 15, 65535, 17, 65533, 19, 65531, 21, 65529])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m256i_from_u16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[115, 200, 315, 400, 515, 600, 715, 800, 915, 1000, 1115, 1200, 1315, 1400, 1515, 1600])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m256i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[32768, 0, 32769, 0, 32769, 0, 32770, 0, 32770, 0, 32771, 0, 32771, 0, 32772, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_mask_avg_epu16(create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 65535, 1, 65535, 2, 65535, 2, 65535, 3, 65535, 3, 65535, 4, 65535, 4, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu16(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 11, 0, 12, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529, 0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__m256i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[105, 0, 305, 0, 505, 0, 705, 0, 905, 0, 1105, 0, 1305, 0, 1505, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m256i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u16_array(_mm256_maskz_avg_epu16(create__mmask16_from(0b0101010101010101), create__m256i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m256i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu16(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[7, 0, 8, 0, 9, 0, 10, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_u16_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[15, 65535, 17, 65533, 19, 65531, 21, 65529])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_u16_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[115, 200, 315, 400, 515, 600, 715, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[32768, 0, 32769, 0, 32769, 0, 32770, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_mask_avg_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 65535, 1, 65535, 2, 65535, 2, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu16(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[3, 0, 4, 0, 5, 0, 6, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__m128i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[105, 0, 305, 0, 505, 0, 705, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32768, 0, 32768, 0, 32768, 0, 32768, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_maskz_avg_epu16(create__mmask8_from(0b01010101), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[32768, 0, 32768, 0, 32768, 0, 32768, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[9, 0, 0, 0, 10, 0, 0, 0, 11, 0, 0, 0, 12, 0, 0, 0, 13, 0, 0, 0, 14, 0, 0, 0, 15, 0, 0, 0, 16, 0, 0, 0, 17, 0, 0, 0, 18, 0, 0, 0, 19, 0, 0, 0, 20, 0, 0, 0, 21, 0, 0, 0, 22, 0, 0, 0, 23, 0, 0, 0, 24, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m512i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 132, 7, 130, 9, 128, 11, 126, 5, 132, 7, 130, 9, 128, 11, 126, 5, 132, 7, 130, 9, 128, 11, 126, 5, 132, 7, 130, 9, 128, 11, 126, 5, 132, 7, 130, 9, 128, 11, 126, 5, 132, 7, 130, 9, 128, 11, 126, 5, 132, 7, 130, 9, 128, 11, 126, 5, 132, 7, 130, 9, 128, 11, 126])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0]), create__m512i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138, 238, 82, 182, 26, 126, 226, 70, 170, 14, 114, 214, 58, 158, 2, 102, 202, 46, 146, 246, 90, 190, 34, 134, 234, 78, 178, 22, 122, 222, 66, 166, 10])));
        check_array_equality(&result, &[105, 205, 49, 149, 249, 93, 193, 37, 137, 237, 81, 181, 25, 125, 225, 69, 169, 13, 113, 213, 57, 157, 129, 101, 201, 45, 145, 245, 89, 189, 33, 133, 233, 77, 177, 21, 121, 221, 65, 165, 9, 109, 209, 53, 153, 125, 97, 197, 41, 141, 241, 85, 185, 29, 129, 229, 73, 173, 17, 117, 217, 61, 161, 5])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_avg_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_avg_epu8(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_avg_epu8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[25, 0, 0, 0, 26, 0, 0, 0, 27, 0, 0, 0, 28, 0, 0, 0, 29, 0, 0, 0, 30, 0, 0, 0, 31, 0, 0, 0, 32, 0, 0, 0, 33, 0, 0, 0, 34, 0, 0, 0, 35, 0, 0, 0, 36, 0, 0, 0, 37, 0, 0, 0, 38, 0, 0, 0, 39, 0, 0, 0, 40, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_u8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138, 238, 82, 182, 26, 126, 226, 70, 170, 14, 114, 214, 58, 158, 2, 102, 202, 46, 146, 246, 90, 190, 34, 134, 234, 78, 178, 22, 122, 222, 66, 166, 10]), create__m512i_from_u8_array([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0, 100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20])));
        check_array_equality(&result, &[115, 200, 59, 144, 131, 88, 203, 32, 147, 232, 91, 176, 35, 120, 235, 64, 179, 8, 123, 208, 67, 152, 11, 96, 211, 40, 155, 240, 99, 184, 43, 128, 243, 72, 187, 16, 131, 216, 75, 160, 19, 104, 219, 48, 163, 248, 107, 192, 51, 136, 123, 80, 195, 24, 139, 224, 83, 168, 27, 112, 227, 56, 171, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[128, 0, 128, 0, 129, 0, 128, 0, 129, 0, 128, 0, 130, 0, 128, 0, 130, 0, 128, 0, 131, 0, 128, 0, 131, 0, 128, 0, 132, 0, 128, 0, 132, 0, 128, 0, 133, 0, 128, 0, 133, 0, 128, 0, 134, 0, 128, 0, 134, 0, 128, 0, 135, 0, 128, 0, 135, 0, 128, 0, 136, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_avg_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_avg_epu8(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 255, 0, 255, 1, 255, 0, 255, 2, 255, 0, 255, 2, 255, 0, 255, 3, 255, 0, 255, 3, 255, 0, 255, 4, 255, 0, 255, 4, 255, 0, 255, 5, 255, 0, 255, 5, 255, 0, 255, 6, 255, 0, 255, 6, 255, 0, 255, 7, 255, 0, 255, 7, 255, 0, 255, 8, 255, 0, 255, 8, 255, 0, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_avg_epu8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[9, 0, 0, 0, 10, 0, 0, 0, 11, 0, 0, 0, 12, 0, 0, 0, 13, 0, 0, 0, 14, 0, 0, 0, 15, 0, 0, 0, 16, 0, 0, 0, 17, 0, 0, 0, 18, 0, 0, 0, 19, 0, 0, 0, 20, 0, 0, 0, 21, 0, 0, 0, 22, 0, 0, 0, 23, 0, 0, 0, 24, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m512i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0]), create__m512i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138, 238, 82, 182, 26, 126, 226, 70, 170, 14, 114, 214, 58, 158, 2, 102, 202, 46, 146, 246, 90, 190, 34, 134, 234, 78, 178, 22, 122, 222, 66, 166, 10])));
        check_array_equality(&result, &[105, 0, 49, 0, 249, 0, 193, 0, 137, 0, 81, 0, 25, 0, 225, 0, 169, 0, 113, 0, 57, 0, 129, 0, 201, 0, 145, 0, 89, 0, 33, 0, 233, 0, 177, 0, 121, 0, 65, 0, 9, 0, 209, 0, 153, 0, 97, 0, 41, 0, 241, 0, 185, 0, 129, 0, 73, 0, 17, 0, 217, 0, 161, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0; 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_avg_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_avg_epu8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_avg_epu8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[13, 0, 0, 0, 14, 0, 0, 0, 15, 0, 0, 0, 16, 0, 0, 0, 17, 0, 0, 0, 18, 0, 0, 0, 19, 0, 0, 0, 20, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_u8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138]), create__m256i_from_u8_array([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148])));
        check_array_equality(&result, &[115, 200, 59, 144, 131, 88, 203, 32, 147, 232, 91, 176, 35, 120, 235, 64, 179, 8, 123, 208, 67, 152, 11, 96, 211, 40, 155, 240, 99, 184, 43, 128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[128, 0, 128, 0, 129, 0, 128, 0, 129, 0, 128, 0, 130, 0, 128, 0, 130, 0, 128, 0, 131, 0, 128, 0, 131, 0, 128, 0, 132, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_avg_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_avg_epu8(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 255, 0, 255, 1, 255, 0, 255, 2, 255, 0, 255, 2, 255, 0, 255, 3, 255, 0, 255, 3, 255, 0, 255, 4, 255, 0, 255, 4, 255, 0, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_avg_epu8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0, 9, 0, 0, 0, 10, 0, 0, 0, 11, 0, 0, 0, 12, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138])));
        check_array_equality(&result, &[105, 0, 49, 0, 249, 0, 193, 0, 137, 0, 81, 0, 25, 0, 225, 0, 169, 0, 113, 0, 57, 0, 129, 0, 201, 0, 145, 0, 89, 0, 33, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0; 32])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_avg_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_avg_epu8(create__mmask32_from(0x55555555u32), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_avg_epu8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[7, 0, 0, 0, 8, 0, 0, 0, 9, 0, 0, 0, 10, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]), create__m128i_from_i8_array([((20u8) as i8), ((19u8) as i8), ((22u8) as i8), ((17u8) as i8), ((24u8) as i8), ((15u8) as i8), ((26u8) as i8), ((13u8) as i8), ((20u8) as i8), ((19u8) as i8), ((22u8) as i8), ((17u8) as i8), ((24u8) as i8), ((15u8) as i8), ((26u8) as i8), ((13u8) as i8)])));
        check_array_equality(&result, &[15, 255, 17, 253, 19, 251, 21, 249, 15, 255, 17, 253, 19, 251, 21, 249])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]), create__m128i_from_i8_array([((120u8) as i8), ((220u8) as i8), ((64u8) as i8), ((164u8) as i8), ((8u8) as i8), ((108u8) as i8), ((208u8) as i8), ((52u8) as i8), ((152u8) as i8), ((252u8) as i8), ((96u8) as i8), ((196u8) as i8), ((40u8) as i8), ((140u8) as i8), ((240u8) as i8), ((84u8) as i8)])));
        check_array_equality(&result, &[115, 200, 59, 144, 131, 88, 203, 32, 147, 232, 91, 176, 35, 120, 235, 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[128, 0, 128, 0, 129, 0, 128, 0, 129, 0, 128, 0, 130, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_avg_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_avg_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 255, 0, 255, 1, 255, 0, 255, 2, 255, 0, 255, 2, 255, 0, 255])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_avg_epu8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)])));
        check_array_equality(&result, &[5, 0, 7, 0, 9, 0, 11, 0, 5, 0, 7, 0, 9, 0, 11, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)])));
        check_array_equality(&result, &[105, 0, 49, 0, 249, 0, 193, 0, 137, 0, 81, 0, 25, 0, 225, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_avg_epu8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_avg_epu8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
