use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_cmpnrg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cmpnrg(0 /* T */, 0 /* T */, 0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cmpnrg(0 /* T */, 0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cmpnrg_idx() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cmpnrg_idx(0 /* T */, 0 /* T */, 0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cmpnrg_idx(0 /* T */, 0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cmpnrg_cc() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = core::hint::black_box(vec_cmpnrg_cc(a, b, c, ptr_d.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_d);
        let result = core::ptr::read(ptr_d.0.as_ptr().cast::<[i32; 16]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_cmpnrg_idx_cc() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = core::hint::black_box(vec_cmpnrg_idx_cc(a, b, c, ptr_d.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_d);
        let result = core::ptr::read(ptr_d.0.as_ptr().cast::<[i32; 16]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_s390x_vector_vec_cmpnrg_or_0_idx() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cmpnrg_or_0_idx(0 /* T */, 0 /* T */, 0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cmpnrg_or_0_idx(0 /* T */, 0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cmpnrg_or_0_idx_cc() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = core::hint::black_box(vec_cmpnrg_or_0_idx_cc(a, b, c, ptr_d.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_d);
        let result = core::ptr::read(ptr_d.0.as_ptr().cast::<[i32; 16]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
