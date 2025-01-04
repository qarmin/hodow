use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_any_nan() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_nan(0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_nan(0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_numeric() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_numeric(0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_numeric(0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_eq() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_eq(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_eq(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_ne() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_ne(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_ne(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_lt() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_lt(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_lt(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_le() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_le(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_le(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_gt() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_gt(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_gt(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_ge() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_ge(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_ge(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_nlt() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_nlt(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_nlt(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_nle() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_nle(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_nle(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_ngt() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_ngt(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_ngt(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_any_nge() -> Result<Verdict, String> {
    unsafe {
        let result = vec_any_nge(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_any_nge(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
