mod part1;

use crate::cpu::auto_generated::wasm32::atomic::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct ATOMIC;

impl ExtensionTest for ATOMIC {
    fn get_name() -> &'static str {
        "wasm32::ATOMIC"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_memory_atomic_wait32, "test_memory_atomic_wait32"),
            (&test_memory_atomic_wait64, "test_memory_atomic_wait64"),
            (&test_memory_atomic_notify, "test_memory_atomic_notify"),
        ]
    }
}
