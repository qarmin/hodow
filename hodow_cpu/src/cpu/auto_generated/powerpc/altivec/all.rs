use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_all_eq() -> Result<Verdict, String> {
    unsafe {
        vec_all_eq(0 /* T */, 0 /* U */);

        crate::cpu::fuzz(&mut || {
            vec_all_eq(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_ge() -> Result<Verdict, String> {
    unsafe {
        vec_all_ge(0 /* T */, 0 /* U */);

        crate::cpu::fuzz(&mut || {
            vec_all_ge(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_gt() -> Result<Verdict, String> {
    unsafe {
        vec_all_gt(0 /* T */, 0 /* U */);

        crate::cpu::fuzz(&mut || {
            vec_all_gt(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_in() -> Result<Verdict, String> {
    unsafe {
        let result = vec_all_in(0 /* vector_float */, 0 /* vector_float */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_all_in(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_le() -> Result<Verdict, String> {
    unsafe {
        vec_all_le(0 /* U */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_all_le(0 /* U */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_lt() -> Result<Verdict, String> {
    unsafe {
        vec_all_lt(0 /* U */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_all_lt(0 /* U */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_nan() -> Result<Verdict, String> {
    unsafe {
        let result = vec_all_nan(0 /* vector_float */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_all_nan(0 /* vector_float */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_ne() -> Result<Verdict, String> {
    unsafe {
        vec_all_ne(0 /* T */, 0 /* U */);

        crate::cpu::fuzz(&mut || {
            vec_all_ne(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_nge() -> Result<Verdict, String> {
    unsafe {
        let result = vec_all_nge(0 /* vector_float */, 0 /* vector_float */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_all_nge(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_ngt() -> Result<Verdict, String> {
    unsafe {
        let result = vec_all_ngt(0 /* vector_float */, 0 /* vector_float */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_all_ngt(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_nle() -> Result<Verdict, String> {
    unsafe {
        let result = vec_all_nle(0 /* vector_float */, 0 /* vector_float */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_all_nle(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_nlt() -> Result<Verdict, String> {
    unsafe {
        let result = vec_all_nlt(0 /* vector_float */, 0 /* vector_float */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_all_nlt(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_powerpc_altivec_vec_all_numeric() -> Result<Verdict, String> {
    unsafe {
        let result = vec_all_numeric(0 /* vector_float */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_all_numeric(0 /* vector_float */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
