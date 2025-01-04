mod clmul;
mod clmulh;
mod clmulr;
mod orc;
mod xperm4;
mod xperm8;

use crate::cpu::auto_generated::riscv64::zb::clmul::*;
use crate::cpu::auto_generated::riscv64::zb::clmulh::*;
use crate::cpu::auto_generated::riscv64::zb::clmulr::*;
use crate::cpu::auto_generated::riscv64::zb::orc::*;
use crate::cpu::auto_generated::riscv64::zb::xperm4::*;
use crate::cpu::auto_generated::riscv64::zb::xperm8::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ZB;

impl ExtensionTest for ZB {
    fn get_name() -> &'static str {
        "riscv64::ZB"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_riscv64_zb_xperm8_64, "test_riscv64_zb_xperm8_64"),
            (test_riscv64_zb_xperm4_64, "test_riscv64_zb_xperm4_64"),
            (test_riscv64_zb_orc_b_64, "test_riscv64_zb_orc_b_64"),
            (test_riscv64_zb_clmul_64, "test_riscv64_zb_clmul_64"),
            (test_riscv64_zb_clmulh_64, "test_riscv64_zb_clmulh_64"),
            (test_riscv64_zb_clmulr_64, "test_riscv64_zb_clmulr_64"),
        ]
    }
}
