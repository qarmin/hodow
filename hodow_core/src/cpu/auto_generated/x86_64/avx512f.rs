mod part1;

use crate::cpu::auto_generated::x86_64::avx512f::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512F;

impl ExtensionTest for AVX512F {
    fn get_name() -> &'static str {
        "x86_64::AVX512F"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtsd_i64, "test_mm_cvtsd_i64"),
            (&test_mm_cvtss_i64, "test_mm_cvtss_i64"),
            (&test_mm_cvtss_u64, "test_mm_cvtss_u64"),
            (&test_mm_cvtsd_u64, "test_mm_cvtsd_u64"),
            (&test_mm_cvti64_ss, "test_mm_cvti64_ss"),
            (&test_mm_cvti64_sd, "test_mm_cvti64_sd"),
            (&test_mm_cvtu64_ss, "test_mm_cvtu64_ss"),
            (&test_mm_cvtu64_sd, "test_mm_cvtu64_sd"),
            (&test_mm_cvttsd_i64, "test_mm_cvttsd_i64"),
            (&test_mm_cvttsd_u64, "test_mm_cvttsd_u64"),
            (&test_mm_cvttss_i64, "test_mm_cvttss_i64"),
            (&test_mm_cvttss_u64, "test_mm_cvttss_u64"),
            (&test_mm_cvt_roundi64_sd, "test_mm_cvt_roundi64_sd"),
            (&test_mm_cvt_roundsi64_sd, "test_mm_cvt_roundsi64_sd"),
            (&test_mm_cvt_roundi64_ss, "test_mm_cvt_roundi64_ss"),
            (&test_mm_cvt_roundu64_sd, "test_mm_cvt_roundu64_sd"),
            (&test_mm_cvt_roundsi64_ss, "test_mm_cvt_roundsi64_ss"),
            (&test_mm_cvt_roundu64_ss, "test_mm_cvt_roundu64_ss"),
            (&test_mm_cvt_roundsd_si64, "test_mm_cvt_roundsd_si64"),
            (&test_mm_cvt_roundsd_i64, "test_mm_cvt_roundsd_i64"),
            (&test_mm_cvt_roundsd_u64, "test_mm_cvt_roundsd_u64"),
            (&test_mm_cvt_roundss_si64, "test_mm_cvt_roundss_si64"),
            (&test_mm_cvt_roundss_i64, "test_mm_cvt_roundss_i64"),
            (&test_mm_cvt_roundss_u64, "test_mm_cvt_roundss_u64"),
            (&test_mm_cvtt_roundsd_si64, "test_mm_cvtt_roundsd_si64"),
            (&test_mm_cvtt_roundsd_i64, "test_mm_cvtt_roundsd_i64"),
            (&test_mm_cvtt_roundsd_u64, "test_mm_cvtt_roundsd_u64"),
            (&test_mm_cvtt_roundss_i64, "test_mm_cvtt_roundss_i64"),
            (&test_mm_cvtt_roundss_si64, "test_mm_cvtt_roundss_si64"),
            (&test_mm_cvtt_roundss_u64, "test_mm_cvtt_roundss_u64"),
        ]
    }
}
