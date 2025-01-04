use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svpfalse_b_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svpfalse_b());
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svpfalse_b()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svpfalse_b();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svpfalse_b() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svpfalse_b_impl() }
}
