use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_st_b() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* v16i8 */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        __msa_st_b::<0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_mips_msa_msa_st_h() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* v8i16 */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        __msa_st_h::<0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_mips_msa_msa_st_w() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* v4i32 */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        __msa_st_w::<0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_mips_msa_msa_st_d() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* v2i64 */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 64]);
        __msa_st_d::<0>(a, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
