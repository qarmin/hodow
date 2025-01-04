use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqsubb_s8() -> Result<Verdict, String> {
    unsafe {
        let result = vqsubb_s8(1i8, 2i8);
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqsubb_s8(1i8, 2i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqsubb_s8(rand::random::<i8>(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqsubb_u8() -> Result<Verdict, String> {
    unsafe {
        let result = vqsubb_u8(1u8, 2u8);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqsubb_u8(1u8, 2u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqsubb_u8(rand::random::<u8>(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}
