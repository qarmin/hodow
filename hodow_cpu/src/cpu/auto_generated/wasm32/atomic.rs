use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_atomic_memory_atomic_wait32() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let expression = 2i32;
        let timeout_ns = 3i64;
        let ret_value = memory_atomic_wait32(ptr_ptr.0.as_mut_ptr(), expression, timeout_ns);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let out_ptr = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        let result = (ret_value, out_ptr);
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_atomic_memory_atomic_wait64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i64; 8]);
        let expression = 2i64;
        let timeout_ns = 3i64;
        let ret_value = memory_atomic_wait64(ptr_ptr.0.as_mut_ptr(), expression, timeout_ns);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let out_ptr = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i64; 8]>());
        let result = (ret_value, out_ptr);
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_atomic_memory_atomic_notify() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_ptr = crate::cpu::common::Aligned64([1i32; 16]);
        let waiters = 2u32;
        let ret_value = memory_atomic_notify(ptr_ptr.0.as_mut_ptr(), waiters);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let out_ptr = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[i32; 16]>());
        let result = (ret_value, out_ptr);
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ATOMIC;

impl ExtensionTest for ATOMIC {
    fn get_name() -> &'static str {
        "wasm32::ATOMIC"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_wasm32_atomic_memory_atomic_wait32, "test_wasm32_atomic_memory_atomic_wait32"),
            (test_wasm32_atomic_memory_atomic_wait64, "test_wasm32_atomic_memory_atomic_wait64"),
            (test_wasm32_atomic_memory_atomic_notify, "test_wasm32_atomic_memory_atomic_notify"),
        ]
    }
}
