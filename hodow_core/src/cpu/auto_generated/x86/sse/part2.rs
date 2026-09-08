#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_sse_mm_cvt_si2ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i32));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_si2ss_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i32));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_si2ss_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i32));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_si2ss_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i32));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_si2ss_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i32));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_si2ss_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i32));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_si2ss_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i32));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_si2ss_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i32));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cvt_si2ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sfence() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        _mm_sfence();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm_sfence();
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_prefetch() -> Result<(), String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_prefetch::<0>(ptr_p.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_prefetch_imm_0() -> Result<(), String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_prefetch::<0>(ptr_p.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_prefetch_imm_1() -> Result<(), String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_prefetch::<1>(ptr_p.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_stream_ps_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm_stream_ps(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}
