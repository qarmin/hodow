use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vsqaddh_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vsqaddh_u16(1u16, 2i16);
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vsqaddh_u16(1u16, 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsqaddh_u16(rand::random::<u16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}
