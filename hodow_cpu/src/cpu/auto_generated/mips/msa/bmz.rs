use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_bmz_v() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_bmz_v(0 /* v16u8 */, 0 /* v16u8 */, 0 /* v16u8 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_bmz_v(0 /* v16u8 */, 0 /* v16u8 */, 0 /* v16u8 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
