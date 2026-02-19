use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_loadiwkey() -> Result<(), String> {
    unsafe {
        todo!("_mm_loadiwkey")
    }
    Ok(())
}

pub(super) fn test_mm_encodekey128_u32() -> Result<(), String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mut ptr_handle = [1u8; 1];
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.as_mut_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_mm_encodekey256_u32() -> Result<(), String> {
    unsafe {
        todo!("_mm_encodekey256_u32")
    }
    Ok(())
}

pub(super) fn test_mm_aesenc128kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let input = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_handle = [1u8; 1];
        let result = _mm_aesenc128kl_u8(ptr_output.as_mut_ptr(), input, ptr_handle.as_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_mm_aesdec128kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let input = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_handle = [1u8; 1];
        let result = _mm_aesdec128kl_u8(ptr_output.as_mut_ptr(), input, ptr_handle.as_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_mm_aesenc256kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let input = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_handle = [1u8; 1];
        let result = _mm_aesenc256kl_u8(ptr_output.as_mut_ptr(), input, ptr_handle.as_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_mm_aesdec256kl_u8() -> Result<(), String> {
    unsafe {
        let mut ptr_output = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let input = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_handle = [1u8; 1];
        let result = _mm_aesdec256kl_u8(ptr_output.as_mut_ptr(), input, ptr_handle.as_ptr());
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_mm_aesencwide128kl_u8() -> Result<(), String> {
    unsafe {
        todo!("_mm_aesencwide128kl_u8")
    }
    Ok(())
}

pub(super) fn test_mm_aesdecwide128kl_u8() -> Result<(), String> {
    unsafe {
        todo!("_mm_aesdecwide128kl_u8")
    }
    Ok(())
}

pub(super) fn test_mm_aesencwide256kl_u8() -> Result<(), String> {
    unsafe {
        todo!("_mm_aesencwide256kl_u8")
    }
    Ok(())
}

pub(super) fn test_mm_aesdecwide256kl_u8() -> Result<(), String> {
    unsafe {
        todo!("_mm_aesdecwide256kl_u8")
    }
    Ok(())
}
