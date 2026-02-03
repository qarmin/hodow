#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::{
    __m128d, __m128i,
    _mm_add_epi8, _mm_add_epi16, _mm_add_epi32, _mm_add_epi64, _mm_add_pd, _mm_add_sd,
    _mm_adds_epi8, _mm_adds_epi16, _mm_adds_epu8, _mm_adds_epu16,
    _mm_and_si128, _mm_and_pd, _mm_andnot_si128, _mm_andnot_pd,
    _mm_avg_epu8, _mm_avg_epu16,
    _mm_bslli_si128, _mm_bsrli_si128,
    _mm_castpd_ps, _mm_castpd_si128, _mm_castps_pd, _mm_castps_si128,
    _mm_castsi128_pd, _mm_castsi128_ps,
    _mm_clflush,
    _mm_cmpeq_epi8, _mm_cmpeq_epi16, _mm_cmpeq_epi32,
    _mm_cmpeq_pd, _mm_cmpeq_sd,
    _mm_cmpge_pd, _mm_cmpge_sd,
    _mm_cmpgt_epi8, _mm_cmpgt_epi16, _mm_cmpgt_epi32,
    _mm_cmpgt_pd, _mm_cmpgt_sd,
    _mm_cmple_pd, _mm_cmple_sd,
    _mm_cmplt_epi8, _mm_cmplt_epi16, _mm_cmplt_epi32,
    _mm_cmplt_pd, _mm_cmplt_sd,
    _mm_cmpneq_pd, _mm_cmpneq_sd,
    _mm_cmpnge_pd, _mm_cmpnge_sd,
    _mm_cmpngt_pd, _mm_cmpngt_sd,
    _mm_cmpnle_pd, _mm_cmpnle_sd,
    _mm_cmpnlt_pd, _mm_cmpnlt_sd,
    _mm_cmpord_pd, _mm_cmpord_sd,
    _mm_cmpunord_pd, _mm_cmpunord_sd,
    _mm_comieq_sd, _mm_comige_sd, _mm_comigt_sd, _mm_comile_sd, _mm_comilt_sd, _mm_comineq_sd,
    _mm_cvtepi32_pd, _mm_cvtepi32_ps,
    _mm_cvtpd_epi32, _mm_cvtpd_ps,
    _mm_cvtps_epi32, _mm_cvtps_pd,
    _mm_cvtsd_f64, _mm_cvtsd_si32, _mm_cvtsd_ss,
    _mm_cvtsi32_sd, _mm_cvtsi32_si128, _mm_cvtsi128_si32,
    _mm_cvtss_sd,
    _mm_cvttpd_epi32, _mm_cvttps_epi32, _mm_cvttsd_si32,
    _mm_div_pd, _mm_div_sd,
    _mm_extract_epi16,
    _mm_insert_epi16,
    _mm_lfence,
    _mm_load_pd, _mm_load_pd1, _mm_load_sd, _mm_load_si128, _mm_load1_pd,
    _mm_loadh_pd, _mm_loadl_epi64, _mm_loadl_pd, _mm_loadr_pd,
    _mm_loadu_pd, _mm_loadu_si128, _mm_loadu_si16, _mm_loadu_si32, _mm_loadu_si64,
    _mm_madd_epi16,
    _mm_maskmoveu_si128,
    _mm_max_epi16, _mm_max_epu8, _mm_max_pd, _mm_max_sd,
    _mm_mfence,
    _mm_min_epi16, _mm_min_epu8, _mm_min_pd, _mm_min_sd,
    _mm_move_epi64, _mm_move_sd,
    _mm_movemask_epi8, _mm_movemask_pd,
    _mm_mul_epu32, _mm_mul_pd, _mm_mul_sd,
    _mm_mulhi_epi16, _mm_mulhi_epu16, _mm_mullo_epi16,
    _mm_or_pd, _mm_or_si128,
    _mm_packs_epi16, _mm_packs_epi32, _mm_packus_epi16,
    _mm_pause,
    _mm_sad_epu8,
    _mm_set_epi8, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x,
    _mm_set_pd, _mm_set_pd1, _mm_set_sd,
    _mm_set1_epi8, _mm_set1_epi16, _mm_set1_epi32, _mm_set1_epi64x, _mm_set1_pd,
    _mm_setr_epi8, _mm_setr_epi16, _mm_setr_epi32, _mm_setr_pd,
    _mm_setzero_pd, _mm_setzero_si128,
    _mm_shuffle_epi32, _mm_shuffle_pd, _mm_shufflehi_epi16, _mm_shufflelo_epi16,
    _mm_sll_epi16, _mm_sll_epi32, _mm_sll_epi64,
    _mm_slli_epi16, _mm_slli_epi32, _mm_slli_epi64, _mm_slli_si128,
    _mm_sqrt_pd, _mm_sqrt_sd,
    _mm_sra_epi16, _mm_sra_epi32,
    _mm_srai_epi16, _mm_srai_epi32,
    _mm_srl_epi16, _mm_srl_epi32, _mm_srl_epi64,
    _mm_srli_epi16, _mm_srli_epi32, _mm_srli_epi64, _mm_srli_si128,
    _mm_store_pd, _mm_store_pd1, _mm_store_sd, _mm_store_si128, _mm_store1_pd,
    _mm_storeh_pd, _mm_storel_epi64, _mm_storel_pd, _mm_storer_pd,
    _mm_storeu_pd, _mm_storeu_si128, _mm_storeu_si16, _mm_storeu_si32, _mm_storeu_si64,
    _mm_stream_pd, _mm_stream_si32, _mm_stream_si128,
    _mm_sub_epi8, _mm_sub_epi16, _mm_sub_epi32, _mm_sub_epi64, _mm_sub_pd, _mm_sub_sd,
    _mm_subs_epi8, _mm_subs_epi16, _mm_subs_epu8, _mm_subs_epu16,
    _mm_ucomieq_sd, _mm_ucomige_sd, _mm_ucomigt_sd, _mm_ucomile_sd, _mm_ucomilt_sd, _mm_ucomineq_sd,
    _mm_undefined_pd, _mm_undefined_si128,
    _mm_unpackhi_epi8, _mm_unpackhi_epi16, _mm_unpackhi_epi32, _mm_unpackhi_epi64, _mm_unpackhi_pd,
    _mm_unpacklo_epi8, _mm_unpacklo_epi16, _mm_unpacklo_epi32, _mm_unpacklo_epi64, _mm_unpacklo_pd,
    _mm_xor_pd, _mm_xor_si128,
};
#[cfg(target_arch = "x86")]
use std::arch::x86::{
    __m128d, __m128i,
    _mm_add_epi8, _mm_add_epi16, _mm_add_epi32, _mm_add_epi64, _mm_add_pd, _mm_add_sd,
    _mm_adds_epi8, _mm_adds_epi16, _mm_adds_epu8, _mm_adds_epu16,
    _mm_and_si128, _mm_and_pd, _mm_andnot_si128, _mm_andnot_pd,
    _mm_avg_epu8, _mm_avg_epu16,
    _mm_bslli_si128, _mm_bsrli_si128,
    _mm_castpd_ps, _mm_castpd_si128, _mm_castps_pd, _mm_castps_si128,
    _mm_castsi128_pd, _mm_castsi128_ps,
    _mm_clflush,
    _mm_cmpeq_epi8, _mm_cmpeq_epi16, _mm_cmpeq_epi32,
    _mm_cmpeq_pd, _mm_cmpeq_sd,
    _mm_cmpge_pd, _mm_cmpge_sd,
    _mm_cmpgt_epi8, _mm_cmpgt_epi16, _mm_cmpgt_epi32,
    _mm_cmpgt_pd, _mm_cmpgt_sd,
    _mm_cmple_pd, _mm_cmple_sd,
    _mm_cmplt_epi8, _mm_cmplt_epi16, _mm_cmplt_epi32,
    _mm_cmplt_pd, _mm_cmplt_sd,
    _mm_cmpneq_pd, _mm_cmpneq_sd,
    _mm_cmpnge_pd, _mm_cmpnge_sd,
    _mm_cmpngt_pd, _mm_cmpngt_sd,
    _mm_cmpnle_pd, _mm_cmpnle_sd,
    _mm_cmpnlt_pd, _mm_cmpnlt_sd,
    _mm_cmpord_pd, _mm_cmpord_sd,
    _mm_cmpunord_pd, _mm_cmpunord_sd,
    _mm_comieq_sd, _mm_comige_sd, _mm_comigt_sd, _mm_comile_sd, _mm_comilt_sd, _mm_comineq_sd,
    _mm_cvtepi32_pd, _mm_cvtepi32_ps,
    _mm_cvtpd_epi32, _mm_cvtpd_ps,
    _mm_cvtps_epi32, _mm_cvtps_pd,
    _mm_cvtsd_f64, _mm_cvtsd_si32, _mm_cvtsd_ss,
    _mm_cvtsi32_sd, _mm_cvtsi32_si128, _mm_cvtsi128_si32,
    _mm_cvtss_sd,
    _mm_cvttpd_epi32, _mm_cvttps_epi32, _mm_cvttsd_si32,
    _mm_div_pd, _mm_div_sd,
    _mm_extract_epi16,
    _mm_insert_epi16,
    _mm_lfence,
    _mm_load_pd, _mm_load_pd1, _mm_load_sd, _mm_load_si128, _mm_load1_pd,
    _mm_loadh_pd, _mm_loadl_epi64, _mm_loadl_pd, _mm_loadr_pd,
    _mm_loadu_pd, _mm_loadu_si128, _mm_loadu_si16, _mm_loadu_si32, _mm_loadu_si64,
    _mm_madd_epi16,
    _mm_maskmoveu_si128,
    _mm_max_epi16, _mm_max_epu8, _mm_max_pd, _mm_max_sd,
    _mm_mfence,
    _mm_min_epi16, _mm_min_epu8, _mm_min_pd, _mm_min_sd,
    _mm_move_epi64, _mm_move_sd,
    _mm_movemask_epi8, _mm_movemask_pd,
    _mm_mul_epu32, _mm_mul_pd, _mm_mul_sd,
    _mm_mulhi_epi16, _mm_mulhi_epu16, _mm_mullo_epi16,
    _mm_or_pd, _mm_or_si128,
    _mm_packs_epi16, _mm_packs_epi32, _mm_packus_epi16,
    _mm_pause,
    _mm_sad_epu8,
    _mm_set_epi8, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x,
    _mm_set_pd, _mm_set_pd1, _mm_set_sd,
    _mm_set1_epi8, _mm_set1_epi16, _mm_set1_epi32, _mm_set1_epi64x, _mm_set1_pd,
    _mm_setr_epi8, _mm_setr_epi16, _mm_setr_epi32, _mm_setr_pd,
    _mm_setzero_pd, _mm_setzero_si128,
    _mm_shuffle_epi32, _mm_shuffle_pd, _mm_shufflehi_epi16, _mm_shufflelo_epi16,
    _mm_sll_epi16, _mm_sll_epi32, _mm_sll_epi64,
    _mm_slli_epi16, _mm_slli_epi32, _mm_slli_epi64, _mm_slli_si128,
    _mm_sqrt_pd, _mm_sqrt_sd,
    _mm_sra_epi16, _mm_sra_epi32,
    _mm_srai_epi16, _mm_srai_epi32,
    _mm_srl_epi16, _mm_srl_epi32, _mm_srl_epi64,
    _mm_srli_epi16, _mm_srli_epi32, _mm_srli_epi64, _mm_srli_si128,
    _mm_store_pd, _mm_store_pd1, _mm_store_sd, _mm_store_si128, _mm_store1_pd,
    _mm_storeh_pd, _mm_storel_epi64, _mm_storel_pd, _mm_storer_pd,
    _mm_storeu_pd, _mm_storeu_si128, _mm_storeu_si16, _mm_storeu_si32, _mm_storeu_si64,
    _mm_stream_pd, _mm_stream_si32, _mm_stream_si128,
    _mm_sub_epi8, _mm_sub_epi16, _mm_sub_epi32, _mm_sub_epi64, _mm_sub_pd, _mm_sub_sd,
    _mm_subs_epi8, _mm_subs_epi16, _mm_subs_epu8, _mm_subs_epu16,
    _mm_ucomieq_sd, _mm_ucomige_sd, _mm_ucomigt_sd, _mm_ucomile_sd, _mm_ucomilt_sd, _mm_ucomineq_sd,
    _mm_undefined_pd, _mm_undefined_si128,
    _mm_unpackhi_epi8, _mm_unpackhi_epi16, _mm_unpackhi_epi32, _mm_unpackhi_epi64, _mm_unpackhi_pd,
    _mm_unpacklo_epi8, _mm_unpacklo_epi16, _mm_unpacklo_epi32, _mm_unpacklo_epi64, _mm_unpacklo_pd,
    _mm_xor_pd, _mm_xor_si128,
};

use log::info;

use crate::cpu::{check_array_equality, ExtensionTest, get_iterations};
use crate::{get_four_random_floats, get_fuzzing, get_random_float};

pub struct SSE2;

impl ExtensionTest for SSE2 {
    fn get_name() -> &'static str {
        "SSE2"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            // Original tests
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
            // New tests - Memory operations
            (&test_mm_pause, "test_mm_pause"),
            (&test_mm_lfence, "test_mm_lfence"),
            (&test_mm_mfence, "test_mm_mfence"),
            // New tests - Integer arithmetic
            (&test_mm_add_epi8, "test_mm_add_epi8"),
            (&test_mm_add_epi16, "test_mm_add_epi16"),
            (&test_mm_add_epi64, "test_mm_add_epi64"),
            (&test_mm_adds_epi8, "test_mm_adds_epi8"),
            (&test_mm_adds_epi16, "test_mm_adds_epi16"),
            (&test_mm_adds_epu8, "test_mm_adds_epu8"),
            (&test_mm_adds_epu16, "test_mm_adds_epu16"),
            (&test_mm_sub_epi8, "test_mm_sub_epi8"),
            (&test_mm_sub_epi16, "test_mm_sub_epi16"),
            (&test_mm_sub_epi64, "test_mm_sub_epi64"),
            (&test_mm_subs_epi8, "test_mm_subs_epi8"),
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
            // Shift operations
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
            // Comparisons
            (&test_mm_cmpeq_epi8, "test_mm_cmpeq_epi8"),
            (&test_mm_cmpeq_epi16, "test_mm_cmpeq_epi16"),
            (&test_mm_cmpgt_epi8, "test_mm_cmpgt_epi8"),
            (&test_mm_cmpgt_epi16, "test_mm_cmpgt_epi16"),
            (&test_mm_cmpgt_epi32, "test_mm_cmpgt_epi32"),
            (&test_mm_cmplt_epi8, "test_mm_cmplt_epi8"),
            (&test_mm_cmplt_epi16, "test_mm_cmplt_epi16"),
            (&test_mm_cmplt_epi32, "test_mm_cmplt_epi32"),
            // Set operations
            (&test_mm_set_epi8, "test_mm_set_epi8"),
            (&test_mm_set_epi16, "test_mm_set_epi16"),
            (&test_mm_set_epi64x, "test_mm_set_epi64x"),
            (&test_mm_set1_epi8, "test_mm_set1_epi8"),
            (&test_mm_set1_epi16, "test_mm_set1_epi16"),
            (&test_mm_set1_epi64x, "test_mm_set1_epi64x"),
            (&test_mm_setr_epi8, "test_mm_setr_epi8"),
            (&test_mm_setr_epi16, "test_mm_setr_epi16"),
            (&test_mm_setr_epi32, "test_mm_setr_epi32"),
            // Load/Store operations
            (&test_mm_loadl_epi64, "test_mm_loadl_epi64"),
            (&test_mm_load_si128, "test_mm_load_si128"),
            (&test_mm_loadu_si128, "test_mm_loadu_si128"),
            (&test_mm_store_si128, "test_mm_store_si128"),
            (&test_mm_storeu_si128, "test_mm_storeu_si128"),
            (&test_mm_storel_epi64, "test_mm_storel_epi64"),
            // Pack/Unpack operations
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
            // Shuffle operations
            (&test_mm_shuffle_epi32, "test_mm_shuffle_epi32"),
            (&test_mm_shufflehi_epi16, "test_mm_shufflehi_epi16"),
            (&test_mm_shufflelo_epi16, "test_mm_shufflelo_epi16"),
            // Extract/Insert
            (&test_mm_extract_epi16, "test_mm_extract_epi16"),
            (&test_mm_insert_epi16, "test_mm_insert_epi16"),
            (&test_mm_movemask_epi8, "test_mm_movemask_epi8"),
            // Conversion operations
            (&test_mm_cvtepi32_pd, "test_mm_cvtepi32_pd"),
            (&test_mm_cvtepi32_ps, "test_mm_cvtepi32_ps"),
            (&test_mm_cvtpd_epi32, "test_mm_cvtpd_epi32"),
            (&test_mm_cvtps_epi32, "test_mm_cvtps_epi32"),
            (&test_mm_cvttpd_epi32, "test_mm_cvttpd_epi32"),
            (&test_mm_cvttps_epi32, "test_mm_cvttps_epi32"),
            // Double precision FP operations
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

fn test_mm_set_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set_pd(1.0, 2.0);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(
            &[result[0] as f32, result[1] as f32],
            &[2.0, 1.0],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float() as f64;
                let b = get_random_float() as f64;
                let result = _mm_set_pd(b, a);
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[a as f32, b as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_set1_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_pd(3.13);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[3.13, 3.13])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as f64;
                let result = _mm_set1_pd(value);
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[value as f32, value as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_setzero_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_pd();
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[0.0, 0.0])?;
    }
    Ok(())
}

fn test_mm_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_add_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[6.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_add_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(5.0, 6.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_sub_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[2.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_sub_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(4.0, 5.0);
        let result = _mm_mul_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&[result[0] as f32, result[1] as f32], &[15.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_mul_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_load_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([1.0, 2.0]);
        let result = _mm_load_pd(data.0.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(
            &[result[0] as f32, result[1] as f32],
            &[data.0[0] as f32, data.0[1] as f32],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let result = _mm_load_pd(data.0.as_ptr());
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[data.0[0] as f32, data.0[1] as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_loadu_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let result = _mm_loadu_pd(data.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(
            &[result[0] as f32, result[1] as f32],
            &[data[0] as f32, data[1] as f32],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = [get_random_float() as f64, get_random_float() as f64];
                let result = _mm_loadu_pd(data.as_ptr());
                let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
                check_array_equality(
                    &[result[0] as f32, result[1] as f32],
                    &[data[0] as f32, data[1] as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_store_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([1.0, 2.0]);
        let mut result = AlignedData([0.0; 2]);
        let vec = _mm_loadu_pd(data.0.as_ptr());
        _mm_store_pd(result.0.as_mut_ptr(), vec);
        check_array_equality(
            &[result.0[0] as f32, result.0[1] as f32],
            &[data.0[0] as f32, data.0[1] as f32],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let mut result = AlignedData([0.0; 2]);
                let vec = _mm_loadu_pd(data.0.as_ptr());
                _mm_store_pd(result.0.as_mut_ptr(), vec);
                check_array_equality(
                    &[result.0[0] as f32, result.0[1] as f32],
                    &[data.0[0] as f32, data.0[1] as f32],
                )?;
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsd_f64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let result = _mm_cvtsd_f64(a);
        if (result - 2.0).abs() > 0.001 {
            return Err(format!("Expected 2.0, got {}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as f64;
                let vec = _mm_set_pd(get_random_float() as f64, value);
                let result = _mm_cvtsd_f64(vec);
                if (result - value).abs() > 0.001 && !result.is_nan() && !value.is_nan() {
                    return Err(format!("Expected {}, got {}", value, result));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_set_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi32(1, 2, 3, 4);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [4, 3, 2, 1] {
            return Err(format!("Expected [4, 3, 2, 1], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let values = [
                    get_random_float() as i32,
                    get_random_float() as i32,
                    get_random_float() as i32,
                    get_random_float() as i32,
                ];
                let result = _mm_set_epi32(values[3], values[2], values[1], values[0]);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                if result != values {
                    return Err(format!("Expected {:?}, got {:?}", values, result));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_set1_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi32(42);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [42, 42, 42, 42] {
            return Err(format!("Expected [42, 42, 42, 42], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let result = _mm_set1_epi32(value);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                if result != [value, value, value, value] {
                    return Err(format!(
                        "Expected [{}, {}, {}, {}], got {:?}",
                        value, value, value, value, result
                    ));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_setzero_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_si128();
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0, 0, 0, 0] {
            return Err(format!("Expected [0, 0, 0, 0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_add_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [12, 10, 8, 6] {
            return Err(format!("Expected [12, 10, 8, 6], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_add_epi32(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_sub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 20, 30, 40);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_sub_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [32, 23, 14, 5] {
            return Err(format!("Expected [32, 23, 14, 5], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_sub_epi32(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_and_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_and_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0x00, 0x00, 0x00, 0xFF] {
            return Err(format!("Expected [0, 0, 0, 255], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_and_si128(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_or_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0x00, 0x00, 0x00);
        let b = _mm_set_epi32(0x00, 0xFF, 0x00, 0x00);
        let result = _mm_or_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0x00, 0x00, 0xFF, 0xFF] {
            return Err(format!("Expected [0, 0, 255, 255], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_or_si128(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_xor_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_xor_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [0x00, 0xFF, 0xFF, 0x00] {
            return Err(format!("Expected [0, 255, 255, 0], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_xor_si128(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(b[3], b[2], b[1], b[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_cmpeq_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 2, 3, 4);
        let result = _mm_cmpeq_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [-1, -1, -1, -1] {
            return Err(format!("Expected [-1, -1, -1, -1], got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_cmpeq_epi32(
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                    _mm_set_epi32(a[3], a[2], a[1], a[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsi32_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi32_si128(42);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result[0] != 42 {
            return Err(format!("Expected 42 in first element, got {:?}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let result = _mm_cvtsi32_si128(value);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                if result[0] != value {
                    return Err(format!("Expected {} in first element, got {:?}", value, result));
                }
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsi128_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 42);
        let result = _mm_cvtsi128_si32(a);
        if result != 42 {
            return Err(format!("Expected 42, got {}", result));
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let vec = _mm_set_epi32(
                    get_random_float() as i32,
                    get_random_float() as i32,
                    get_random_float() as i32,
                    value,
                );
                let result = _mm_cvtsi128_si32(vec);
                if result != value {
                    return Err(format!("Expected {}, got {}", value, result));
                }
            }
        }
    }

    Ok(())
}

// ============ NEW FUNCTION IMPLEMENTATIONS ============

// Memory operations
fn test_mm_pause() -> Result<(), String> {
    unsafe {
        _mm_pause();
    }
    Ok(())
}

fn test_mm_lfence() -> Result<(), String> {
    unsafe {
        _mm_lfence();
    }
    Ok(())
}

fn test_mm_mfence() -> Result<(), String> {
    unsafe {
        _mm_mfence();
    }
    Ok(())
}

// Integer arithmetic - 8-bit
fn test_mm_add_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_add_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [17; 16];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_add_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_add_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [9; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_add_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let b = _mm_set_epi64x(50, 75);
        let result = _mm_add_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        if result != [275, 150] {
            return Err(format!("Expected [275, 150], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_adds_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(100);
        let b = _mm_set1_epi8(50);
        let result = _mm_adds_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // All should be 127 (saturated)
        if result[0] != 127 {
            return Err(format!("Expected saturation to 127, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_adds_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(30000);
        let b = _mm_set1_epi16(5000);
        let result = _mm_adds_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Should saturate to 32767
        if result[0] != 32767 {
            return Err(format!("Expected saturation to 32767, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_adds_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(-56 as i8); // 200 as unsigned
        let b = _mm_set1_epi8(-56 as i8);
        let result = _mm_adds_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        // Should saturate to 255
        if result[0] != 255 {
            return Err(format!("Expected saturation to 255, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_adds_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-5536 as i16); // 60000 as unsigned
        let b = _mm_set1_epi16(10000 as i16);
        let result = _mm_adds_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        // Should saturate to 65535
        if result[0] != 65535 {
            return Err(format!("Expected saturation to 65535, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_sub_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(20);
        let b = _mm_set1_epi8(10);
        let result = _mm_sub_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [10; 16];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_sub_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(30);
        let result = _mm_sub_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [70; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_sub_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let b = _mm_set_epi64x(30, 50);
        let result = _mm_sub_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        if result != [150, 70] {
            return Err(format!("Expected [150, 70], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_subs_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(-100);
        let b = _mm_set1_epi8(50);
        let result = _mm_subs_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // Should saturate to -128
        if result[0] != -128 {
            return Err(format!("Expected saturation to -128, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_subs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-30000);
        let b = _mm_set1_epi16(5000);
        let result = _mm_subs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Should saturate to -32768
        if result[0] != -32768 {
            return Err(format!("Expected saturation to -32768, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_subs_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(20);
        let result = _mm_subs_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        // Should saturate to 0
        if result[0] != 0 {
            return Err(format!("Expected saturation to 0, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_subs_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(200);
        let result = _mm_subs_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        // Should saturate to 0
        if result[0] != 0 {
            return Err(format!("Expected saturation to 0, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_avg_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(100 as i8);
        let b = _mm_set1_epi8(50 as i8);
        let result = _mm_avg_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        // Average should be 75
        if result[0] != 75 {
            return Err(format!("Expected 75, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_avg_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(500);
        let result = _mm_avg_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        // Average should be 750
        if result[0] != 750 {
            return Err(format!("Expected 750, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_madd_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_madd_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // [1*8 + 2*7, 3*6 + 4*5, 5*4 + 6*3, 7*2 + 8*1] = [22, 38, 38, 22]
        let expected = [22, 38, 38, 22];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_max_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 20, 3, 40, 5, 60, 7, 80);
        let b = _mm_set_epi16(10, 2, 30, 4, 50, 6, 70, 8);
        let result = _mm_max_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [80, 70, 60, 50, 40, 30, 20, 10];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_max_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_max_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let expected = [16, 15, 14, 13, 12, 11, 10, 9, 9, 10, 11, 12, 13, 14, 15, 16];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_min_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 20, 3, 40, 5, 60, 7, 80);
        let b = _mm_set_epi16(10, 2, 30, 4, 50, 6, 70, 8);
        let result = _mm_min_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [8, 7, 6, 5, 4, 3, 2, 1];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_min_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_min_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let expected = [1, 2, 3, 4, 5, 6, 7, 8, 8, 7, 6, 5, 4, 3, 2, 1];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_mulhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(100);
        let result = _mm_mulhi_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // (1000 * 100) >> 16 = 100000 >> 16 = 1
        if result[0] != 1 {
            return Err(format!("Expected 1, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_mulhi_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(100);
        let result = _mm_mulhi_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        // (1000 * 100) >> 16 = 100000 >> 16 = 1
        if result[0] != 1 {
            return Err(format!("Expected 1, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_mullo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(10);
        let b = _mm_set1_epi16(5);
        let result = _mm_mullo_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [50; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_mul_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 100, 0, 200);
        let b = _mm_set_epi32(0, 5, 0, 3);
        let result = _mm_mul_epu32(a, b);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        // Multiply lower 32-bit: 200*3=600, 100*5=500
        if result != [600, 500] {
            return Err(format!("Expected [600, 500], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_sad_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_sad_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        // Sum of absolute differences for 8 bytes = 8 * 5 = 40
        if result[0] != 40 {
            return Err(format!("Expected 40 in first element, got {}", result[0]));
        }
    }
    Ok(())
}

// Shift operations
fn test_mm_slli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_slli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        // Shift left by 4 bytes
        if result[0] != 0 || result[1] != 0 || result[2] != 0 || result[3] != 0 {
            return Err(format!("Expected first 4 bytes to be 0, got {:?}", &result[..4]));
        }
    }
    Ok(())
}

fn test_mm_srli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_srli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        // Shift right by 4 bytes
        let last_4 = &result[12..16];
        if last_4 != [0, 0, 0, 0] {
            return Err(format!("Expected last 4 bytes to be 0, got {:?}", last_4));
        }
    }
    Ok(())
}

fn test_mm_slli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let result = _mm_slli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let result = _mm_slli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [8; 4];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_slli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let result = _mm_slli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [16; 2];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_srai_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-16);
        let result = _mm_srai_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-4; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_srai_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(-32);
        let result = _mm_srai_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-4; 4];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_srli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(16);
        let result = _mm_srli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(32);
        let result = _mm_srli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [4; 4];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_srli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(64);
        let result = _mm_srli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [4; 2];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

// Comparison operations
fn test_mm_cmpeq_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(42);
        let b = _mm_set1_epi8(42);
        let result = _mm_cmpeq_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_cmpeq_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(42);
        let b = _mm_set1_epi16(42);
        let result = _mm_cmpeq_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_cmpgt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_cmpgt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_cmpgt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(50);
        let result = _mm_cmpgt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_cmpgt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1000);
        let b = _mm_set1_epi32(500);
        let result = _mm_cmpgt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-1; 4];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_cmplt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(5);
        let b = _mm_set1_epi8(10);
        let result = _mm_cmplt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_cmplt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(50);
        let b = _mm_set1_epi16(100);
        let result = _mm_cmplt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_cmplt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(500);
        let b = _mm_set1_epi32(1000);
        let result = _mm_cmplt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-1; 4];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

// Set operations
fn test_mm_set_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_set_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_set_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi64x(100, 200);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        if result != [200, 100] {
            return Err(format!("Expected [200, 100], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi8(42);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [42; 16];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi16(42);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [42; 8];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_set1_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi64x(42);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [42; 2];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_setr_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_setr_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi16(0, 1, 2, 3, 4, 5, 6, 7);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

fn test_mm_setr_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi32(0, 1, 2, 3);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 1, 2, 3];
        if result != expected {
            return Err(format!("Expected {:?}, got {:?}", expected, result));
        }
    }
    Ok(())
}

// Load/Store operations
fn test_mm_loadl_epi64() -> Result<(), String> {
    unsafe {
        let data: [i64; 2] = [42, 100];
        let result = _mm_loadl_epi64(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        if result[0] != 42 {
            return Err(format!("Expected 42 in first element, got {}", result[0]));
        }
    }
    Ok(())
}

fn test_mm_load_si128() -> Result<(), String> {
    unsafe {
        let data: [i32; 4] = [1, 2, 3, 4];
        let result = _mm_load_si128(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [1, 2, 3, 4] {
            return Err(format!("Expected [1, 2, 3, 4], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_loadu_si128() -> Result<(), String> {
    unsafe {
        let data: [i32; 4] = [10, 20, 30, 40];
        let result = _mm_loadu_si128(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [10, 20, 30, 40] {
            return Err(format!("Expected [10, 20, 30, 40], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_store_si128() -> Result<(), String> {
    unsafe {
        let mut data: [i32; 4] = [0; 4];
        let vec = _mm_set_epi32(4, 3, 2, 1);
        _mm_store_si128(data.as_mut_ptr() as *mut __m128i, vec);
        if data != [1, 2, 3, 4] {
            return Err(format!("Expected [1, 2, 3, 4], got {:?}", data));
        }
    }
    Ok(())
}

fn test_mm_storeu_si128() -> Result<(), String> {
    unsafe {
        let mut data: [i32; 4] = [0; 4];
        let vec = _mm_set_epi32(40, 30, 20, 10);
        _mm_storeu_si128(data.as_mut_ptr() as *mut __m128i, vec);
        if data != [10, 20, 30, 40] {
            return Err(format!("Expected [10, 20, 30, 40], got {:?}", data));
        }
    }
    Ok(())
}

fn test_mm_storel_epi64() -> Result<(), String> {
    unsafe {
        let mut data: [i64; 2] = [0; 2];
        let vec = _mm_set_epi64x(100, 42);
        _mm_storel_epi64(data.as_mut_ptr() as *mut __m128i, vec);
        if data[0] != 42 {
            return Err(format!("Expected 42 in first element, got {}", data[0]));
        }
    }
    Ok(())
}

// Pack/Unpack operations
fn test_mm_packs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(200, 150, 100, 50, 10, -10, -50, -100);
        let b = _mm_set_epi16(127, 126, 125, 124, -128, -127, -126, -125);
        let result = _mm_packs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // Values should be saturated to i8 range
        if result[0] != -100 || result[7] != 127 {
            return Err(format!("Unexpected packed result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_packs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(40000, 30000, 10, -10);
        let b = _mm_set_epi32(32767, 32766, -32768, -32767);
        let result = _mm_packs_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Values should be saturated to i16 range
        if result[0] != -10 || result[1] != 10 {
            return Err(format!("Unexpected packed result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_packus_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(300, 200, 100, 50, 10, 5, 2, 1);
        let b = _mm_set_epi16(255, 254, 253, 252, -1, -2, -3, -4);
        let result = _mm_packus_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        // Negative values saturate to 0, >255 saturate to 255
        if result[0] != 1 || result[15] != 255 {
            return Err(format!("Unexpected packed result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpackhi_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpackhi_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // Interleave high bytes
        if result[0] != 8 || result[1] != 24 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpackhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpackhi_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Interleave high words
        if result[0] != 4 || result[1] != 12 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpackhi_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // Interleave high dwords
        if result[0] != 2 || result[1] != 6 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpackhi_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpackhi_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        // Interleave high qwords
        if result[0] != 1 || result[1] != 3 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpacklo_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // Interleave low bytes
        if result[0] != 0 || result[1] != 16 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpacklo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpacklo_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Interleave low words
        if result[0] != 0 || result[1] != 8 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpacklo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpacklo_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // Interleave low dwords
        if result[0] != 0 || result[1] != 4 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_unpacklo_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpacklo_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        // Interleave low qwords
        if result[0] != 0 || result[1] != 2 {
            return Err(format!("Unexpected unpack result: {:?}", result));
        }
    }
    Ok(())
}

// Shuffle operations
fn test_mm_shuffle_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_shuffle_epi32::<0b00011011>(a);  // Reverse order
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result != [3, 2, 1, 0] {
            return Err(format!("Expected [3, 2, 1, 0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_shufflehi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflehi_epi16::<0b00011011>(a);  // Shuffle high 4 words
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Low 4 words unchanged, high 4 shuffled
        if result[0] != 0 || result[1] != 1 || result[2] != 2 || result[3] != 3 {
            return Err(format!("Low words changed unexpectedly: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_shufflelo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflelo_epi16::<0b00011011>(a);  // Shuffle low 4 words
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // High 4 words unchanged
        if result[4] != 4 || result[5] != 5 || result[6] != 6 || result[7] != 7 {
            return Err(format!("High words changed unexpectedly: {:?}", result));
        }
    }
    Ok(())
}

// Extract/Insert operations
fn test_mm_extract_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_extract_epi16::<3>(a);
        if result != 3 {
            return Err(format!("Expected 3, got {}", result));
        }
    }
    Ok(())
}

fn test_mm_insert_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_insert_epi16::<3>(a, 99);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        if result[3] != 99 {
            return Err(format!("Expected 99 at index 3, got {}", result[3]));
        }
    }
    Ok(())
}

fn test_mm_movemask_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0);
        let result = _mm_movemask_epi8(a);
        // Should be 0b1010101010101010 = 0xAAAA
        if result != 0xAAAA {
            return Err(format!("Expected 0xAAAA, got 0x{:X}", result));
        }
    }
    Ok(())
}

// Conversion operations
fn test_mm_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 20, 10);
        let result = _mm_cvtepi32_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        if (result[0] - 10.0).abs() > 0.001 || (result[1] - 20.0).abs() > 0.001 {
            return Err(format!("Expected [10.0, 20.0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_cvtepi32_ps(a);
        let result = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
        if (result[0] - 1.0).abs() > 0.001 || (result[3] - 4.0).abs() > 0.001 {
            return Err(format!("Expected [1.0, 2.0, 3.0, 4.0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // Rounds to nearest even
        if result[0] != 10 || result[1] != 21 {
            return Err(format!("Expected [10, 21, 0, 0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result[0] != 1 || result[1] != 2 {
            return Err(format!("Unexpected conversion result: {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.9, 10.9);
        let result = _mm_cvttpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // Truncates toward zero
        if result[0] != 10 || result[1] != 20 {
            return Err(format!("Expected [10, 20, 0, 0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.9, 1.9);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvttps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // Truncates toward zero
        if result[0] != 1 || result[1] != 2 {
            return Err(format!("Expected truncation, got {:?}", result));
        }
    }
    Ok(())
}

// Double precision floating point operations
fn test_mm_add_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_add_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        if (result_f64 - 15.0).abs() > 0.001 {
            return Err(format!("Expected 15.0, got {}", result_f64));
        }
    }
    Ok(())
}

fn test_mm_div_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(20.0);
        let b = _mm_set_sd(4.0);
        let result = _mm_div_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        if (result_f64 - 5.0).abs() > 0.001 {
            return Err(format!("Expected 5.0, got {}", result_f64));
        }
    }
    Ok(())
}

fn test_mm_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.0, 10.0);
        let b = _mm_set_pd(4.0, 2.0);
        let result = _mm_div_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        if (result[0] - 5.0).abs() > 0.001 || (result[1] - 5.0).abs() > 0.001 {
            return Err(format!("Expected [5.0, 5.0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_max_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_max_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        if (result_f64 - 10.0).abs() > 0.001 {
            return Err(format!("Expected 10.0, got {}", result_f64));
        }
    }
    Ok(())
}

fn test_mm_max_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_max_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        if (result[0] - 7.0).abs() > 0.001 || (result[1] - 10.0).abs() > 0.001 {
            return Err(format!("Expected [7.0, 10.0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_min_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_min_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        if (result_f64 - 5.0).abs() > 0.001 {
            return Err(format!("Expected 5.0, got {}", result_f64));
        }
    }
    Ok(())
}

fn test_mm_min_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_min_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        if (result[0] - 5.0).abs() > 0.001 || (result[1] - 8.0).abs() > 0.001 {
            return Err(format!("Expected [5.0, 8.0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_mul_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_mul_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        if (result_f64 - 50.0).abs() > 0.001 {
            return Err(format!("Expected 50.0, got {}", result_f64));
        }
    }
    Ok(())
}

fn test_mm_sqrt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(25.0);
        let b = _mm_set_sd(0.0);
        let result = _mm_sqrt_sd(b, a);
        let result_f64 = _mm_cvtsd_f64(result);
        if (result_f64 - 5.0).abs() > 0.001 {
            return Err(format!("Expected 5.0, got {}", result_f64));
        }
    }
    Ok(())
}

fn test_mm_sqrt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(16.0, 25.0);
        let result = _mm_sqrt_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        if (result[0] - 5.0).abs() > 0.001 || (result[1] - 4.0).abs() > 0.001 {
            return Err(format!("Expected [5.0, 4.0], got {:?}", result));
        }
    }
    Ok(())
}

fn test_mm_sub_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(3.0);
        let result = _mm_sub_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        if (result_f64 - 7.0).abs() > 0.001 {
            return Err(format!("Expected 7.0, got {}", result_f64));
        }
    }
    Ok(())
}

fn test_mm_and_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_and_pd(a, b);
        // Just verify it doesn't crash
    }
    Ok(())
}

fn test_mm_andnot_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_andnot_pd(a, b);
        // Just verify it doesn't crash
    }
    Ok(())
}

fn test_mm_or_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_or_pd(a, b);
        // Just verify it doesn't crash
    }
    Ok(())
}

fn test_mm_xor_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_xor_pd(a, b);
        // Just verify it doesn't crash
    }
    Ok(())
}

fn test_mm_andnot_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_andnot_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // (!a) & b
        if result != [0x00, 0xFF, 0x00, 0x00] {
            return Err(format!("Expected [0, 255, 0, 0], got {:?}", result));
        }
    }
    Ok(())
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
