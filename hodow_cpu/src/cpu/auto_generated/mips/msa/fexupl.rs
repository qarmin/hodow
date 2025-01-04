use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_fexupl_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_fexupl_d(0 /* v4f32 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_fexupl_d(0 /* v4f32 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
