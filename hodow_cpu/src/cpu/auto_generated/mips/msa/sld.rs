use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_sld_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_sld_b(0 /* v16i8 */, 0 /* v16i8 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_sld_b(0 /* v16i8 */, 0 /* v16i8 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_sld_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_sld_h(0 /* v8i16 */, 0 /* v8i16 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_sld_h(0 /* v8i16 */, 0 /* v8i16 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_sld_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_sld_w(0 /* v4i32 */, 0 /* v4i32 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_sld_w(0 /* v4i32 */, 0 /* v4i32 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_sld_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_sld_d(0 /* v2i64 */, 0 /* v2i64 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_sld_d(0 /* v2i64 */, 0 /* v2i64 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
