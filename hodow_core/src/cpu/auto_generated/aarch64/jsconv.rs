mod part1;

use crate::cpu::auto_generated::aarch64::jsconv::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct JSCONV;

impl ExtensionTest for JSCONV {
    fn get_name() -> &'static str {
        "aarch64::JSCONV"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aarch64_jsconv_jcvt, "test_aarch64_jsconv_jcvt"),
        ]
    }
}
