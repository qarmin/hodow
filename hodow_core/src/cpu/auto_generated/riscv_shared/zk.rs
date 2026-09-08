mod part1;

use crate::cpu::auto_generated::riscv_shared::zk::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct ZK;

impl ExtensionTest for ZK {
    fn get_name() -> &'static str {
        "riscv_shared::ZK"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_riscv_shared_zk_xperm8, "test_riscv_shared_zk_xperm8"),
            (&test_riscv_shared_zk_xperm4, "test_riscv_shared_zk_xperm4"),
            (&test_riscv_shared_zk_sha256sig0, "test_riscv_shared_zk_sha256sig0"),
            (&test_riscv_shared_zk_sha256sig1, "test_riscv_shared_zk_sha256sig1"),
            (&test_riscv_shared_zk_sha256sum0, "test_riscv_shared_zk_sha256sum0"),
            (&test_riscv_shared_zk_sha256sum1, "test_riscv_shared_zk_sha256sum1"),
            (&test_riscv_shared_zk_sm4ed, "test_riscv_shared_zk_sm4ed"),
            (&test_riscv_shared_zk_sm4ks, "test_riscv_shared_zk_sm4ks"),
            (&test_riscv_shared_zk_sm3p0, "test_riscv_shared_zk_sm3p0"),
            (&test_riscv_shared_zk_sm3p1, "test_riscv_shared_zk_sm3p1"),
        ]
    }
}
