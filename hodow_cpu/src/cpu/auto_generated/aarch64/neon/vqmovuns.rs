use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqmovuns_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqmovuns_s32(1i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqmovuns_s32(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqmovuns_s32(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
