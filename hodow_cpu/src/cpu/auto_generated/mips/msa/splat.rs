use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_splat_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_splat_b(0 /* v16i8 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_splat_b(0 /* v16i8 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_splat_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_splat_h(0 /* v8i16 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_splat_h(0 /* v8i16 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_splat_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_splat_w(0 /* v4i32 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_splat_w(0 /* v4i32 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_splat_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_splat_d(0 /* v2i64 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_splat_d(0 /* v2i64 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
