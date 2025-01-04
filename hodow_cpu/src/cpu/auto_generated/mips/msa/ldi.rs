use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_ldi_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_ldi_b::<0>());

        crate::cpu::fuzz(&mut || {
            let _ = __msa_ldi_b::<0>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_ldi_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_ldi_h::<0>());

        crate::cpu::fuzz(&mut || {
            let _ = __msa_ldi_h::<0>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_ldi_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_ldi_w::<0>());

        crate::cpu::fuzz(&mut || {
            let _ = __msa_ldi_w::<0>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_ldi_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_ldi_d::<0>());

        crate::cpu::fuzz(&mut || {
            let _ = __msa_ldi_d::<0>();
        });
        Ok(Verdict::Unverified(None))
    }
}
