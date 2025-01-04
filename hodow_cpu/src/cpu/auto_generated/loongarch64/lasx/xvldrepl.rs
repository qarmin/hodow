use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvldrepl_b() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = core::hint::black_box(lasx_xvldrepl_b::<0>(ptr_mem_addr.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvldrepl_h() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = core::hint::black_box(lasx_xvldrepl_h::<0>(ptr_mem_addr.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvldrepl_w() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = core::hint::black_box(lasx_xvldrepl_w::<0>(ptr_mem_addr.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvldrepl_d() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = core::hint::black_box(lasx_xvldrepl_d::<0>(ptr_mem_addr.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}
