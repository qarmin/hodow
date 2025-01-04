use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqaddh_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqaddh_s16(1i16, 2i16);
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vqaddh_s16(1i16, 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqaddh_s16(rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqaddh_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vqaddh_u16(1u16, 2u16);
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vqaddh_u16(1u16, 2u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqaddh_u16(rand::random::<u16>(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}
