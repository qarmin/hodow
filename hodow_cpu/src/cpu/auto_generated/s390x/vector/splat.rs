use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat::<0>(0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat::<0>(0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_s8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_s8::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_s8::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_s16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_s16::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_s16::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_s32() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_s32::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_s32::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_s64() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_s64::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_s64::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_u8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_u8::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_u8::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_u16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_u16::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_u16::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_u32() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_u32::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_u32::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_splat_u64() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_splat_u64::<42>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_splat_u64::<42>();
        });
        Ok(Verdict::Unverified(None))
    }
}
