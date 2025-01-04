use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_cfcmsa() -> Result<Verdict, String> {
    unsafe {
        let result = __msa_cfcmsa::<0>();

        crate::cpu::fuzz(&mut || {
            let _ = __msa_cfcmsa::<0>();
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
