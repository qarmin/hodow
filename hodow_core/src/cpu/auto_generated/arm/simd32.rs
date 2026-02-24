mod part1;

use crate::cpu::auto_generated::arm::simd32::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SIMD32;

impl ExtensionTest for SIMD32 {
    fn get_name() -> &'static str {
        "arm::SIMD32"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_qadd8, "test_qadd8"),
            (&test_qsub8, "test_qsub8"),
            (&test_qsub16, "test_qsub16"),
            (&test_qadd16, "test_qadd16"),
            (&test_qasx, "test_qasx"),
            (&test_qsax, "test_qsax"),
            (&test_sadd16, "test_sadd16"),
            (&test_sadd8, "test_sadd8"),
            (&test_smlad, "test_smlad"),
            (&test_smlsd, "test_smlsd"),
            (&test_sasx, "test_sasx"),
            (&test_sel, "test_sel"),
            (&test_shadd8, "test_shadd8"),
            (&test_shadd16, "test_shadd16"),
            (&test_shsub8, "test_shsub8"),
            (&test_usub8, "test_usub8"),
            (&test_ssub8, "test_ssub8"),
            (&test_shsub16, "test_shsub16"),
            (&test_smuad, "test_smuad"),
            (&test_smuadx, "test_smuadx"),
            (&test_smusd, "test_smusd"),
            (&test_smusdx, "test_smusdx"),
            (&test_usad8, "test_usad8"),
            (&test_usada8, "test_usada8"),
        ]
    }
}
