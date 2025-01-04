use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqnegh_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqnegh_s16(1i16);
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqnegh_s16(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqnegh_s16(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}
