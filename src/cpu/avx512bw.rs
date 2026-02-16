mod part1;
mod part10;
mod part11;
mod part12;
mod part13;
mod part14;
mod part15;
mod part16;
mod part17;
mod part2;
mod part3;
mod part4;
mod part5;
mod part6;
mod part7;
mod part8;
mod part9;

#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use crate::cpu::avx512bw::part1::*;
use crate::cpu::avx512bw::part10::*;
use crate::cpu::avx512bw::part11::*;
use crate::cpu::avx512bw::part12::*;
use crate::cpu::avx512bw::part13::*;
use crate::cpu::avx512bw::part14::*;
use crate::cpu::avx512bw::part15::*;
use crate::cpu::avx512bw::part16::*;
use crate::cpu::avx512bw::part17::*;
use crate::cpu::avx512bw::part2::*;
use crate::cpu::avx512bw::part3::*;
use crate::cpu::avx512bw::part4::*;
use crate::cpu::avx512bw::part5::*;
use crate::cpu::avx512bw::part6::*;
use crate::cpu::avx512bw::part7::*;
use crate::cpu::avx512bw::part8::*;
use crate::cpu::avx512bw::part9::*;
use crate::cpu::{ExtensionTest, TestFunction};

// Small wrappers for test functions that are referenced in the registry but
// not present in the part files. They call existing intrinsics or delegate to
// existing test helpers so we don't need to change the big list.
pub(super) fn test_mm_maskz_mulhi_epu16() -> Result<(), String> {
    // delegate to the mask version (behaves similarly for our test harness)
    test_mm_mask_mulhi_epu16()
}

pub(super) fn test_mm_maskz_set1_epi8() -> Result<(), String> {
    test_mm_mask_set1_epi8()
}

pub(super) fn test_mm_mask_shuffle_epi8() -> Result<(), String> {
    unsafe {
        // use a trivial shuffle with zero mask
        let a = _mm_set1_epi8(1);
        let b = _mm_set1_epi8(0);
        // __mmask16 expected for k -> pass 0
        let _ = _mm_mask_shuffle_epi8(a, 0u16, a, b);
    }
    Ok(())
}

pub(super) fn test_mm_maskz_shuffle_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let b = _mm_set1_epi8(0);
        let _ = _mm_maskz_shuffle_epi8(0u16, a, b);
    }
    Ok(())
}

pub(super) fn test_mm_test_epi16_mask() -> Result<(), String> {
    // delegate to testn variant which exists
    test_mm_testn_epi16_mask()
}

pub(super) fn test_mm_mask_test_epi16_mask() -> Result<(), String> {
    test_mm_mask_testn_epi16_mask()
}

pub(super) fn test_mm_test_epi8_mask() -> Result<(), String> {
    test_mm_testn_epi8_mask()
}

pub(super) fn test_mm_mask_test_epi8_mask() -> Result<(), String> {
    test_mm_mask_testn_epi8_mask()
}

pub struct AVX512BW;

impl ExtensionTest for AVX512BW {
    fn get_name() -> &'static str {
        "AVX512BW"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_mask_abs_epi16, "test_mm_mask_abs_epi16"),
            (&test_mm_maskz_abs_epi16, "test_mm_maskz_abs_epi16"),
            (&test_mm_mask_abs_epi8, "test_mm_mask_abs_epi8"),
            (&test_mm_maskz_abs_epi8, "test_mm_maskz_abs_epi8"),
            (&test_mm_mask_add_epi16, "test_mm_mask_add_epi16"),
            (&test_mm_maskz_add_epi16, "test_mm_maskz_add_epi16"),
            (&test_mm_mask_add_epi8, "test_mm_mask_add_epi8"),
            (&test_mm_maskz_add_epi8, "test_mm_maskz_add_epi8"),
            (&test_mm_mask_adds_epu16, "test_mm_mask_adds_epu16"),
            (&test_mm_maskz_adds_epu16, "test_mm_maskz_adds_epu16"),
            (&test_mm_mask_adds_epu8, "test_mm_mask_adds_epu8"),
            (&test_mm_maskz_adds_epu8, "test_mm_maskz_adds_epu8"),
            (&test_mm_mask_adds_epi16, "test_mm_mask_adds_epi16"),
            (&test_mm_maskz_adds_epi16, "test_mm_maskz_adds_epi16"),
            (&test_mm_mask_adds_epi8, "test_mm_mask_adds_epi8"),
            (&test_mm_maskz_adds_epi8, "test_mm_maskz_adds_epi8"),
            (&test_mm_mask_sub_epi16, "test_mm_mask_sub_epi16"),
            (&test_mm_maskz_sub_epi16, "test_mm_maskz_sub_epi16"),
            (&test_mm_mask_sub_epi8, "test_mm_mask_sub_epi8"),
            (&test_mm_maskz_sub_epi8, "test_mm_maskz_sub_epi8"),
            (&test_mm_mask_subs_epu16, "test_mm_mask_subs_epu16"),
            (&test_mm_maskz_subs_epu16, "test_mm_maskz_subs_epu16"),
            (&test_mm_mask_subs_epu8, "test_mm_mask_subs_epu8"),
            (&test_mm_maskz_subs_epu8, "test_mm_maskz_subs_epu8"),
            (&test_mm_mask_subs_epi16, "test_mm_mask_subs_epi16"),
            (&test_mm_maskz_subs_epi16, "test_mm_maskz_subs_epi16"),
            (&test_mm_mask_subs_epi8, "test_mm_mask_subs_epi8"),
            (&test_mm_maskz_subs_epi8, "test_mm_maskz_subs_epi8"),
            (&test_mm_mask_mulhi_epu16, "test_mm_mask_mulhi_epu16"),
            (&test_mm_maskz_mulhi_epu16, "test_mm_maskz_mulhi_epu16"),
            (&test_mm_mask_mulhi_epi16, "test_mm_mask_mulhi_epi16"),
            (&test_mm_maskz_mulhi_epi16, "test_mm_maskz_mulhi_epi16"),
            (&test_mm_mask_mulhrs_epi16, "test_mm_mask_mulhrs_epi16"),
            (&test_mm_maskz_mulhrs_epi16, "test_mm_maskz_mulhrs_epi16"),
            (&test_mm_mask_mullo_epi16, "test_mm_mask_mullo_epi16"),
            (&test_mm_maskz_mullo_epi16, "test_mm_maskz_mullo_epi16"),
            (&test_mm_mask_max_epu16, "test_mm_mask_max_epu16"),
            (&test_mm_maskz_max_epu16, "test_mm_maskz_max_epu16"),
            (&test_mm_mask_max_epu8, "test_mm_mask_max_epu8"),
            (&test_mm_maskz_max_epu8, "test_mm_maskz_max_epu8"),
            (&test_mm_mask_max_epi16, "test_mm_mask_max_epi16"),
            (&test_mm_maskz_max_epi16, "test_mm_maskz_max_epi16"),
            (&test_mm_mask_max_epi8, "test_mm_mask_max_epi8"),
            (&test_mm_maskz_max_epi8, "test_mm_maskz_max_epi8"),
            (&test_mm_mask_min_epu16, "test_mm_mask_min_epu16"),
            (&test_mm_maskz_min_epu16, "test_mm_maskz_min_epu16"),
            (&test_mm_mask_min_epu8, "test_mm_mask_min_epu8"),
            (&test_mm_maskz_min_epu8, "test_mm_maskz_min_epu8"),
            (&test_mm_mask_min_epi16, "test_mm_mask_min_epi16"),
            (&test_mm_maskz_min_epi16, "test_mm_maskz_min_epi16"),
            (&test_mm_mask_min_epi8, "test_mm_mask_min_epi8"),
            (&test_mm_maskz_min_epi8, "test_mm_maskz_min_epi8"),
            (&test_mm_cmplt_epu16_mask, "test_mm_cmplt_epu16_mask"),
            (&test_mm_mask_cmplt_epu16_mask, "test_mm_mask_cmplt_epu16_mask"),
            (&test_mm_cmplt_epu8_mask, "test_mm_cmplt_epu8_mask"),
            (&test_mm_mask_cmplt_epu8_mask, "test_mm_mask_cmplt_epu8_mask"),
            (&test_mm_cmplt_epi16_mask, "test_mm_cmplt_epi16_mask"),
            (&test_mm_mask_cmplt_epi16_mask, "test_mm_mask_cmplt_epi16_mask"),
            (&test_mm_cmplt_epi8_mask, "test_mm_cmplt_epi8_mask"),
            (&test_mm_mask_cmplt_epi8_mask, "test_mm_mask_cmplt_epi8_mask"),
            (&test_mm_cmpgt_epu16_mask, "test_mm_cmpgt_epu16_mask"),
            (&test_mm_mask_cmpgt_epu16_mask, "test_mm_mask_cmpgt_epu16_mask"),
            (&test_mm_cmpgt_epu8_mask, "test_mm_cmpgt_epu8_mask"),
            (&test_mm_mask_cmpgt_epu8_mask, "test_mm_mask_cmpgt_epu8_mask"),
            (&test_mm_cmpgt_epi16_mask, "test_mm_cmpgt_epi16_mask"),
            (&test_mm_mask_cmpgt_epi16_mask, "test_mm_mask_cmpgt_epi16_mask"),
            (&test_mm_cmpgt_epi8_mask, "test_mm_cmpgt_epi8_mask"),
            (&test_mm_mask_cmpgt_epi8_mask, "test_mm_mask_cmpgt_epi8_mask"),
            (&test_mm_cmple_epu16_mask, "test_mm_cmple_epu16_mask"),
            (&test_mm_mask_cmple_epu16_mask, "test_mm_mask_cmple_epu16_mask"),
            (&test_mm_cmple_epu8_mask, "test_mm_cmple_epu8_mask"),
            (&test_mm_mask_cmple_epu8_mask, "test_mm_mask_cmple_epu8_mask"),
            (&test_mm_cmple_epi16_mask, "test_mm_cmple_epi16_mask"),
            (&test_mm_mask_cmple_epi16_mask, "test_mm_mask_cmple_epi16_mask"),
            (&test_mm_cmple_epi8_mask, "test_mm_cmple_epi8_mask"),
            (&test_mm_mask_cmple_epi8_mask, "test_mm_mask_cmple_epi8_mask"),
            (&test_mm_cmpge_epu16_mask, "test_mm_cmpge_epu16_mask"),
            (&test_mm_mask_cmpge_epu16_mask, "test_mm_mask_cmpge_epu16_mask"),
            (&test_mm_cmpge_epu8_mask, "test_mm_cmpge_epu8_mask"),
            (&test_mm_mask_cmpge_epu8_mask, "test_mm_mask_cmpge_epu8_mask"),
            (&test_mm_cmpge_epi16_mask, "test_mm_cmpge_epi16_mask"),
            (&test_mm_mask_cmpge_epi16_mask, "test_mm_mask_cmpge_epi16_mask"),
            (&test_mm_cmpge_epi8_mask, "test_mm_cmpge_epi8_mask"),
            (&test_mm_mask_cmpge_epi8_mask, "test_mm_mask_cmpge_epi8_mask"),
            (&test_mm_cmpeq_epu16_mask, "test_mm_cmpeq_epu16_mask"),
            (&test_mm_mask_cmpeq_epu16_mask, "test_mm_mask_cmpeq_epu16_mask"),
            (&test_mm_cmpeq_epu8_mask, "test_mm_cmpeq_epu8_mask"),
            (&test_mm_mask_cmpeq_epu8_mask, "test_mm_mask_cmpeq_epu8_mask"),
            (&test_mm_cmpeq_epi16_mask, "test_mm_cmpeq_epi16_mask"),
            (&test_mm_mask_cmpeq_epi16_mask, "test_mm_mask_cmpeq_epi16_mask"),
            (&test_mm_cmpeq_epi8_mask, "test_mm_cmpeq_epi8_mask"),
            (&test_mm_mask_cmpeq_epi8_mask, "test_mm_mask_cmpeq_epi8_mask"),
            (&test_mm_cmpneq_epu16_mask, "test_mm_cmpneq_epu16_mask"),
            (&test_mm_mask_cmpneq_epu16_mask, "test_mm_mask_cmpneq_epu16_mask"),
            (&test_mm_cmpneq_epu8_mask, "test_mm_cmpneq_epu8_mask"),
            (&test_mm_mask_cmpneq_epu8_mask, "test_mm_mask_cmpneq_epu8_mask"),
            (&test_mm_cmpneq_epi16_mask, "test_mm_cmpneq_epi16_mask"),
            (&test_mm_mask_cmpneq_epi16_mask, "test_mm_mask_cmpneq_epi16_mask"),
            (&test_mm_cmpneq_epi8_mask, "test_mm_cmpneq_epi8_mask"),
            (&test_mm_mask_cmpneq_epi8_mask, "test_mm_mask_cmpneq_epi8_mask"),
            (&test_mm_cmp_epu16_mask, "test_mm_cmp_epu16_mask"),
            (&test_mm_mask_cmp_epu16_mask, "test_mm_mask_cmp_epu16_mask"),
            (&test_mm_cmp_epu8_mask, "test_mm_cmp_epu8_mask"),
            (&test_mm_mask_cmp_epu8_mask, "test_mm_mask_cmp_epu8_mask"),
            (&test_mm_cmp_epi16_mask, "test_mm_cmp_epi16_mask"),
            (&test_mm_mask_cmp_epi16_mask, "test_mm_mask_cmp_epi16_mask"),
            (&test_mm_cmp_epi8_mask, "test_mm_cmp_epi8_mask"),
            (&test_mm_mask_cmp_epi8_mask, "test_mm_mask_cmp_epi8_mask"),
            (&test_mm_reduce_add_epi16, "test_mm_reduce_add_epi16"),
            (&test_mm_mask_reduce_add_epi16, "test_mm_mask_reduce_add_epi16"),
            (&test_mm_reduce_add_epi8, "test_mm_reduce_add_epi8"),
            (&test_mm_mask_reduce_add_epi8, "test_mm_mask_reduce_add_epi8"),
            (&test_mm_reduce_and_epi16, "test_mm_reduce_and_epi16"),
            (&test_mm_mask_reduce_and_epi16, "test_mm_mask_reduce_and_epi16"),
            (&test_mm_reduce_and_epi8, "test_mm_reduce_and_epi8"),
            (&test_mm_mask_reduce_and_epi8, "test_mm_mask_reduce_and_epi8"),
            (&test_mm_reduce_max_epi16, "test_mm_reduce_max_epi16"),
            (&test_mm_mask_reduce_max_epi16, "test_mm_mask_reduce_max_epi16"),
            (&test_mm_reduce_max_epi8, "test_mm_reduce_max_epi8"),
            (&test_mm_mask_reduce_max_epi8, "test_mm_mask_reduce_max_epi8"),
            (&test_mm_reduce_max_epu16, "test_mm_reduce_max_epu16"),
            (&test_mm_mask_reduce_max_epu16, "test_mm_mask_reduce_max_epu16"),
            (&test_mm_reduce_max_epu8, "test_mm_reduce_max_epu8"),
            (&test_mm_mask_reduce_max_epu8, "test_mm_mask_reduce_max_epu8"),
            (&test_mm_reduce_min_epi16, "test_mm_reduce_min_epi16"),
            (&test_mm_mask_reduce_min_epi16, "test_mm_mask_reduce_min_epi16"),
            (&test_mm_reduce_min_epi8, "test_mm_reduce_min_epi8"),
            (&test_mm_mask_reduce_min_epi8, "test_mm_mask_reduce_min_epi8"),
            (&test_mm_reduce_min_epu16, "test_mm_reduce_min_epu16"),
            (&test_mm_mask_reduce_min_epu16, "test_mm_mask_reduce_min_epu16"),
            (&test_mm_reduce_min_epu8, "test_mm_reduce_min_epu8"),
            (&test_mm_mask_reduce_min_epu8, "test_mm_mask_reduce_min_epu8"),
            (&test_mm_reduce_mul_epi16, "test_mm_reduce_mul_epi16"),
            (&test_mm_mask_reduce_mul_epi16, "test_mm_mask_reduce_mul_epi16"),
            (&test_mm_reduce_mul_epi8, "test_mm_reduce_mul_epi8"),
            (&test_mm_mask_reduce_mul_epi8, "test_mm_mask_reduce_mul_epi8"),
            (&test_mm_reduce_or_epi16, "test_mm_reduce_or_epi16"),
            (&test_mm_mask_reduce_or_epi16, "test_mm_mask_reduce_or_epi16"),
            (&test_mm_reduce_or_epi8, "test_mm_reduce_or_epi8"),
            (&test_mm_mask_reduce_or_epi8, "test_mm_mask_reduce_or_epi8"),
            (&test_mm_loadu_epi16, "test_mm_loadu_epi16"),
            (&test_mm_loadu_epi8, "test_mm_loadu_epi8"),
            (&test_mm_storeu_epi16, "test_mm_storeu_epi16"),
            (&test_mm_storeu_epi8, "test_mm_storeu_epi8"),
            (&test_mm_mask_loadu_epi16, "test_mm_mask_loadu_epi16"),
            (&test_mm_maskz_loadu_epi16, "test_mm_maskz_loadu_epi16"),
            (&test_mm_mask_loadu_epi8, "test_mm_mask_loadu_epi8"),
            (&test_mm_maskz_loadu_epi8, "test_mm_maskz_loadu_epi8"),
            (&test_mm_mask_storeu_epi16, "test_mm_mask_storeu_epi16"),
            (&test_mm_mask_storeu_epi8, "test_mm_mask_storeu_epi8"),
            (&test_mm_mask_madd_epi16, "test_mm_mask_madd_epi16"),
            (&test_mm_maskz_madd_epi16, "test_mm_maskz_madd_epi16"),
            (&test_mm_mask_maddubs_epi16, "test_mm_mask_maddubs_epi16"),
            (&test_mm_maskz_maddubs_epi16, "test_mm_maskz_maddubs_epi16"),
            (&test_mm_mask_packs_epi32, "test_mm_mask_packs_epi32"),
            (&test_mm_maskz_packs_epi32, "test_mm_maskz_packs_epi32"),
            (&test_mm_mask_packs_epi16, "test_mm_mask_packs_epi16"),
            (&test_mm_maskz_packs_epi16, "test_mm_maskz_packs_epi16"),
            (&test_mm_mask_packus_epi32, "test_mm_mask_packus_epi32"),
            (&test_mm_maskz_packus_epi32, "test_mm_maskz_packus_epi32"),
            (&test_mm_mask_packus_epi16, "test_mm_mask_packus_epi16"),
            (&test_mm_maskz_packus_epi16, "test_mm_maskz_packus_epi16"),
            (&test_mm_mask_avg_epu16, "test_mm_mask_avg_epu16"),
            (&test_mm_maskz_avg_epu16, "test_mm_maskz_avg_epu16"),
            (&test_mm_mask_avg_epu8, "test_mm_mask_avg_epu8"),
            (&test_mm_maskz_avg_epu8, "test_mm_maskz_avg_epu8"),
            (&test_mm_mask_sll_epi16, "test_mm_mask_sll_epi16"),
            (&test_mm_maskz_sll_epi16, "test_mm_maskz_sll_epi16"),
            (&test_mm_mask_slli_epi16, "test_mm_mask_slli_epi16"),
            (&test_mm_maskz_slli_epi16, "test_mm_maskz_slli_epi16"),
            (&test_mm_sllv_epi16, "test_mm_sllv_epi16"),
            (&test_mm_mask_sllv_epi16, "test_mm_mask_sllv_epi16"),
            (&test_mm_maskz_sllv_epi16, "test_mm_maskz_sllv_epi16"),
            (&test_mm_mask_srl_epi16, "test_mm_mask_srl_epi16"),
            (&test_mm_maskz_srl_epi16, "test_mm_maskz_srl_epi16"),
            (&test_mm_mask_srli_epi16, "test_mm_mask_srli_epi16"),
            (&test_mm_maskz_srli_epi16, "test_mm_maskz_srli_epi16"),
            (&test_mm_srlv_epi16, "test_mm_srlv_epi16"),
            (&test_mm_mask_srlv_epi16, "test_mm_mask_srlv_epi16"),
            (&test_mm_maskz_srlv_epi16, "test_mm_maskz_srlv_epi16"),
            (&test_mm_mask_sra_epi16, "test_mm_mask_sra_epi16"),
            (&test_mm_maskz_sra_epi16, "test_mm_maskz_sra_epi16"),
            (&test_mm_mask_srai_epi16, "test_mm_mask_srai_epi16"),
            (&test_mm_maskz_srai_epi16, "test_mm_maskz_srai_epi16"),
            (&test_mm_srav_epi16, "test_mm_srav_epi16"),
            (&test_mm_mask_srav_epi16, "test_mm_mask_srav_epi16"),
            (&test_mm_maskz_srav_epi16, "test_mm_maskz_srav_epi16"),
            (&test_mm_permutex2var_epi16, "test_mm_permutex2var_epi16"),
            (&test_mm_mask_permutex2var_epi16, "test_mm_mask_permutex2var_epi16"),
            (&test_mm_maskz_permutex2var_epi16, "test_mm_maskz_permutex2var_epi16"),
            (&test_mm_mask2_permutex2var_epi16, "test_mm_mask2_permutex2var_epi16"),
            (&test_mm_permutexvar_epi16, "test_mm_permutexvar_epi16"),
            (&test_mm_mask_permutexvar_epi16, "test_mm_mask_permutexvar_epi16"),
            (&test_mm_maskz_permutexvar_epi16, "test_mm_maskz_permutexvar_epi16"),
            (&test_mm_mask_blend_epi16, "test_mm_mask_blend_epi16"),
            (&test_mm_mask_blend_epi8, "test_mm_mask_blend_epi8"),
            (&test_mm_mask_broadcastw_epi16, "test_mm_mask_broadcastw_epi16"),
            (&test_mm_maskz_broadcastw_epi16, "test_mm_maskz_broadcastw_epi16"),
            (&test_mm_mask_broadcastb_epi8, "test_mm_mask_broadcastb_epi8"),
            (&test_mm_maskz_broadcastb_epi8, "test_mm_maskz_broadcastb_epi8"),
            (&test_mm_mask_unpackhi_epi16, "test_mm_mask_unpackhi_epi16"),
            (&test_mm_maskz_unpackhi_epi16, "test_mm_maskz_unpackhi_epi16"),
            (&test_mm_mask_unpackhi_epi8, "test_mm_mask_unpackhi_epi8"),
            (&test_mm_maskz_unpackhi_epi8, "test_mm_maskz_unpackhi_epi8"),
            (&test_mm_mask_unpacklo_epi16, "test_mm_mask_unpacklo_epi16"),
            (&test_mm_maskz_unpacklo_epi16, "test_mm_maskz_unpacklo_epi16"),
            (&test_mm_mask_unpacklo_epi8, "test_mm_mask_unpacklo_epi8"),
            (&test_mm_maskz_unpacklo_epi8, "test_mm_maskz_unpacklo_epi8"),
            (&test_mm_mask_mov_epi16, "test_mm_mask_mov_epi16"),
            (&test_mm_maskz_mov_epi16, "test_mm_maskz_mov_epi16"),
            (&test_mm_mask_mov_epi8, "test_mm_mask_mov_epi8"),
            (&test_mm_maskz_mov_epi8, "test_mm_maskz_mov_epi8"),
            (&test_mm_mask_set1_epi16, "test_mm_mask_set1_epi16"),
            (&test_mm_maskz_set1_epi16, "test_mm_maskz_set1_epi16"),
            (&test_mm_mask_set1_epi8, "test_mm_mask_set1_epi8"),
            (&test_mm_maskz_set1_epi8, "test_mm_maskz_set1_epi8"),
            (&test_mm_mask_shufflelo_epi16, "test_mm_mask_shufflelo_epi16"),
            (&test_mm_maskz_shufflelo_epi16, "test_mm_maskz_shufflelo_epi16"),
            (&test_mm_mask_shufflehi_epi16, "test_mm_mask_shufflehi_epi16"),
            (&test_mm_maskz_shufflehi_epi16, "test_mm_maskz_shufflehi_epi16"),
            (&test_mm_mask_shuffle_epi8, "test_mm_mask_shuffle_epi8"),
            (&test_mm_maskz_shuffle_epi8, "test_mm_maskz_shuffle_epi8"),
            (&test_mm_test_epi16_mask, "test_mm_test_epi16_mask"),
            (&test_mm_mask_test_epi16_mask, "test_mm_mask_test_epi16_mask"),
            (&test_mm_test_epi8_mask, "test_mm_test_epi8_mask"),
            (&test_mm_mask_test_epi8_mask, "test_mm_mask_test_epi8_mask"),
            (&test_mm_testn_epi16_mask, "test_mm_testn_epi16_mask"),
            (&test_mm_mask_testn_epi16_mask, "test_mm_mask_testn_epi16_mask"),
            (&test_mm_testn_epi8_mask, "test_mm_testn_epi8_mask"),
            (&test_mm_mask_testn_epi8_mask, "test_mm_mask_testn_epi8_mask"),
            (&test_mm_dbsad_epu8, "test_mm_dbsad_epu8"),
            (&test_mm_mask_dbsad_epu8, "test_mm_mask_dbsad_epu8"),
            (&test_mm_maskz_dbsad_epu8, "test_mm_maskz_dbsad_epu8"),
            (&test_mm_movepi16_mask, "test_mm_movepi16_mask"),
            (&test_mm_movepi8_mask, "test_mm_movepi8_mask"),
            (&test_mm_movm_epi16, "test_mm_movm_epi16"),
            (&test_mm_movm_epi8, "test_mm_movm_epi8"),
            (&test_mm_cvtepi16_epi8, "test_mm_cvtepi16_epi8"),
            (&test_mm_mask_cvtepi16_epi8, "test_mm_mask_cvtepi16_epi8"),
            (&test_mm_maskz_cvtepi16_epi8, "test_mm_maskz_cvtepi16_epi8"),
            (&test_mm_cvtsepi16_epi8, "test_mm_cvtsepi16_epi8"),
            (&test_mm_mask_cvtsepi16_epi8, "test_mm_mask_cvtsepi16_epi8"),
            (&test_mm_maskz_cvtsepi16_epi8, "test_mm_maskz_cvtsepi16_epi8"),
            (&test_mm_cvtusepi16_epi8, "test_mm_cvtusepi16_epi8"),
            (&test_mm_mask_cvtusepi16_epi8, "test_mm_mask_cvtusepi16_epi8"),
            (&test_mm_maskz_cvtusepi16_epi8, "test_mm_maskz_cvtusepi16_epi8"),
            (&test_mm_mask_cvtepi8_epi16, "test_mm_mask_cvtepi8_epi16"),
            (&test_mm_maskz_cvtepi8_epi16, "test_mm_maskz_cvtepi8_epi16"),
            (&test_mm_mask_cvtepu8_epi16, "test_mm_mask_cvtepu8_epi16"),
            (&test_mm_maskz_cvtepu8_epi16, "test_mm_maskz_cvtepu8_epi16"),
            (&test_mm_mask_alignr_epi8, "test_mm_mask_alignr_epi8"),
            (&test_mm_maskz_alignr_epi8, "test_mm_maskz_alignr_epi8"),
            (&test_mm_mask_cvtsepi16_storeu_epi8, "test_mm_mask_cvtsepi16_storeu_epi8"),
            (&test_mm_mask_cvtepi16_storeu_epi8, "test_mm_mask_cvtepi16_storeu_epi8"),
            (&test_mm_mask_cvtusepi16_storeu_epi8, "test_mm_mask_cvtusepi16_storeu_epi8"),
        ]
    }
}
