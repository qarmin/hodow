mod part1;

use crate::cpu::auto_generated::test::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct TEST;

impl ExtensionTest for TEST {
    fn get_name() -> &'static str {
        "TEST"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_setr_epi64x, "test_mm_setr_epi64x"),
            (&test_mm_insert_epi64, "test_mm_insert_epi64"),
            (&test_mm256_insert_epi64, "test_mm256_insert_epi64"),
        ]
    }
}
