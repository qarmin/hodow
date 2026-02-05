mod part1;
mod part2;

#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, check_float_equality, check_int_equality, DEFAULT_FLOAT_DIFF};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::{get_four_random_floats, get_fuzzing, get_random_float};
use crate::cpu::sse1::part1::*;
use crate::cpu::sse1::part2::*;

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


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sse1() {
        let tests = SSE1::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}
