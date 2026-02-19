mod part1;
mod part2;

use self::part1::*;
use self::part2::*;
use crate::cpu::{ExtensionTest, TestFunction};
pub struct SSE1;

impl ExtensionTest for SSE1 {
    fn get_name() -> &'static str {
        "SSE1"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_set_ps, "test_mm_set_ps"),
            (&test_mm_set_ss, "test_mm_set_ss"),
            (&test_mm_add_ps, "test_mm_add_ps"),
            (&test_mm_add_ss, "test_mm_add_ss"),
            (&test_mm_sub_ps, "test_mm_sub_ps"),
            (&test_mm_sub_ss, "test_mm_sub_ss"),
            (&test_mm_mul_ps, "test_mm_mul_ps"),
            (&test_mm_mul_ss, "test_mm_mul_ss"),
            (&test_mm_div_ps, "test_mm_div_ps"),
            (&test_mm_div_ss, "test_mm_div_ss"),
            (&test_mm_sqrt_ps, "test_mm_sqrt_ps"),
            (&test_mm_sqrt_ss, "test_mm_sqrt_ss"),
            (&test_mm_rcp_ps, "test_mm_rcp_ps"),
            (&test_mm_rcp_ss, "test_mm_rcp_ss"),
            (&test_mm_rsqrt_ps, "test_mm_rsqrt_ps"),
            (&test_mm_rsqrt_ss, "test_mm_rsqrt_ss"),
            (&test_mm_min_ps, "test_mm_min_ps"),
            (&test_mm_min_ss, "test_mm_min_ss"),
            (&test_mm_max_ps, "test_mm_max_ps"),
            (&test_mm_max_ss, "test_mm_max_ss"),
            (&test_mm_set1_ps, "test_mm_set1_ps"),
            (&test_mm_setzero_ps, "test_mm_setzero_ps"),
            (&test_mm_load_ps, "test_mm_load_ps"),
            (&test_mm_loadu_ps, "test_mm_loadu_ps"),
            (&test_mm_store_ps, "test_mm_store_ps"),
            (&test_mm_movemask_ps, "test_mm_movemask_ps"),
            (&test_mm_and_ps, "test_mm_and_ps"),
            (&test_mm_andnot_ps, "test_mm_andnot_ps"),
            (&test_mm_or_ps, "test_mm_or_ps"),
            (&test_mm_xor_ps, "test_mm_xor_ps"),
            (&test_mm_cmpeq_ps, "test_mm_cmpeq_ps"),
            (&test_mm_cmpgt_ps, "test_mm_cmpgt_ps"),
            (&test_mm_cmplt_ps, "test_mm_cmplt_ps"),
            (&test_mm_cmpge_ps, "test_mm_cmpge_ps"),
            (&test_mm_cmple_ps, "test_mm_cmple_ps"),
            (&test_mm_shuffle_ps, "test_mm_shuffle_ps"),
            (&test_mm_unpackhi_ps, "test_mm_unpackhi_ps"),
            (&test_mm_unpacklo_ps, "test_mm_unpacklo_ps"),
            (&test_mm_movehl_ps, "test_mm_movehl_ps"),
            (&test_mm_movelh_ps, "test_mm_movelh_ps"),
            (&test_mm_move_ss, "test_mm_move_ss"),
            (&test_mm_cvtss_f32, "test_mm_cvtss_f32"),
            (&test_mm_cvtss_si32, "test_mm_cvtss_si32"),
            (&test_mm_cvtsi32_ss, "test_mm_cvtsi32_ss"),
        ]
    }
}
