mod part1;

use crate::cpu::auto_generated::wasm32::memory::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct MEMORY;

impl ExtensionTest for MEMORY {
    fn get_name() -> &'static str {
        "wasm32::MEMORY"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_memory_size, "test_memory_size"), (&test_memory_grow, "test_memory_grow")]
    }
}
