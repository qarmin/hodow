#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_sha1msg1_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[6, 10, 2, 6])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha1msg2_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[14, 14, 10, 6])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha1nexte_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1nexte_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 9])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha1rnds4_epu32() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1rnds4_epu32::<0>(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[-694116728, -1431015549, 884620151, 877299341])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha256msg1_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha256msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[67141633, 100712450, 134283267, 167854084])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha256msg2_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha256msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[221185, 327682, -603938596, 536953158])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha256rnds2_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha256rnds2_epu32(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[415236881, 1178701972, 419439380, 1689133364])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
