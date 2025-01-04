use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvstelm_b() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_b::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvstelm_h() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_h::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvstelm_w() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_w::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvstelm_d() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_d::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
