mod part1;

use crate::cpu::auto_generated::arm::dsp::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct DSP;

impl ExtensionTest for DSP {
    fn get_name() -> &'static str {
        "arm::DSP"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_smulbb, "test_smulbb"),
            (&test_smultb, "test_smultb"),
            (&test_smulbt, "test_smulbt"),
            (&test_smultt, "test_smultt"),
            (&test_smulwb, "test_smulwb"),
            (&test_smulwt, "test_smulwt"),
            (&test_qadd, "test_qadd"),
            (&test_qsub, "test_qsub"),
            (&test_qdbl, "test_qdbl"),
            (&test_smlabb, "test_smlabb"),
            (&test_smlabt, "test_smlabt"),
            (&test_smlatb, "test_smlatb"),
            (&test_smlatt, "test_smlatt"),
            (&test_smlawb, "test_smlawb"),
            (&test_smlawt, "test_smlawt"),
        ]
    }
}
