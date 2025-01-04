use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_ctcmsa() -> Result<Verdict, String> {
    unsafe {
        __msa_ctcmsa::<0>(1i32);

        crate::cpu::fuzz(&mut || {
            __msa_ctcmsa::<0>(rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
