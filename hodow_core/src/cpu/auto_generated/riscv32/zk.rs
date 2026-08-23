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
            (&test_riscv32_zk_aes32esi, "test_riscv32_zk_aes32esi"),
            (&test_riscv32_zk_aes32esmi, "test_riscv32_zk_aes32esmi"),
            (&test_riscv32_zk_aes32dsi, "test_riscv32_zk_aes32dsi"),
            (&test_riscv32_zk_aes32dsmi, "test_riscv32_zk_aes32dsmi"),
            (&test_riscv32_zk_zip, "test_riscv32_zk_zip"),
            (&test_riscv32_zk_unzip, "test_riscv32_zk_unzip"),
            (&test_riscv32_zk_sha512sig0h, "test_riscv32_zk_sha512sig0h"),
            (&test_riscv32_zk_sha512sig0l, "test_riscv32_zk_sha512sig0l"),
            (&test_riscv32_zk_sha512sig1h, "test_riscv32_zk_sha512sig1h"),
            (&test_riscv32_zk_sha512sig1l, "test_riscv32_zk_sha512sig1l"),
            (&test_riscv32_zk_sha512sum0r, "test_riscv32_zk_sha512sum0r"),
            (&test_riscv32_zk_sha512sum1r, "test_riscv32_zk_sha512sum1r"),
        ]
    }
}
