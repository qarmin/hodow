#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_bittest() -> Result<(), String> {
    unsafe {
        let ptr_p = [1i32; 1];
        let b = 2i32;
        let result = _bittest(ptr_p.as_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_bittestandset() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1i32; 1];
        let b = 2i32;
        let result = _bittestandset(ptr_p.as_mut_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_bittestandreset() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1i32; 1];
        let b = 2i32;
        let result = _bittestandreset(ptr_p.as_mut_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_bittestandcomplement() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1i32; 1];
        let b = 2i32;
        let result = _bittestandcomplement(ptr_p.as_mut_ptr(), b);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}
