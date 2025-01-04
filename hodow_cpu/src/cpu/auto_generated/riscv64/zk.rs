mod aes64ds;
mod aes64dsm;
mod aes64es;
mod aes64esm;
mod aes64im;
mod aes64ks1i;
mod aes64ks2;
mod sha512sig0;
mod sha512sig1;
mod sha512sum0;
mod sha512sum1;

use crate::cpu::auto_generated::riscv64::zk::aes64ds::*;
use crate::cpu::auto_generated::riscv64::zk::aes64dsm::*;
use crate::cpu::auto_generated::riscv64::zk::aes64es::*;
use crate::cpu::auto_generated::riscv64::zk::aes64esm::*;
use crate::cpu::auto_generated::riscv64::zk::aes64im::*;
use crate::cpu::auto_generated::riscv64::zk::aes64ks1i::*;
use crate::cpu::auto_generated::riscv64::zk::aes64ks2::*;
use crate::cpu::auto_generated::riscv64::zk::sha512sig0::*;
use crate::cpu::auto_generated::riscv64::zk::sha512sig1::*;
use crate::cpu::auto_generated::riscv64::zk::sha512sum0::*;
use crate::cpu::auto_generated::riscv64::zk::sha512sum1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ZK;

impl ExtensionTest for ZK {
    fn get_name() -> &'static str {
        "riscv64::ZK"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_riscv64_zk_aes64es, "test_riscv64_zk_aes64es"),
            (test_riscv64_zk_aes64esm, "test_riscv64_zk_aes64esm"),
            (test_riscv64_zk_aes64ds, "test_riscv64_zk_aes64ds"),
            (test_riscv64_zk_aes64dsm, "test_riscv64_zk_aes64dsm"),
            (test_riscv64_zk_aes64ks1i, "test_riscv64_zk_aes64ks1i"),
            (test_riscv64_zk_aes64ks2, "test_riscv64_zk_aes64ks2"),
            (test_riscv64_zk_aes64im, "test_riscv64_zk_aes64im"),
            (test_riscv64_zk_sha512sig0, "test_riscv64_zk_sha512sig0"),
            (test_riscv64_zk_sha512sig1, "test_riscv64_zk_sha512sig1"),
            (test_riscv64_zk_sha512sum0, "test_riscv64_zk_sha512sum0"),
            (test_riscv64_zk_sha512sum1, "test_riscv64_zk_sha512sum1"),
        ]
    }
}
