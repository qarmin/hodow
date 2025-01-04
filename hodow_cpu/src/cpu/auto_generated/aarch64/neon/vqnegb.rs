use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqnegb_s8() -> Result<Verdict, String> {
    unsafe {
        let result = vqnegb_s8(1i8);
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqnegb_s8(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqnegb_s8(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}
