#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_sse41_mm_blendv_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]), create__m128i_from_i8_array([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84])));
        check_array_equality(&result, &[100, -46, 44, -102, -12, 88, -58, 32, -114, -14, 76, -70, 20, -126, -26, 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_epi8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_blendv_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_epi8(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_imm_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<255>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_epi16_imm_alt() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<85>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_epi16::<85>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blendv_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blendv_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blendv_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blendv_ps(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_imm_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<3>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<3>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_pd_imm_alt() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_pd::<1>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_imm_0() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_imm_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<15>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<15>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_blend_ps_imm_alt() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<5>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_blend_ps::<5>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_extract_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1065353216)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extract_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_extract_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extract_epi8::<0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_extract_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_extract_epi32::<0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[5, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_insert_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[5, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, 120, -26, 74])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_max_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__m128i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 65535, 12, 65533, 14, 65531, 16, 65529])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 210, 310, 410, 510, 610, 710, 810])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_max_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 12, 7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 310, 410])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_max_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 4294967295, 12, 4294967293])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 310, 410])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295, 0, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_max_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_max_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, -126, -36, 64])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi8_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_min_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi8(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create__m128i_from_u16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 9, 2, 7, 4, 5, 6, 3])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_u16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_u16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create__m128i_from_u16_array([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu16_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u16_array(_mm_min_epu16(create__m128i_from_u16_array([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create__m128i_from_u16_array([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0; 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu16(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 2, -3])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 200, 300, 400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_min_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 9, 2, 7])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 200, 300, 400])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295, 0, 4294967295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_min_epu32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_min_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_packus_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_packus_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[131073, 262147, 393221, 524295])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_packus_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[-1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-1, -1])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cmpeq_epi64_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepi8_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepi8_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi8_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepi8_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepi8_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi8_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepi8_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepi8_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi8_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepi16_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepi16_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi16_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepi16_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepi16_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi16_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepi32_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepi32_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepu8_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepu8_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu8_epi16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepu8_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepu8_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu8_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepu8_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepu8_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu8_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepu16_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepu16_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu16_epi32(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepu16_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepu16_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu16_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtepu32_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtepu32_epi64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_dp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0f64; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_dp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0f32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_pd(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_floor_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_floor_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_floor_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_floor_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_pd(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_ceil_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_ceil_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_ceil_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ceil_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_pd::<8>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_pd::<8>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ps::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ps::<8>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_round_sd::<8>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_sd::<8>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_round_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_round_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_round_ss::<8>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_minpos_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_minpos_epu16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[65536, 0, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_minpos_epu16(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 21, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 0, 24, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[11000, 0, 93000, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 1073741824])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 1, 1073741823])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_asym_min_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -1073741824, -2147483648, -1073741824])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse41_mm_mul_epi32_asym_max_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mul_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -1073741824, -2147483648, -1073741824])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mul_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
