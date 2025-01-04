use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_jsconv_jcvt() -> Result<Verdict, String> {
    unsafe {
        let result = __jcvt(1.0f64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "__jcvt(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = __jcvt(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct JSCONV;

impl ExtensionTest for JSCONV {
    fn get_name() -> &'static str {
        "aarch64::JSCONV"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_jsconv_jcvt, "test_aarch64_jsconv_jcvt"),
        ]
    }
}
