#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_sse2_mm_loadu_si16() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack__m128i_to_i32_array(_mm_loadu_si16(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[257, 0, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_loadu_si32() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack__m128i_to_i32_array(_mm_loadu_si32(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[16843009, 0, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_loadu_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        let result = unpack__m128i_to_i32_array(_mm_loadu_si64(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[16843009, 16843009, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_shuffle_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_shuffle_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 3.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_shuffle_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_move_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_move_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_move_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_castpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castpd_ps(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, 1.875, 0.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castpd_ps(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_castpd_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castpd_si128(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_castps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.000000473111868, 512.0001225471497])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castps_pd(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_castps_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1065353216, 1073741824, 1077936128, 1082130432])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castps_si128(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_castsi128_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castsi128_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castsi128_pd(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_castsi128_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castsi128_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1e-45, 3e-45, 4e-45, 6e-45])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_castsi128_ps(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_undefined_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_undefined_pd());
        check_float_array_equality(&result, &[0.0f64; 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_undefined_pd();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_undefined_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_undefined_si128());
        check_array_equality(&result, &[0i32; 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_undefined_si128();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_unpackhi_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_unpackhi_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_unpackhi_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_unpacklo_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 3.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_unpacklo_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}
