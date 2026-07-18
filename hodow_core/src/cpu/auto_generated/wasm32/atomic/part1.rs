use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_memory_atomic_wait32() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let expression = 2i32;
        let timeout_ns = 3i64;
        let result = memory_atomic_wait32(ptr_ptr.0.as_mut_ptr(), expression, timeout_ns);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_memory_atomic_wait64() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let expression = 2i64;
        let timeout_ns = 3i64;
        let result = memory_atomic_wait64(ptr_ptr.0.as_mut_ptr(), expression, timeout_ns);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_memory_atomic_notify() -> Result<(), String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let waiters = 2u32;
        let result = memory_atomic_notify(ptr_ptr.0.as_mut_ptr(), waiters);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}
