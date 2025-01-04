mod clmulh;
mod clmulr;
mod unzip;
mod xperm4;
mod xperm8;
mod zip;

use crate::cpu::auto_generated::riscv32::zb::clmulh::*;
use crate::cpu::auto_generated::riscv32::zb::clmulr::*;
use crate::cpu::auto_generated::riscv32::zb::unzip::*;
use crate::cpu::auto_generated::riscv32::zb::xperm4::*;
use crate::cpu::auto_generated::riscv32::zb::xperm8::*;
use crate::cpu::auto_generated::riscv32::zb::zip::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ZB;

impl ExtensionTest for ZB {
    fn get_name() -> &'static str {
        "riscv32::ZB"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_riscv32_zb_xperm8_32, "test_riscv32_zb_xperm8_32"),
            (test_riscv32_zb_xperm4_32, "test_riscv32_zb_xperm4_32"),
            (test_riscv32_zb_clmulh_32, "test_riscv32_zb_clmulh_32"),
            (test_riscv32_zb_clmulr_32, "test_riscv32_zb_clmulr_32"),
            (test_riscv32_zb_zip_32, "test_riscv32_zb_zip_32"),
            (test_riscv32_zb_unzip_32, "test_riscv32_zb_unzip_32"),
        ]
    }
}
