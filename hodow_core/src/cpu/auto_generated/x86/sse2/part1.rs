#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_sse2_mm_clflush() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1u8; 64]);
        _mm_clflush(ptr_p.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_lfence() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        _mm_lfence();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm_lfence();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_mfence() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        _mm_mfence();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm_mfence();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 12, 0, 21, 0, 32, 0]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-9, -1, 3, 0, 31, 0, 75, 0]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[-12536, 0, -5144, 3, 31176, 9, 30888, 17]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2, 32766, 2, 32766, 2, 32766, 2, 32766]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 0, 2, 0, 2, 0, 2, 0]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 1, 0, 1, 32767, 1, 0]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, -32767, 0, -32767, 0, -32767, 0, -32767]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_madd_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_madd_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32767, 0, -32767, 0, -32767, 0, -32767]).map_err(|e| format!("{e} | call: _mm_madd_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_madd_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[8, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)])));
        check_array_equality(&result, &[0, 4, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)])));
        check_array_equality(&result, &[80, 0, 0, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[248, 7, 0, 0, 0, 0, 0, 0, 248, 7, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sad_epu8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_sad_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[248, 7, 0, 0, 0, 0, 0, 0, 248, 7, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_sad_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sad_epu8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sll_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sll_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sll_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, -1024]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sll_epi64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_sll_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sll_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_sra_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_sra_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, 0, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sra_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_sra_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sra_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_srl_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_srl_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_srl_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, 18014398509481983]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_srl_epi64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2]).map_err(|e| format!("{e} | call: _mm_srl_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_srl_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_epi32(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm_cvtps_epi32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtps_epi32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128i_from_i32_array([5, 6, 7, 8]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([9i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([0, -1, 2, -3]);
        let mask = create__m128i_from_i32_array([10, 9, 12, 7]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([100, 200, 300, 400]);
        let mask = create__m128i_from_i32_array([110, 210, 310, 410]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mask = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let mask = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mask = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([5, 6, 7, 8]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([0, -1, 2, -3]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([100, 200, 300, 400]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si128_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        _mm_stream_si128(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_si32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = 2i32;
        _mm_stream_si32(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-256, -766, -1276, -1786, 2314, 1804, 1294, 784]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[32612, 32639, 32639, 32639, 32622, 32639, 32639, 32639]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32640, -32640, -32640, -32640, -32640, -32640, -32640, -32640]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32639, 32639, 32639, 32639, 32639, 32639, 32639, 32639]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[32640, -256, 32640, -256, 32640, -256, 32640, -256]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-32640, -32640, -32640, -32640, 32639, 32639, 32639, 32639]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[32639, 32639, 32639, 32639, -32640, -32640, -32640, -32640]).map_err(|e| format!("{e} | call: _mm_packs_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[-65536, -196606, 589834, 458764]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[13107300, 26214700, 13762670, 26870070]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147450880, -2147450880, -2147450880, -2147450880]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147450879, 2147450879, 2147450879, 2147450879]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147450880, -65536, 2147450880, -65536]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147450880, -2147450880, 2147450879, 2147450879]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packs_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packs_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[2147450879, 2147450879, -2147450880, -2147450880]).map_err(|e| format!("{e} | call: _mm_packs_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packs_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 4, 6, 2314, 1804, 1294, 784]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[-14236, -1, -1, -1, -11666, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0; 8]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-256, 0, -256, 0, -256, 0, -256, 0]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, -1, -1, -1, -1]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_packus_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, 9.0]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 210.0]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_max_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_min_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_min_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_min_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.7320508075688772, 2.0]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[3.1622776601683795, -1.0]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[10.488088481701515, 200.0]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.3407807929942596e154, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.3407807929942596e154, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 1.4142135623730951]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[10.0, 14.142135623730951]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.3407807929942596e154, 1.3407807929942596e154]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpeq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, 2.0]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, -1.0]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, 200.0]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmplt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, 2.0]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, -1.0]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, 200.0]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmple_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpgt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpunord_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpneq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnlt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnle_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpngt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, 2.0]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, -1.0]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, 200.0]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_sd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cmpnge_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpeq_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpeq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpeq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmplt_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmplt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmplt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmple_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmple_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmple_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpgt_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpgt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpgt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpge_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpord_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpunord_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpunord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpunord_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpneq_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpneq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnlt_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnlt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnle_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnle_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnle_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpngt_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpngt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpngt_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cmpnge_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmpnge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0; 2]).map_err(|e| format!("{e} | call: _mm_cmpnge_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}
