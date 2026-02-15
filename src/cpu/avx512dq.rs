mod part1;
mod part2;
mod part3;
mod part4;
mod part5;
mod part6;
mod part7;

#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use crate::cpu::avx512dq::part1::*;
use crate::cpu::avx512dq::part2::*;
use crate::cpu::avx512dq::part3::*;
use crate::cpu::avx512dq::part4::*;
use crate::cpu::avx512dq::part5::*;
use crate::cpu::avx512dq::part6::*;
use crate::cpu::avx512dq::part7::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512DQ;

impl ExtensionTest for AVX512DQ {
    fn get_name() -> &'static str {
        "AVX512DQ"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_mask_and_pd, "test_mm_mask_and_pd"),
            (&test_mm_maskz_and_pd, "test_mm_maskz_and_pd"),
            (&test_mm_mask_and_ps, "test_mm_mask_and_ps"),
            (&test_mm_maskz_and_ps, "test_mm_maskz_and_ps"),
            (&test_mm_mask_andnot_pd, "test_mm_mask_andnot_pd"),
            (&test_mm_maskz_andnot_pd, "test_mm_maskz_andnot_pd"),
            (&test_mm_mask_andnot_ps, "test_mm_mask_andnot_ps"),
            (&test_mm_maskz_andnot_ps, "test_mm_maskz_andnot_ps"),
            (&test_mm_mask_or_pd, "test_mm_mask_or_pd"),
            (&test_mm_maskz_or_pd, "test_mm_maskz_or_pd"),
            (&test_mm_mask_or_ps, "test_mm_mask_or_ps"),
            (&test_mm_maskz_or_ps, "test_mm_maskz_or_ps"),
            (&test_mm_mask_xor_pd, "test_mm_mask_xor_pd"),
            (&test_mm_maskz_xor_pd, "test_mm_maskz_xor_pd"),
            (&test_mm_mask_xor_ps, "test_mm_mask_xor_ps"),
            (&test_mm_maskz_xor_ps, "test_mm_maskz_xor_ps"),
            (&test_mm_broadcast_i32x2, "test_mm_broadcast_i32x2"),
            (&test_mm_mask_broadcast_i32x2, "test_mm_mask_broadcast_i32x2"),
            (&test_mm_maskz_broadcast_i32x2, "test_mm_maskz_broadcast_i32x2"),
            (&test_mm_cvtepi64_pd, "test_mm_cvtepi64_pd"),
            (&test_mm_mask_cvtepi64_pd, "test_mm_mask_cvtepi64_pd"),
            (&test_mm_maskz_cvtepi64_pd, "test_mm_maskz_cvtepi64_pd"),
            (&test_mm_cvtepi64_ps, "test_mm_cvtepi64_ps"),
            (&test_mm_mask_cvtepi64_ps, "test_mm_mask_cvtepi64_ps"),
            (&test_mm_maskz_cvtepi64_ps, "test_mm_maskz_cvtepi64_ps"),
            (&test_mm_cvtepu64_pd, "test_mm_cvtepu64_pd"),
            (&test_mm_mask_cvtepu64_pd, "test_mm_mask_cvtepu64_pd"),
            (&test_mm_maskz_cvtepu64_pd, "test_mm_maskz_cvtepu64_pd"),
            (&test_mm_cvtepu64_ps, "test_mm_cvtepu64_ps"),
            (&test_mm_mask_cvtepu64_ps, "test_mm_mask_cvtepu64_ps"),
            (&test_mm_maskz_cvtepu64_ps, "test_mm_maskz_cvtepu64_ps"),
            (&test_mm_cvtpd_epi64, "test_mm_cvtpd_epi64"),
            (&test_mm_mask_cvtpd_epi64, "test_mm_mask_cvtpd_epi64"),
            (&test_mm_maskz_cvtpd_epi64, "test_mm_maskz_cvtpd_epi64"),
            (&test_mm_cvtps_epi64, "test_mm_cvtps_epi64"),
            (&test_mm_mask_cvtps_epi64, "test_mm_mask_cvtps_epi64"),
            (&test_mm_maskz_cvtps_epi64, "test_mm_maskz_cvtps_epi64"),
            (&test_mm_cvtpd_epu64, "test_mm_cvtpd_epu64"),
            (&test_mm_mask_cvtpd_epu64, "test_mm_mask_cvtpd_epu64"),
            (&test_mm_maskz_cvtpd_epu64, "test_mm_maskz_cvtpd_epu64"),
            (&test_mm_cvtps_epu64, "test_mm_cvtps_epu64"),
            (&test_mm_mask_cvtps_epu64, "test_mm_mask_cvtps_epu64"),
            (&test_mm_maskz_cvtps_epu64, "test_mm_maskz_cvtps_epu64"),
            (&test_mm_cvttpd_epi64, "test_mm_cvttpd_epi64"),
            (&test_mm_mask_cvttpd_epi64, "test_mm_mask_cvttpd_epi64"),
            (&test_mm_maskz_cvttpd_epi64, "test_mm_maskz_cvttpd_epi64"),
            (&test_mm_cvttps_epi64, "test_mm_cvttps_epi64"),
            (&test_mm_mask_cvttps_epi64, "test_mm_mask_cvttps_epi64"),
            (&test_mm_maskz_cvttps_epi64, "test_mm_maskz_cvttps_epi64"),
            (&test_mm_cvttpd_epu64, "test_mm_cvttpd_epu64"),
            (&test_mm_mask_cvttpd_epu64, "test_mm_mask_cvttpd_epu64"),
            (&test_mm_maskz_cvttpd_epu64, "test_mm_maskz_cvttpd_epu64"),
            (&test_mm_cvttps_epu64, "test_mm_cvttps_epu64"),
            (&test_mm_mask_cvttps_epu64, "test_mm_mask_cvttps_epu64"),
            (&test_mm_maskz_cvttps_epu64, "test_mm_maskz_cvttps_epu64"),
            (&test_mm_mullo_epi64, "test_mm_mullo_epi64"),
            (&test_mm_mask_mullo_epi64, "test_mm_mask_mullo_epi64"),
            (&test_mm_maskz_mullo_epi64, "test_mm_maskz_mullo_epi64"),
            (&test_mm_movepi32_mask, "test_mm_movepi32_mask"),
            (&test_mm_movepi64_mask, "test_mm_movepi64_mask"),
            (&test_mm_movm_epi32, "test_mm_movm_epi32"),
            (&test_mm_movm_epi64, "test_mm_movm_epi64"),
            (&test_mm_range_pd, "test_mm_range_pd"),
            (&test_mm_mask_range_pd, "test_mm_mask_range_pd"),
            (&test_mm_maskz_range_pd, "test_mm_maskz_range_pd"),
            (&test_mm_range_ps, "test_mm_range_ps"),
            (&test_mm_mask_range_ps, "test_mm_mask_range_ps"),
            (&test_mm_maskz_range_ps, "test_mm_maskz_range_ps"),
            (&test_mm_range_round_sd, "test_mm_range_round_sd"),
            (&test_mm_mask_range_round_sd, "test_mm_mask_range_round_sd"),
            (&test_mm_maskz_range_round_sd, "test_mm_maskz_range_round_sd"),
            (&test_mm_mask_range_sd, "test_mm_mask_range_sd"),
            (&test_mm_maskz_range_sd, "test_mm_maskz_range_sd"),
            (&test_mm_range_round_ss, "test_mm_range_round_ss"),
            (&test_mm_mask_range_round_ss, "test_mm_mask_range_round_ss"),
            (&test_mm_maskz_range_round_ss, "test_mm_maskz_range_round_ss"),
            (&test_mm_mask_range_ss, "test_mm_mask_range_ss"),
            (&test_mm_maskz_range_ss, "test_mm_maskz_range_ss"),
            (&test_mm_reduce_pd, "test_mm_reduce_pd"),
            (&test_mm_mask_reduce_pd, "test_mm_mask_reduce_pd"),
            (&test_mm_maskz_reduce_pd, "test_mm_maskz_reduce_pd"),
            (&test_mm_reduce_ps, "test_mm_reduce_ps"),
            (&test_mm_mask_reduce_ps, "test_mm_mask_reduce_ps"),
            (&test_mm_maskz_reduce_ps, "test_mm_maskz_reduce_ps"),
            (&test_mm_reduce_round_sd, "test_mm_reduce_round_sd"),
            (&test_mm_mask_reduce_round_sd, "test_mm_mask_reduce_round_sd"),
            (&test_mm_maskz_reduce_round_sd, "test_mm_maskz_reduce_round_sd"),
            (&test_mm_reduce_sd, "test_mm_reduce_sd"),
            (&test_mm_mask_reduce_sd, "test_mm_mask_reduce_sd"),
            (&test_mm_maskz_reduce_sd, "test_mm_maskz_reduce_sd"),
            (&test_mm_reduce_round_ss, "test_mm_reduce_round_ss"),
            (&test_mm_mask_reduce_round_ss, "test_mm_mask_reduce_round_ss"),
            (&test_mm_maskz_reduce_round_ss, "test_mm_maskz_reduce_round_ss"),
            (&test_mm_reduce_ss, "test_mm_reduce_ss"),
            (&test_mm_mask_reduce_ss, "test_mm_mask_reduce_ss"),
            (&test_mm_maskz_reduce_ss, "test_mm_maskz_reduce_ss"),
            (&test_mm_fpclass_pd_mask, "test_mm_fpclass_pd_mask"),
            (&test_mm_mask_fpclass_pd_mask, "test_mm_mask_fpclass_pd_mask"),
            (&test_mm_fpclass_ps_mask, "test_mm_fpclass_ps_mask"),
            (&test_mm_mask_fpclass_ps_mask, "test_mm_mask_fpclass_ps_mask"),
            (&test_mm_fpclass_sd_mask, "test_mm_fpclass_sd_mask"),
            (&test_mm_mask_fpclass_sd_mask, "test_mm_mask_fpclass_sd_mask"),
            (&test_mm_fpclass_ss_mask, "test_mm_fpclass_ss_mask"),
            (&test_mm_mask_fpclass_ss_mask, "test_mm_mask_fpclass_ss_mask"),
        ]
    }
}
