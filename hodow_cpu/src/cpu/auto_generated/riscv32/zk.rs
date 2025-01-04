mod aes32dsi;
mod aes32dsmi;
mod aes32esi;
mod aes32esmi;
mod sha512sig0h;
mod sha512sig0l;
mod sha512sig1h;
mod sha512sig1l;
mod sha512sum0r;
mod sha512sum1r;

use crate::cpu::auto_generated::riscv32::zk::aes32dsi::*;
use crate::cpu::auto_generated::riscv32::zk::aes32dsmi::*;
use crate::cpu::auto_generated::riscv32::zk::aes32esi::*;
use crate::cpu::auto_generated::riscv32::zk::aes32esmi::*;
use crate::cpu::auto_generated::riscv32::zk::sha512sig0h::*;
use crate::cpu::auto_generated::riscv32::zk::sha512sig0l::*;
use crate::cpu::auto_generated::riscv32::zk::sha512sig1h::*;
use crate::cpu::auto_generated::riscv32::zk::sha512sig1l::*;
use crate::cpu::auto_generated::riscv32::zk::sha512sum0r::*;
use crate::cpu::auto_generated::riscv32::zk::sha512sum1r::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ZK;

impl ExtensionTest for ZK {
    fn get_name() -> &'static str {
        "riscv32::ZK"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_riscv32_zk_aes32esi, "test_riscv32_zk_aes32esi"),
            (test_riscv32_zk_aes32esmi, "test_riscv32_zk_aes32esmi"),
            (test_riscv32_zk_aes32dsi, "test_riscv32_zk_aes32dsi"),
            (test_riscv32_zk_aes32dsmi, "test_riscv32_zk_aes32dsmi"),
            (test_riscv32_zk_sha512sig0h, "test_riscv32_zk_sha512sig0h"),
            (test_riscv32_zk_sha512sig0l, "test_riscv32_zk_sha512sig0l"),
            (test_riscv32_zk_sha512sig1h, "test_riscv32_zk_sha512sig1h"),
            (test_riscv32_zk_sha512sig1l, "test_riscv32_zk_sha512sig1l"),
            (test_riscv32_zk_sha512sum0r, "test_riscv32_zk_sha512sum0r"),
            (test_riscv32_zk_sha512sum1r, "test_riscv32_zk_sha512sum1r"),
        ]
    }
}
