#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_kl_mm_loadiwkey() -> Result<(), String> {
    unsafe {
        _mm_loadiwkey(1u32, create__m128i_from_i32_array([2, 3, 4, 5]), create__m128i_from_i32_array([6, 7, 8, 9]), create__m128i_from_i32_array([10, 11, 12, 13]));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                _mm_loadiwkey(rand::random::<u32>(), create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_encodekey128_u32() -> Result<(), String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([2, 3, 4, 5]);
        let mut ptr_handle = crate::cpu::common::Aligned64([6u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_encodekey256_u32() -> Result<(), String> {
    unsafe {
        let key_params = 1u32;
        let key_lo = create__m128i_from_i32_array([2, 3, 4, 5]);
        let key_hi = create__m128i_from_i32_array([6, 7, 8, 9]);
        let mut ptr_handle = crate::cpu::common::Aligned64([10u8; 64]);
        let result = _mm_encodekey256_u32(key_params, key_lo, key_hi, ptr_handle.0.as_mut_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_encodekey256_u32(key_params, key_lo, key_hi, ptr_handle.0.as_mut_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([5, 6, 7, 8]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesdec128kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([5, 6, 7, 8]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesdec128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesdec128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesenc256kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([5, 6, 7, 8]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesenc256kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesenc256kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesdec256kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([5, 6, 7, 8]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesdec256kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesdec256kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesencwide128kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let ptr_input = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesencwide128kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesencwide128kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesdecwide128kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let ptr_input = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesdecwide128kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesdecwide128kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesencwide256kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let ptr_input = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesencwide256kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesencwide256kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_kl_mm_aesdecwide256kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let ptr_input = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesdecwide256kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr());
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_aesdecwide256kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr())"))?;
    }
    Ok(())
}
