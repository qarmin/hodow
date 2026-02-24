mod part1;

use crate::cpu::auto_generated::sse3::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE3;

impl ExtensionTest for SSE3 {
    fn get_name() -> &'static str {
        "SSE3"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_addsub_ps, "test_mm_addsub_ps"),
            (&test_mm_addsub_pd, "test_mm_addsub_pd"),
            (&test_mm_hadd_pd, "test_mm_hadd_pd"),
            (&test_mm_hadd_ps, "test_mm_hadd_ps"),
            (&test_mm_hsub_pd, "test_mm_hsub_pd"),
            (&test_mm_hsub_ps, "test_mm_hsub_ps"),
            (&test_mm_lddqu_si128, "test_mm_lddqu_si128"),
            (&test_mm_movedup_pd, "test_mm_movedup_pd"),
            (&test_mm_loaddup_pd, "test_mm_loaddup_pd"),
            (&test_mm_movehdup_ps, "test_mm_movehdup_ps"),
            (&test_mm_moveldup_ps, "test_mm_moveldup_ps"),
        ]
    }
}
