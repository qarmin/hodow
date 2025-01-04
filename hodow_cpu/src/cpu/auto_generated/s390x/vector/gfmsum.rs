use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_gfmsum() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_gfmsum(0 /* T */, 0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_gfmsum(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_gfmsum_accum() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_gfmsum_accum(0 /* T */, 0 /* T */, 0 /* Result */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_gfmsum_accum(0 /* T */, 0 /* T */, 0 /* Result */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_gfmsum_128() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_gfmsum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_gfmsum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_gfmsum_accum_128() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_gfmsum_accum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_gfmsum_accum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
