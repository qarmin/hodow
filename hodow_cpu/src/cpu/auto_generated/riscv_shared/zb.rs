mod clmul;
mod clmulh;
mod clmulr;
mod orc;

use crate::cpu::auto_generated::riscv_shared::zb::clmul::*;
use crate::cpu::auto_generated::riscv_shared::zb::clmulh::*;
use crate::cpu::auto_generated::riscv_shared::zb::clmulr::*;
use crate::cpu::auto_generated::riscv_shared::zb::orc::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ZB;

impl ExtensionTest for ZB {
    fn get_name() -> &'static str {
        "riscv_shared::ZB"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_riscv_shared_zb_orc_b, "test_riscv_shared_zb_orc_b"),
            (test_riscv_shared_zb_clmul, "test_riscv_shared_zb_clmul"),
            (test_riscv_shared_zb_clmulh, "test_riscv_shared_zb_clmulh"),
            (test_riscv_shared_zb_clmulr, "test_riscv_shared_zb_clmulr"),
        ]
    }
}
