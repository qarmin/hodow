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
fn test_aarch64_sve_svorn_b_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svorn_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svorn_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorn_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorn_b_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorn_b_z_impl() }
}
