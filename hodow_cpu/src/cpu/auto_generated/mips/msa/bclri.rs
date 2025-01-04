use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_mips_msa_msa_bclri_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_bclri_b::<0>(0 /* v16u8 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_bclri_b::<0>(0 /* v16u8 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_bclri_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_bclri_h::<0>(0 /* v8u16 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_bclri_h::<0>(0 /* v8u16 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_bclri_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_bclri_w::<0>(0 /* v4u32 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_bclri_w::<0>(0 /* v4u32 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_mips_msa_msa_bclri_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(__msa_bclri_d::<0>(0 /* v2u64 */));

        crate::cpu::fuzz(&mut || {
            let _ = __msa_bclri_d::<0>(0 /* v2u64 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
