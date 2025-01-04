use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_div_s_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_s_b(0 /* v16i8 */, 0 /* v16i8 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_s_b(0 /* v16i8 */, 0 /* v16i8 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_div_s_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_s_h(0 /* v8i16 */, 0 /* v8i16 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_s_h(0 /* v8i16 */, 0 /* v8i16 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_div_s_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_s_w(0 /* v4i32 */, 0 /* v4i32 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_s_w(0 /* v4i32 */, 0 /* v4i32 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_div_s_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_s_d(0 /* v2i64 */, 0 /* v2i64 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_s_d(0 /* v2i64 */, 0 /* v2i64 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_div_u_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_u_b(0 /* v16u8 */, 0 /* v16u8 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_u_b(0 /* v16u8 */, 0 /* v16u8 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_div_u_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_u_h(0 /* v8u16 */, 0 /* v8u16 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_u_h(0 /* v8u16 */, 0 /* v8u16 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_div_u_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_u_w(0 /* v4u32 */, 0 /* v4u32 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_u_w(0 /* v4u32 */, 0 /* v4u32 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_div_u_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_div_u_d(0 /* v2u64 */, 0 /* v2u64 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_div_u_d(0 /* v2u64 */, 0 /* v2u64 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
