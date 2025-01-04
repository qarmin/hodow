use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_ld_b() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = core::hint::black_box(__msa_ld_b::<0>(ptr_mem_addr.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_mips_msa_msa_ld_h() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = core::hint::black_box(__msa_ld_h::<0>(ptr_mem_addr.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_mips_msa_msa_ld_w() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = core::hint::black_box(__msa_ld_w::<0>(ptr_mem_addr.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_mips_msa_msa_ld_d() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = core::hint::black_box(__msa_ld_d::<0>(ptr_mem_addr.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
