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
            (&test_aes64es, "test_aes64es"),
            (&test_aes64esm, "test_aes64esm"),
            (&test_aes64ds, "test_aes64ds"),
            (&test_aes64dsm, "test_aes64dsm"),
            (&test_aes64ks1i, "test_aes64ks1i"),
            (&test_aes64ks2, "test_aes64ks2"),
            (&test_aes64im, "test_aes64im"),
            (&test_sha512sig0, "test_sha512sig0"),
            (&test_sha512sig1, "test_sha512sig1"),
            (&test_sha512sum0, "test_sha512sum0"),
            (&test_sha512sum1, "test_sha512sum1"),
        ]
    }
}
