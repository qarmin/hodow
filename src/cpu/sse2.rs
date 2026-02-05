mod part1;
mod part2;
mod part3;
mod part4;
mod part5;
mod part6;

#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, check_float_equality, check_int_equality};
use crate::cpu::sse2::part1::*;
use crate::cpu::sse2::part2::*;
use crate::cpu::sse2::part3::*;
use crate::cpu::sse2::part4::*;
use crate::cpu::sse2::part5::*;
use crate::cpu::sse2::part6::*;
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::{ get_fuzzing, get_random_float, get_random_float64_array};

pub struct SSE2;

impl ExtensionTest for SSE2 {
    fn get_name() -> &'static str {
        "SSE2"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_set_pd, "test_mm_set_pd"),
            (&test_mm_set1_pd, "test_mm_set1_pd"),
            (&test_mm_setzero_pd, "test_mm_setzero_pd"),
            (&test_mm_add_pd, "test_mm_add_pd"),
            (&test_mm_sub_pd, "test_mm_sub_pd"),
            (&test_mm_mul_pd, "test_mm_mul_pd"),
            (&test_mm_load_pd, "test_mm_load_pd"),
            (&test_mm_loadu_pd, "test_mm_loadu_pd"),
            (&test_mm_store_pd, "test_mm_store_pd"),
            (&test_mm_cvtsd_f64, "test_mm_cvtsd_f64"),
            (&test_mm_set_epi32, "test_mm_set_epi32"),
            (&test_mm_set1_epi32, "test_mm_set1_epi32"),
            (&test_mm_setzero_si128, "test_mm_setzero_si128"),
            (&test_mm_add_epi32, "test_mm_add_epi32"),
            (&test_mm_sub_epi32, "test_mm_sub_epi32"),
            (&test_mm_and_si128, "test_mm_and_si128"),
            (&test_mm_or_si128, "test_mm_or_si128"),
            (&test_mm_xor_si128, "test_mm_xor_si128"),
            (&test_mm_cmpeq_epi32, "test_mm_cmpeq_epi32"),
            (&test_mm_cvtsi32_si128, "test_mm_cvtsi32_si128"),
            (&test_mm_cvtsi128_si32, "test_mm_cvtsi128_si32"),
            (&test_mm_pause, "test_mm_pause"),
            (&test_mm_lfence, "test_mm_lfence"),
            (&test_mm_mfence, "test_mm_mfence"),
            (&test_mm_add_epi8, "test_mm_add_epi8"),
            (&test_mm_add_epi16, "test_mm_add_epi16"),
            (&test_mm_add_epi64, "test_mm_add_epi64"),
            (&test_mm_adds_epi8, "test_mm_adds_epi8"),
            (&test_mm_adds_epi16, "test_mm_adds_epi16"),
            (&test_mm_adds_epu8, "test_mm_adds_epu8"),
            (&test_mm_adds_epu16, "test_mm_adds_epu16"),
            (&test_mm_sub_epi16, "test_mm_sub_epi16"),
            (&test_mm_sub_epi64, "test_mm_sub_epi64"),
            (&test_mm_subs_epi16, "test_mm_subs_epi16"),
            (&test_mm_subs_epu8, "test_mm_subs_epu8"),
            (&test_mm_subs_epu16, "test_mm_subs_epu16"),
            (&test_mm_avg_epu8, "test_mm_avg_epu8"),
            (&test_mm_avg_epu16, "test_mm_avg_epu16"),
            (&test_mm_madd_epi16, "test_mm_madd_epi16"),
            (&test_mm_max_epi16, "test_mm_max_epi16"),
            (&test_mm_max_epu8, "test_mm_max_epu8"),
            (&test_mm_min_epi16, "test_mm_min_epi16"),
            (&test_mm_min_epu8, "test_mm_min_epu8"),
            (&test_mm_mulhi_epi16, "test_mm_mulhi_epi16"),
            (&test_mm_mulhi_epu16, "test_mm_mulhi_epu16"),
            (&test_mm_mullo_epi16, "test_mm_mullo_epi16"),
            (&test_mm_mul_epu32, "test_mm_mul_epu32"),
            (&test_mm_sad_epu8, "test_mm_sad_epu8"),
            (&test_mm_slli_si128, "test_mm_slli_si128"),
            (&test_mm_srli_si128, "test_mm_srli_si128"),
            (&test_mm_slli_epi16, "test_mm_slli_epi16"),
            (&test_mm_slli_epi32, "test_mm_slli_epi32"),
            (&test_mm_slli_epi64, "test_mm_slli_epi64"),
            (&test_mm_srai_epi16, "test_mm_srai_epi16"),
            (&test_mm_srai_epi32, "test_mm_srai_epi32"),
            (&test_mm_srli_epi16, "test_mm_srli_epi16"),
            (&test_mm_srli_epi32, "test_mm_srli_epi32"),
            (&test_mm_srli_epi64, "test_mm_srli_epi64"),
            (&test_mm_cmpeq_epi8, "test_mm_cmpeq_epi8"),
            (&test_mm_cmpeq_epi16, "test_mm_cmpeq_epi16"),
            (&test_mm_cmpgt_epi8, "test_mm_cmpgt_epi8"),
            (&test_mm_cmpgt_epi16, "test_mm_cmpgt_epi16"),
            (&test_mm_cmpgt_epi32, "test_mm_cmpgt_epi32"),
            (&test_mm_cmplt_epi8, "test_mm_cmplt_epi8"),
            (&test_mm_cmplt_epi16, "test_mm_cmplt_epi16"),
            (&test_mm_cmplt_epi32, "test_mm_cmplt_epi32"),
            (&test_mm_set_epi8, "test_mm_set_epi8"),
            (&test_mm_set_epi16, "test_mm_set_epi16"),
            (&test_mm_set_epi64x, "test_mm_set_epi64x"),
            (&test_mm_set1_epi8, "test_mm_set1_epi8"),
            (&test_mm_set1_epi16, "test_mm_set1_epi16"),
            (&test_mm_set1_epi64x, "test_mm_set1_epi64x"),
            (&test_mm_setr_epi8, "test_mm_setr_epi8"),
            (&test_mm_setr_epi16, "test_mm_setr_epi16"),
            (&test_mm_setr_epi32, "test_mm_setr_epi32"),
            (&test_mm_loadl_epi64, "test_mm_loadl_epi64"),
            (&test_mm_load_si128, "test_mm_load_si128"),
            (&test_mm_loadu_si128, "test_mm_loadu_si128"),
            (&test_mm_store_si128, "test_mm_store_si128"),
            (&test_mm_storeu_si128, "test_mm_storeu_si128"),
            (&test_mm_storel_epi64, "test_mm_storel_epi64"),
            (&test_mm_packs_epi16, "test_mm_packs_epi16"),
            (&test_mm_packs_epi32, "test_mm_packs_epi32"),
            (&test_mm_packus_epi16, "test_mm_packus_epi16"),
            (&test_mm_unpackhi_epi8, "test_mm_unpackhi_epi8"),
            (&test_mm_unpackhi_epi16, "test_mm_unpackhi_epi16"),
            (&test_mm_unpackhi_epi32, "test_mm_unpackhi_epi32"),
            (&test_mm_unpackhi_epi64, "test_mm_unpackhi_epi64"),
            (&test_mm_unpacklo_epi8, "test_mm_unpacklo_epi8"),
            (&test_mm_unpacklo_epi16, "test_mm_unpacklo_epi16"),
            (&test_mm_unpacklo_epi32, "test_mm_unpacklo_epi32"),
            (&test_mm_unpacklo_epi64, "test_mm_unpacklo_epi64"),
            (&test_mm_shuffle_epi32, "test_mm_shuffle_epi32"),
            (&test_mm_shufflehi_epi16, "test_mm_shufflehi_epi16"),
            (&test_mm_shufflelo_epi16, "test_mm_shufflelo_epi16"),
            (&test_mm_extract_epi16, "test_mm_extract_epi16"),
            (&test_mm_insert_epi16, "test_mm_insert_epi16"),
            (&test_mm_movemask_epi8, "test_mm_movemask_epi8"),
            (&test_mm_cvtepi32_pd, "test_mm_cvtepi32_pd"),
            (&test_mm_cvtepi32_ps, "test_mm_cvtepi32_ps"),
            (&test_mm_cvtpd_epi32, "test_mm_cvtpd_epi32"),
            (&test_mm_cvtps_epi32, "test_mm_cvtps_epi32"),
            (&test_mm_cvttpd_epi32, "test_mm_cvttpd_epi32"),
            (&test_mm_cvttps_epi32, "test_mm_cvttps_epi32"),
            (&test_mm_add_sd, "test_mm_add_sd"),
            (&test_mm_div_sd, "test_mm_div_sd"),
            (&test_mm_div_pd, "test_mm_div_pd"),
            (&test_mm_max_sd, "test_mm_max_sd"),
            (&test_mm_max_pd, "test_mm_max_pd"),
            (&test_mm_min_sd, "test_mm_min_sd"),
            (&test_mm_min_pd, "test_mm_min_pd"),
            (&test_mm_mul_sd, "test_mm_mul_sd"),
            (&test_mm_sqrt_sd, "test_mm_sqrt_sd"),
            (&test_mm_sqrt_pd, "test_mm_sqrt_pd"),
            (&test_mm_sub_sd, "test_mm_sub_sd"),
            (&test_mm_and_pd, "test_mm_and_pd"),
            (&test_mm_andnot_pd, "test_mm_andnot_pd"),
            (&test_mm_or_pd, "test_mm_or_pd"),
            (&test_mm_xor_pd, "test_mm_xor_pd"),
            (&test_mm_andnot_si128, "test_mm_andnot_si128"),
        ]
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sse2() {
        let tests = SSE2::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}
