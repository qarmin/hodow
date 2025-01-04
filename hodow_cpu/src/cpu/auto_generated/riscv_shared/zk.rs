mod sha256sig0;
mod sha256sig1;
mod sha256sum0;
mod sha256sum1;
mod sm3p0;
mod sm3p1;
mod sm4ed;
mod sm4ks;
mod xperm4;
mod xperm8;

use crate::cpu::auto_generated::riscv_shared::zk::sha256sig0::*;
use crate::cpu::auto_generated::riscv_shared::zk::sha256sig1::*;
use crate::cpu::auto_generated::riscv_shared::zk::sha256sum0::*;
use crate::cpu::auto_generated::riscv_shared::zk::sha256sum1::*;
use crate::cpu::auto_generated::riscv_shared::zk::sm3p0::*;
use crate::cpu::auto_generated::riscv_shared::zk::sm3p1::*;
use crate::cpu::auto_generated::riscv_shared::zk::sm4ed::*;
use crate::cpu::auto_generated::riscv_shared::zk::sm4ks::*;
use crate::cpu::auto_generated::riscv_shared::zk::xperm4::*;
use crate::cpu::auto_generated::riscv_shared::zk::xperm8::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ZK;

impl ExtensionTest for ZK {
    fn get_name() -> &'static str {
        "riscv_shared::ZK"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_riscv_shared_zk_xperm8, "test_riscv_shared_zk_xperm8"),
            (test_riscv_shared_zk_xperm4, "test_riscv_shared_zk_xperm4"),
            (test_riscv_shared_zk_sha256sig0, "test_riscv_shared_zk_sha256sig0"),
            (test_riscv_shared_zk_sha256sig1, "test_riscv_shared_zk_sha256sig1"),
            (test_riscv_shared_zk_sha256sum0, "test_riscv_shared_zk_sha256sum0"),
            (test_riscv_shared_zk_sha256sum1, "test_riscv_shared_zk_sha256sum1"),
            (test_riscv_shared_zk_sm4ed, "test_riscv_shared_zk_sm4ed"),
            (test_riscv_shared_zk_sm4ks, "test_riscv_shared_zk_sm4ks"),
            (test_riscv_shared_zk_sm3p0, "test_riscv_shared_zk_sm3p0"),
            (test_riscv_shared_zk_sm3p1, "test_riscv_shared_zk_sm3p1"),
        ]
    }
}
