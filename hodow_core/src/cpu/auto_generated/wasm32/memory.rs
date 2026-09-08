mod part1;

use crate::cpu::auto_generated::wasm32::memory::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct MEMORY;

impl ExtensionTest for MEMORY {
    fn get_name() -> &'static str {
        "wasm32::MEMORY"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_wasm32_memory_memory_size, "test_wasm32_memory_memory_size"),
            (&test_wasm32_memory_memory_grow, "test_wasm32_memory_memory_grow"),
        ]
    }
}
