mod part1;

use crate::cpu::auto_generated::riscv64::zk::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct ZK;

impl ExtensionTest for ZK {
    fn get_name() -> &'static str {
        "riscv64::ZK"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_riscv64_zk_aes64es, "test_riscv64_zk_aes64es"),
            (&test_riscv64_zk_aes64esm, "test_riscv64_zk_aes64esm"),
            (&test_riscv64_zk_aes64ds, "test_riscv64_zk_aes64ds"),
            (&test_riscv64_zk_aes64dsm, "test_riscv64_zk_aes64dsm"),
            (&test_riscv64_zk_aes64ks1i, "test_riscv64_zk_aes64ks1i"),
            (&test_riscv64_zk_aes64ks2, "test_riscv64_zk_aes64ks2"),
            (&test_riscv64_zk_aes64im, "test_riscv64_zk_aes64im"),
            (&test_riscv64_zk_sha512sig0, "test_riscv64_zk_sha512sig0"),
            (&test_riscv64_zk_sha512sig1, "test_riscv64_zk_sha512sig1"),
            (&test_riscv64_zk_sha512sum0, "test_riscv64_zk_sha512sum0"),
            (&test_riscv64_zk_sha512sum1, "test_riscv64_zk_sha512sum1"),
        ]
    }
}
