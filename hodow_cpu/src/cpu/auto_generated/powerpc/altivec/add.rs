use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_add_bc_sc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_bc_sc(0 /* vector_bool_char */, 0 /* vector_signed_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_bc_sc(0 /* vector_bool_char */, 0 /* vector_signed_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_sc_sc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_sc_sc(0 /* vector_signed_char */, 0 /* vector_signed_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_sc_sc(0 /* vector_signed_char */, 0 /* vector_signed_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_bc_uc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_bc_uc(0 /* vector_bool_char */, 0 /* vector_unsigned_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_bc_uc(0 /* vector_bool_char */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_uc_uc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_uc_uc(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_uc_uc(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_bs_ss() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_bs_ss(0 /* vector_bool_short */, 0 /* vector_signed_short */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_bs_ss(0 /* vector_bool_short */, 0 /* vector_signed_short */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_ss_ss() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_ss_ss(0 /* vector_signed_short */, 0 /* vector_signed_short */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_ss_ss(0 /* vector_signed_short */, 0 /* vector_signed_short */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_bs_us() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_bs_us(0 /* vector_bool_short */, 0 /* vector_unsigned_short */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_bs_us(0 /* vector_bool_short */, 0 /* vector_unsigned_short */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_us_us() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_us_us(0 /* vector_unsigned_short */, 0 /* vector_unsigned_short */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_us_us(0 /* vector_unsigned_short */, 0 /* vector_unsigned_short */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_bi_si() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_bi_si(0 /* vector_bool_int */, 0 /* vector_signed_int */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_bi_si(0 /* vector_bool_int */, 0 /* vector_signed_int */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_si_si() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_si_si(0 /* vector_signed_int */, 0 /* vector_signed_int */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_si_si(0 /* vector_signed_int */, 0 /* vector_signed_int */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_bi_ui() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_bi_ui(0 /* vector_bool_int */, 0 /* vector_unsigned_int */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_bi_ui(0 /* vector_bool_int */, 0 /* vector_unsigned_int */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_ui_ui() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_ui_ui(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_ui_ui(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add_float_float() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_add_float_float(0 /* vector_float */, 0 /* vector_float */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_add_float_float(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_powerpc_altivec_vec_add() -> Result<Verdict, String> {
    unsafe {
        vec_add(0 /* T */, 0 /* U */);

        crate::cpu::fuzz(&mut || {
            vec_add(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}
