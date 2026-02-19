mod part1;

use crate::cpu::auto_generated::avx::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX;

impl ExtensionTest for AVX {
    fn get_name() -> &'static str {
        "AVX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cmp_pd, "test_mm_cmp_pd"),
            (&test_mm_cmp_ps, "test_mm_cmp_ps"),
            (&test_mm_cmp_sd, "test_mm_cmp_sd"),
            (&test_mm_cmp_ss, "test_mm_cmp_ss"),
            (&test_mm_permutevar_ps, "test_mm_permutevar_ps"),
            (&test_mm_permute_ps, "test_mm_permute_ps"),
            (&test_mm_permutevar_pd, "test_mm_permutevar_pd"),
            (&test_mm_permute_pd, "test_mm_permute_pd"),
            (&test_mm_broadcast_ss, "test_mm_broadcast_ss"),
            (&test_mm_maskload_pd, "test_mm_maskload_pd"),
            (&test_mm_maskstore_pd, "test_mm_maskstore_pd"),
            (&test_mm_maskload_ps, "test_mm_maskload_ps"),
            (&test_mm_maskstore_ps, "test_mm_maskstore_ps"),
            (&test_mm_testz_pd, "test_mm_testz_pd"),
            (&test_mm_testc_pd, "test_mm_testc_pd"),
            (&test_mm_testnzc_pd, "test_mm_testnzc_pd"),
            (&test_mm_testz_ps, "test_mm_testz_ps"),
            (&test_mm_testc_ps, "test_mm_testc_ps"),
            (&test_mm_testnzc_ps, "test_mm_testnzc_ps"),
        ]
    }
}
