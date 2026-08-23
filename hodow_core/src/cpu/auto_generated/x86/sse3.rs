mod part1;

use crate::cpu::auto_generated::x86::sse3::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE3;

impl ExtensionTest for SSE3 {
    fn get_name() -> &'static str {
        "x86::SSE3"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_x86_sse3_mm_addsub_ps, "test_x86_sse3_mm_addsub_ps"),
            (&test_x86_sse3_mm_addsub_pd, "test_x86_sse3_mm_addsub_pd"),
            (&test_x86_sse3_mm_hadd_pd, "test_x86_sse3_mm_hadd_pd"),
            (&test_x86_sse3_mm_hadd_ps, "test_x86_sse3_mm_hadd_ps"),
            (&test_x86_sse3_mm_hsub_pd, "test_x86_sse3_mm_hsub_pd"),
            (&test_x86_sse3_mm_hsub_ps, "test_x86_sse3_mm_hsub_ps"),
            (&test_x86_sse3_mm_lddqu_si128, "test_x86_sse3_mm_lddqu_si128"),
            (&test_x86_sse3_mm_movedup_pd, "test_x86_sse3_mm_movedup_pd"),
            (&test_x86_sse3_mm_loaddup_pd, "test_x86_sse3_mm_loaddup_pd"),
            (&test_x86_sse3_mm_movehdup_ps, "test_x86_sse3_mm_movehdup_ps"),
            (&test_x86_sse3_mm_moveldup_ps, "test_x86_sse3_mm_moveldup_ps"),
        ]
    }
}
