use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_fill_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_fill_b(1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_fill_b(rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_fill_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_fill_h(1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_fill_h(rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_fill_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_fill_w(1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_fill_w(rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_fill_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_fill_d(1i64));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_fill_d(rand::random::<i64>());
        });
        Ok(Verdict::Unverified(None))
    }
}
