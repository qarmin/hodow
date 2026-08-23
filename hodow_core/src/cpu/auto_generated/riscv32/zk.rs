mod part1;

use crate::cpu::auto_generated::riscv32::zk::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct ZK;

impl ExtensionTest for ZK {
    fn get_name() -> &'static str {
        "riscv32::ZK"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_aes32esi, "test_aes32esi"),
            (&test_aes32esmi, "test_aes32esmi"),
            (&test_aes32dsi, "test_aes32dsi"),
            (&test_aes32dsmi, "test_aes32dsmi"),
            (&test_zip, "test_zip"),
            (&test_unzip, "test_unzip"),
            (&test_sha512sig0h, "test_sha512sig0h"),
            (&test_sha512sig0l, "test_sha512sig0l"),
            (&test_sha512sig1h, "test_sha512sig1h"),
            (&test_sha512sig1l, "test_sha512sig1l"),
            (&test_sha512sum0r, "test_sha512sum0r"),
            (&test_sha512sum1r, "test_sha512sum1r"),
        ]
    }
}
