mod part1;
mod part2;
mod part3;
mod part4;

use crate::cpu::auto_generated::sse::part1::*;
use crate::cpu::auto_generated::sse::part2::*;
use crate::cpu::auto_generated::sse::part3::*;
use crate::cpu::auto_generated::sse::part4::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct SSE;

impl ExtensionTest for SSE {
    fn get_name() -> &'static str {
        "SSE"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtss_si64, "test_mm_cvtss_si64"),
            (&test_mm_cvttss_si64, "test_mm_cvttss_si64"),
            (&test_mm_cvtsi64_ss, "test_mm_cvtsi64_ss"),
            (&test_mm_add_ss, "test_mm_add_ss"),
            (&test_mm_add_ps, "test_mm_add_ps"),
            (&test_mm_sub_ss, "test_mm_sub_ss"),
            (&test_mm_sub_ps, "test_mm_sub_ps"),
            (&test_mm_mul_ss, "test_mm_mul_ss"),
            (&test_mm_mul_ps, "test_mm_mul_ps"),
            (&test_mm_div_ss, "test_mm_div_ss"),
            (&test_mm_div_ps, "test_mm_div_ps"),
            (&test_mm_sqrt_ss, "test_mm_sqrt_ss"),
            (&test_mm_sqrt_ps, "test_mm_sqrt_ps"),
            (&test_mm_rcp_ss, "test_mm_rcp_ss"),
            (&test_mm_rcp_ps, "test_mm_rcp_ps"),
            (&test_mm_rsqrt_ss, "test_mm_rsqrt_ss"),
            (&test_mm_rsqrt_ps, "test_mm_rsqrt_ps"),
            (&test_mm_min_ss, "test_mm_min_ss"),
            (&test_mm_min_ps, "test_mm_min_ps"),
            (&test_mm_max_ss, "test_mm_max_ss"),
            (&test_mm_max_ps, "test_mm_max_ps"),
            (&test_mm_and_ps, "test_mm_and_ps"),
            (&test_mm_andnot_ps, "test_mm_andnot_ps"),
            (&test_mm_or_ps, "test_mm_or_ps"),
            (&test_mm_xor_ps, "test_mm_xor_ps"),
            (&test_mm_cmpeq_ss, "test_mm_cmpeq_ss"),
            (&test_mm_cmplt_ss, "test_mm_cmplt_ss"),
            (&test_mm_cmple_ss, "test_mm_cmple_ss"),
            (&test_mm_cmpgt_ss, "test_mm_cmpgt_ss"),
            (&test_mm_cmpge_ss, "test_mm_cmpge_ss"),
            (&test_mm_cmpneq_ss, "test_mm_cmpneq_ss"),
            (&test_mm_cmpnlt_ss, "test_mm_cmpnlt_ss"),
            (&test_mm_cmpnle_ss, "test_mm_cmpnle_ss"),
            (&test_mm_cmpngt_ss, "test_mm_cmpngt_ss"),
            (&test_mm_cmpnge_ss, "test_mm_cmpnge_ss"),
            (&test_mm_cmpord_ss, "test_mm_cmpord_ss"),
            (&test_mm_cmpunord_ss, "test_mm_cmpunord_ss"),
            (&test_mm_cmpeq_ps, "test_mm_cmpeq_ps"),
            (&test_mm_cmplt_ps, "test_mm_cmplt_ps"),
            (&test_mm_cmple_ps, "test_mm_cmple_ps"),
            (&test_mm_cmpgt_ps, "test_mm_cmpgt_ps"),
            (&test_mm_cmpge_ps, "test_mm_cmpge_ps"),
            (&test_mm_cmpneq_ps, "test_mm_cmpneq_ps"),
            (&test_mm_cmpnlt_ps, "test_mm_cmpnlt_ps"),
            (&test_mm_cmpnle_ps, "test_mm_cmpnle_ps"),
            (&test_mm_cmpngt_ps, "test_mm_cmpngt_ps"),
            (&test_mm_cmpnge_ps, "test_mm_cmpnge_ps"),
            (&test_mm_cmpord_ps, "test_mm_cmpord_ps"),
            (&test_mm_cmpunord_ps, "test_mm_cmpunord_ps"),
            (&test_mm_comieq_ss, "test_mm_comieq_ss"),
            (&test_mm_comilt_ss, "test_mm_comilt_ss"),
            (&test_mm_comile_ss, "test_mm_comile_ss"),
            (&test_mm_comigt_ss, "test_mm_comigt_ss"),
            (&test_mm_comige_ss, "test_mm_comige_ss"),
            (&test_mm_comineq_ss, "test_mm_comineq_ss"),
            (&test_mm_ucomieq_ss, "test_mm_ucomieq_ss"),
            (&test_mm_ucomilt_ss, "test_mm_ucomilt_ss"),
            (&test_mm_ucomile_ss, "test_mm_ucomile_ss"),
            (&test_mm_ucomigt_ss, "test_mm_ucomigt_ss"),
            (&test_mm_ucomige_ss, "test_mm_ucomige_ss"),
            (&test_mm_ucomineq_ss, "test_mm_ucomineq_ss"),
            (&test_mm_cvtss_si32, "test_mm_cvtss_si32"),
            (&test_mm_cvt_ss2si, "test_mm_cvt_ss2si"),
            (&test_mm_cvttss_si32, "test_mm_cvttss_si32"),
            (&test_mm_cvtt_ss2si, "test_mm_cvtt_ss2si"),
            (&test_mm_cvtss_f32, "test_mm_cvtss_f32"),
            (&test_mm_cvtsi32_ss, "test_mm_cvtsi32_ss"),
            (&test_mm_cvt_si2ss, "test_mm_cvt_si2ss"),
            (&test_mm_set_ss, "test_mm_set_ss"),
            (&test_mm_set1_ps, "test_mm_set1_ps"),
            (&test_mm_set_ps1, "test_mm_set_ps1"),
            (&test_mm_set_ps, "test_mm_set_ps"),
            (&test_mm_setr_ps, "test_mm_setr_ps"),
            (&test_mm_setzero_ps, "test_mm_setzero_ps"),
            (&test_mm_shuffle_ps, "test_mm_shuffle_ps"),
            (&test_mm_unpackhi_ps, "test_mm_unpackhi_ps"),
            (&test_mm_unpacklo_ps, "test_mm_unpacklo_ps"),
            (&test_mm_movehl_ps, "test_mm_movehl_ps"),
            (&test_mm_movelh_ps, "test_mm_movelh_ps"),
            (&test_mm_movemask_ps, "test_mm_movemask_ps"),
            (&test_mm_load_ss, "test_mm_load_ss"),
            (&test_mm_load1_ps, "test_mm_load1_ps"),
            (&test_mm_load_ps1, "test_mm_load_ps1"),
            (&test_mm_load_ps, "test_mm_load_ps"),
            (&test_mm_loadu_ps, "test_mm_loadu_ps"),
            (&test_mm_loadr_ps, "test_mm_loadr_ps"),
            (&test_mm_store_ss, "test_mm_store_ss"),
            (&test_mm_store1_ps, "test_mm_store1_ps"),
            (&test_mm_store_ps1, "test_mm_store_ps1"),
            (&test_mm_store_ps, "test_mm_store_ps"),
            (&test_mm_storeu_ps, "test_mm_storeu_ps"),
            (&test_mm_storer_ps, "test_mm_storer_ps"),
            (&test_mm_move_ss, "test_mm_move_ss"),
            (&test_mm_sfence, "test_mm_sfence"),
            (&test_mm_getcsr, "test_mm_getcsr"),
            (&test_mm_setcsr, "test_mm_setcsr"),
            (&test_mm_prefetch, "test_mm_prefetch"),
            (&test_mm_undefined_ps, "test_mm_undefined_ps"),
            (&test_mm_stream_ps, "test_mm_stream_ps"),
        ]
    }
}
