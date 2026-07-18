mod part1;

use crate::cpu::auto_generated::x86::fma::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct FMA;

impl ExtensionTest for FMA {
    fn get_name() -> &'static str {
        "x86::FMA"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_fmadd_pd, "test_mm_fmadd_pd"),
            (&test_mm256_fmadd_pd, "test_mm256_fmadd_pd"),
            (&test_mm_fmadd_ps, "test_mm_fmadd_ps"),
            (&test_mm256_fmadd_ps, "test_mm256_fmadd_ps"),
            (&test_mm_fmadd_sd, "test_mm_fmadd_sd"),
            (&test_mm_fmadd_ss, "test_mm_fmadd_ss"),
            (&test_mm_fmaddsub_pd, "test_mm_fmaddsub_pd"),
            (&test_mm256_fmaddsub_pd, "test_mm256_fmaddsub_pd"),
            (&test_mm_fmaddsub_ps, "test_mm_fmaddsub_ps"),
            (&test_mm256_fmaddsub_ps, "test_mm256_fmaddsub_ps"),
            (&test_mm_fmsub_pd, "test_mm_fmsub_pd"),
            (&test_mm256_fmsub_pd, "test_mm256_fmsub_pd"),
            (&test_mm_fmsub_ps, "test_mm_fmsub_ps"),
            (&test_mm256_fmsub_ps, "test_mm256_fmsub_ps"),
            (&test_mm_fmsub_sd, "test_mm_fmsub_sd"),
            (&test_mm_fmsub_ss, "test_mm_fmsub_ss"),
            (&test_mm_fmsubadd_pd, "test_mm_fmsubadd_pd"),
            (&test_mm256_fmsubadd_pd, "test_mm256_fmsubadd_pd"),
            (&test_mm_fmsubadd_ps, "test_mm_fmsubadd_ps"),
            (&test_mm256_fmsubadd_ps, "test_mm256_fmsubadd_ps"),
            (&test_mm_fnmadd_pd, "test_mm_fnmadd_pd"),
            (&test_mm256_fnmadd_pd, "test_mm256_fnmadd_pd"),
            (&test_mm_fnmadd_ps, "test_mm_fnmadd_ps"),
            (&test_mm256_fnmadd_ps, "test_mm256_fnmadd_ps"),
            (&test_mm_fnmadd_sd, "test_mm_fnmadd_sd"),
            (&test_mm_fnmadd_ss, "test_mm_fnmadd_ss"),
            (&test_mm_fnmsub_pd, "test_mm_fnmsub_pd"),
            (&test_mm256_fnmsub_pd, "test_mm256_fnmsub_pd"),
            (&test_mm_fnmsub_ps, "test_mm_fnmsub_ps"),
            (&test_mm256_fnmsub_ps, "test_mm256_fnmsub_ps"),
            (&test_mm_fnmsub_sd, "test_mm_fnmsub_sd"),
            (&test_mm_fnmsub_ss, "test_mm_fnmsub_ss"),
        ]
    }
}
