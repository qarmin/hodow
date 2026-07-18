use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_bittest64() -> Result<(), String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i64; 8]);
        let b = 2i64;
        let result = _bittest64(ptr_p.0.as_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_bittestandset64() -> Result<(), String> {
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1i64; 8]);
        let b = 2i64;
        let result = _bittestandset64(ptr_p.0.as_mut_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_bittestandreset64() -> Result<(), String> {
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1i64; 8]);
        let b = 2i64;
        let result = _bittestandreset64(ptr_p.0.as_mut_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_bittestandcomplement64() -> Result<(), String> {
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1i64; 8]);
        let b = 2i64;
        let result = _bittestandcomplement64(ptr_p.0.as_mut_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}
