mod part1;

use crate::cpu::auto_generated::riscv_shared::zk::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct ZK;

impl ExtensionTest for ZK {
    fn get_name() -> &'static str {
        "riscv_shared::ZK"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_xperm8, "test_xperm8"),
            (&test_xperm4, "test_xperm4"),
            (&test_sha256sig0, "test_sha256sig0"),
            (&test_sha256sig1, "test_sha256sig1"),
            (&test_sha256sum0, "test_sha256sum0"),
            (&test_sha256sum1, "test_sha256sum1"),
            (&test_sm4ed, "test_sm4ed"),
            (&test_sm4ks, "test_sm4ks"),
            (&test_sm3p0, "test_sm3p0"),
            (&test_sm3p1, "test_sm3p1"),
        ]
    }
}
