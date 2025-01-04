use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_move_v() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_move_v(0 /* v16i8 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_move_v(0 /* v16i8 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
