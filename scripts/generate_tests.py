#!/usr/bin/env python3
"""
Generates Rust SIMD test stubs from TODO.txt and TODO_AVX.txt.
Outputs to src/cpu/auto_generated/
"""

import re
from pathlib import Path
from collections import defaultdict

FUNCTIONS_PER_PART = 30
OUTPUT_DIR = Path("src/cpu/auto_generated")


# Ignored functions - that will not be tested
IGNORED_FUNCTIONS: set[str] = {
    #Undefined Behavior: accessing memory with alignment
    "_mm256_mask_load_epi32", "_mm256_mask_load_epi64", "_mm256_mask_load_pd", "_mm256_mask_load_ps", "_mm256_mask_store_epi32", "_mm256_mask_store_epi64", "_mm256_mask_store_pd", "_mm256_mask_store_ps", "_mm256_maskz_load_epi64", "_mm256_maskz_load_pd", "_mm512_mask_load_epi64", "_mm512_mask_load_pd", "_mm512_mask_load_ps", "_mm512_mask_store_epi32", "_mm512_mask_store_epi64", "_mm512_mask_store_pd", "_mm512_mask_store_ps", "_mm512_maskz_load_epi32", "_mm512_maskz_load_epi64", "_mm512_maskz_load_pd", "_mm512_maskz_load_ps", "_mm_mask_load_epi32", "_mm_mask_load_epi64", "_mm_mask_load_pd", "_mm_mask_load_ps", "_mm_mask_store_epi32", "_mm_mask_store_epi64", "_mm_mask_store_pd", "_mm_mask_store_ps", "_mm_maskz_load_epi32", "_mm_maskz_load_epi64", "_mm_maskz_load_pd", "_mm_maskz_load_ps",
    #Undefined Behavior: calling a function that requires unavailable target features
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "_mm256_madd52hi_avx_epu64", "_mm256_madd52lo_avx_epu64", "_mm_madd52hi_avx_epu64", "_mm_madd52lo_avx_epu64", "_mm256_madd52hi_avx_epu64", "_mm_madd52lo_avx_epu64"
    #Undefined Behavior: memory access failed
                                                                                                                                                                                    "_mm256_load_epi32", "_mm256_load_epi64", "_mm256_loadu_epi32", "_mm256_loadu_epi64", "_mm256_mask_loadu_epi32", "_mm256_mask_loadu_epi64", "_mm256_mask_loadu_pd", "_mm256_mask_loadu_ps", "_mm256_mask_storeu_epi32", "_mm256_mask_storeu_epi64", "_mm256_mask_storeu_pd", "_mm256_mask_storeu_ps", "_mm256_maskz_load_epi32", "_mm256_maskz_load_ps", "_mm256_maskz_loadu_epi32", "_mm256_maskz_loadu_epi64", "_mm256_maskz_loadu_pd", "_mm256_maskz_loadu_ps", "_mm256_store_epi32", "_mm256_store_epi64", "_mm256_storeu_epi32", "_mm256_storeu_epi64", "_mm512_load_epi32", "_mm512_load_epi64", "_mm512_load_pd", "_mm512_load_ps", "_mm512_loadu_epi32", "_mm512_loadu_epi64", "_mm512_loadu_pd", "_mm512_loadu_ps", "_mm512_mask_load_epi32", "_mm512_mask_loadu_epi32", "_mm512_mask_loadu_epi64", "_mm512_mask_loadu_pd", "_mm512_mask_loadu_ps", "_mm512_mask_storeu_epi32", "_mm512_mask_storeu_epi64", "_mm512_mask_storeu_pd", "_mm512_mask_storeu_ps", "_mm512_maskz_loadu_epi32", "_mm512_maskz_loadu_epi64", "_mm512_maskz_loadu_pd", "_mm512_maskz_loadu_ps", "_mm512_store_epi32", "_mm512_store_epi64", "_mm512_store_pd", "_mm512_store_ps", "_mm512_storeu_epi32", "_mm512_storeu_epi64", "_mm512_storeu_pd", "_mm512_storeu_ps", "_mm_load_epi32", "_mm_load_epi64", "_mm_loadu_epi32", "_mm_loadu_epi64", "_mm_mask_loadu_epi32", "_mm_mask_loadu_ps", "_mm_mask_storeu_epi32", "_mm_mask_storeu_ps", "_mm_maskz_loadu_epi32", "_mm_maskz_loadu_ps", "_mm_store_epi32", "_mm_store_epi64", "_mm_storeu_epi32", "_mm_storeu_epi64", "_mm256_load_epi32", "_mm256_load_pd", "_mm256_load_ps", "_mm256_loadu2_m128", "_mm256_loadu2_m128d", "_mm256_loadu_pd", "_mm256_loadu_ps", "_mm256_store_pd", "_mm256_store_ps", "_mm256_storeu2_m128", "_mm256_storeu2_m128d", "_mm256_storeu_pd", "_mm256_storeu_ps", "_mm_load_pd", "_mm_load_ps", "_mm_loadr_pd", "_mm_loadr_ps", "_mm_loadu_pd", "_mm_loadu_ps", "_mm_loadu_si16", "_mm_loadu_si32", "_mm_loadu_si64", "_mm_maskz_load_ps", "_mm_store1_pd", "_mm_store1_ps", "_mm_store_pd", "_mm_store_pd1", "_mm_store_ps", "_mm_store_ps1", "_mm_storer_pd", "_mm_storer_ps", "_mm_storeu_epi64", "_mm_storeu_pd", "_mm_storeu_ps", "_mm_storeu_si16", "_mm_storeu_si32", "_mm_storeu_si64",
    #inline assembly is not supported
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                "_mm256_stream_load_si256", "_mm256_stream_pd", "_mm256_stream_ps", "_mm256_stream_si256", "_mm512_stream_load_si512", "_mm_maskz_load_ss", "_mm_stream_load_si128", "_mm_stream_pd", "_mm_stream_ps", "_mm_stream_si128", "_mm_stream_si32", "_mm_stream_si64", "_mm512_stream_load_si512", "_mm512_stream_pd", "_mm512_stream_ps", "_mm512_stream_si512", "_mm_mask_load_sd", "_mm_mask_load_ss", "_mm_mask_store_sd", "_mm_mask_store_ss", "_mm_maskz_load_sd", "_mm_maskz_load_ss",
    #unsupported operation: can't call foreign function
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  "_mm256_bitshuffle_epi64_mask", "_mm256_mask2_permutex2var_epi8", "_mm256_mask_multishift_epi64_epi8", "_mm256_mask_permutex2var_epi8", "_mm256_mask_permutexvar_epi8", "_mm256_maskz_multishift_epi64_epi8", "_mm256_maskz_permutex2var_epi8", "_mm256_maskz_permutexvar_epi8", "_mm256_multishift_epi64_epi8", "_mm256_permutex2var_epi8", "_mm256_permutexvar_epi8", "_mm512_mask2_permutex2var_epi8", "_mm512_mask_multishift_epi64_epi8", "_mm512_mask_permutex2var_epi8", "_mm512_mask_permutexvar_epi8", "_mm512_maskz_multishift_epi64_epi8", "_mm512_maskz_permutex2var_epi8", "_mm512_maskz_permutexvar_epi8", "_mm512_multishift_epi64_epi8", "_mm512_permutex2var_epi8", "_mm512_permutexvar_epi8", "_mm_mask2_permutex2var_epi8", "_mm_mask_multishift_epi64_epi8", "_mm_mask_permutex2var_epi8", "_mm_mask_permutexvar_epi8", "_mm_maskz_multishift_epi64_epi8", "_mm_maskz_permutex2var_epi8", "_mm_maskz_permutexvar_epi8", "_mm_multishift_epi64_epi8", "_mm_permutex2var_epi8", "_mm_permutexvar_epi8",                                                                                               "_mm256_bitshuffle_epi64_mask", "_mm256_cmp_pd_mask", "_mm256_cmp_ps_mask", "_mm256_conflict_epi32", "_mm256_conflict_epi64", "_mm256_cvtepi32_epi8", "_mm256_cvtepi64_epi16", "_mm256_cvtepi64_epi8", "_mm256_cvtpd_epu32", "_mm256_cvtps_epu32", "_mm256_cvtsepi32_epi16", "_mm256_cvtsepi32_epi8", "_mm256_cvtsepi64_epi16", "_mm256_cvtsepi64_epi32", "_mm256_cvtsepi64_epi8", "_mm256_cvttpd_epu32", "_mm256_cvttps_epu32", "_mm256_cvtusepi32_epi16", "_mm256_cvtusepi32_epi8", "_mm256_cvtusepi64_epi16", "_mm256_cvtusepi64_epi32", "_mm256_cvtusepi64_epi8", "_mm256_fixupimm_pd", "_mm256_fixupimm_ps", "_mm256_getexp_pd", "_mm256_getmant_pd", "_mm256_getmant_ps", "_mm256_i32scatter_epi32", "_mm256_i32scatter_epi64", "_mm256_i32scatter_pd", "_mm256_i32scatter_ps", "_mm256_i64scatter_epi32", "_mm256_i64scatter_epi64", "_mm256_i64scatter_pd", "_mm256_i64scatter_ps", "_mm256_madd52hi_epu64", "_mm256_madd52lo_epu64", "_mm256_mask2_permutex2var_epi32", "_mm256_mask2_permutex2var_epi64", "_mm256_mask2_permutex2var_epi8", "_mm256_mask2_permutex2var_pd", "_mm256_mask2_permutex2var_ps", "_mm256_mask_bitshuffle_epi64_mask", "_mm256_mask_cmp_pd_mask", "_mm256_mask_cmp_ps_mask", "_mm256_mask_compress_epi32", "_mm256_mask_compress_epi64", "_mm256_mask_compress_pd", "_mm256_mask_compress_ps", "_mm256_mask_compressstoreu_epi32", "_mm256_mask_compressstoreu_epi64", "_mm256_mask_compressstoreu_pd", "_mm256_mask_compressstoreu_ps", "_mm256_mask_conflict_epi32", "_mm256_mask_conflict_epi64", "_mm256_mask_cvt_roundps_ph", "_mm256_mask_cvtepi32_epi8", "_mm256_mask_cvtepi32_storeu_epi16", "_mm256_mask_cvtepi32_storeu_epi8", "_mm256_mask_cvtepi64_epi16", "_mm256_mask_cvtepi64_epi8", "_mm256_mask_cvtepi64_storeu_epi16", "_mm256_mask_cvtepi64_storeu_epi32", "_mm256_mask_cvtepi64_storeu_epi8", "_mm256_mask_cvtpd_epu32", "_mm256_mask_cvtps_epu32", "_mm256_mask_cvtps_ph", "_mm256_mask_cvtsepi32_epi16", "_mm256_mask_cvtsepi32_epi8", "_mm256_mask_cvtsepi32_storeu_epi16", "_mm256_mask_cvtsepi32_storeu_epi8", "_mm256_mask_cvtsepi64_epi16", "_mm256_mask_cvtsepi64_epi32", "_mm256_mask_cvtsepi64_epi8", "_mm256_mask_cvtsepi64_storeu_epi16", "_mm256_mask_cvtsepi64_storeu_epi32", "_mm256_mask_cvtsepi64_storeu_epi8", "_mm256_mask_cvttpd_epi32", "_mm256_mask_cvttpd_epu32", "_mm256_mask_cvttps_epi32", "_mm256_mask_cvttps_epu32", "_mm256_mask_cvtusepi32_epi16", "_mm256_mask_cvtusepi32_epi8", "_mm256_mask_cvtusepi32_storeu_epi16", "_mm256_mask_cvtusepi32_storeu_epi8", "_mm256_mask_cvtusepi64_epi16", "_mm256_mask_cvtusepi64_epi32", "_mm256_mask_cvtusepi64_epi8", "_mm256_mask_cvtusepi64_storeu_epi16", "_mm256_mask_cvtusepi64_storeu_epi32", "_mm256_mask_cvtusepi64_storeu_epi8", "_mm256_mask_expand_epi32", "_mm256_mask_expand_epi64", "_mm256_mask_expand_pd", "_mm256_mask_expand_ps", "_mm256_mask_expandloadu_epi32", "_mm256_mask_expandloadu_epi64", "_mm256_mask_expandloadu_pd", "_mm256_mask_expandloadu_ps", "_mm256_mask_fixupimm_pd", "_mm256_mask_fixupimm_ps", "_mm256_mask_getexp_pd", "_mm256_mask_getmant_pd", "_mm256_mask_getmant_ps", "_mm256_mask_i32scatter_epi32", "_mm256_mask_i32scatter_epi64", "_mm256_mask_i32scatter_pd", "_mm256_mask_i32scatter_ps", "_mm256_mask_i64scatter_epi32", "_mm256_mask_i64scatter_epi64", "_mm256_mask_i64scatter_pd", "_mm256_mask_i64scatter_ps", "_mm256_mask_madd52hi_epu64", "_mm256_mask_madd52lo_epu64", "_mm256_mask_multishift_epi64_epi8", "_mm256_mask_permutex2var_epi32", "_mm256_mask_permutex2var_epi64", "_mm256_mask_permutex2var_epi8", "_mm256_mask_permutex2var_pd", "_mm256_mask_permutex2var_ps", "_mm256_mask_permutexvar_epi64", "_mm256_mask_permutexvar_epi8", "_mm256_mask_permutexvar_pd", "_mm256_mask_roundscale_pd", "_mm256_mask_roundscale_ps", "_mm256_mask_scalef_pd", "_mm256_mask_scalef_ps", "_mm256_mask_sra_epi64", "_mm256_mask_ternarylogic_epi64", "_mm256_maskz_compress_epi32", "_mm256_maskz_compress_epi64", "_mm256_maskz_compress_pd", "_mm256_maskz_compress_ps", "_mm256_maskz_conflict_epi32", "_mm256_maskz_conflict_epi64", "_mm256_maskz_cvt_roundps_ph", "_mm256_maskz_cvtepi32_epi8", "_mm256_maskz_cvtepi64_epi16", "_mm256_maskz_cvtepi64_epi8", "_mm256_maskz_cvtpd_epu32", "_mm256_maskz_cvtps_epu32", "_mm256_maskz_cvtps_ph", "_mm256_maskz_cvtsepi32_epi16", "_mm256_maskz_cvtsepi32_epi8", "_mm256_maskz_cvtsepi64_epi16", "_mm256_maskz_cvtsepi64_epi32", "_mm256_maskz_cvtsepi64_epi8", "_mm256_maskz_cvttpd_epi32", "_mm256_maskz_cvttpd_epu32", "_mm256_maskz_cvttps_epi32", "_mm256_maskz_cvttps_epu32", "_mm256_maskz_cvtusepi32_epi16", "_mm256_maskz_cvtusepi32_epi8", "_mm256_maskz_cvtusepi64_epi16", "_mm256_maskz_cvtusepi64_epi32", "_mm256_maskz_cvtusepi64_epi8", "_mm256_maskz_expand_epi32", "_mm256_maskz_expand_epi64", "_mm256_maskz_expand_pd", "_mm256_maskz_expand_ps", "_mm256_maskz_expandloadu_epi32", "_mm256_maskz_expandloadu_epi64", "_mm256_maskz_expandloadu_pd", "_mm256_maskz_expandloadu_ps", "_mm256_maskz_fixupimm_pd", "_mm256_maskz_fixupimm_ps", "_mm256_maskz_getexp_pd", "_mm256_maskz_getmant_pd", "_mm256_maskz_getmant_ps", "_mm256_maskz_madd52hi_epu64", "_mm256_maskz_madd52lo_epu64", "_mm256_maskz_multishift_epi64_epi8", "_mm256_maskz_permutex2var_epi32", "_mm256_maskz_permutex2var_epi64", "_mm256_maskz_permutex2var_epi8", "_mm256_maskz_permutex2var_pd", "_mm256_maskz_permutex2var_ps", "_mm256_maskz_permutexvar_epi64", "_mm256_maskz_permutexvar_epi8", "_mm256_maskz_permutexvar_pd", "_mm256_maskz_roundscale_pd", "_mm256_maskz_roundscale_ps", "_mm256_maskz_scalef_pd", "_mm256_maskz_scalef_ps", "_mm256_maskz_sra_epi64", "_mm256_maskz_ternarylogic_epi64", "_mm256_mmask_i32gather_epi32", "_mm256_mmask_i32gather_epi64", "_mm256_mmask_i32gather_pd", "_mm256_mmask_i32gather_ps", "_mm256_mmask_i64gather_epi32", "_mm256_mmask_i64gather_epi64", "_mm256_mmask_i64gather_pd", "_mm256_mmask_i64gather_ps", "_mm256_multishift_epi64_epi8", "_mm256_permutex2var_epi32", "_mm256_permutex2var_epi64", "_mm256_permutex2var_epi8", "_mm256_permutex2var_pd", "_mm256_permutex2var_ps", "_mm256_permutexvar_epi64", "_mm256_permutexvar_epi8", "_mm256_permutexvar_pd", "_mm256_roundscale_pd", "_mm256_roundscale_ps", "_mm256_scalef_pd", "_mm256_scalef_ps", "_mm256_sra_epi64", "_mm256_ternarylogic_epi64", "_mm512_add_round_pd", "_mm512_add_round_ps", "_mm512_bitshuffle_epi64_mask", "_mm512_cmp_pd_mask", "_mm512_cmp_ps_mask", "_mm512_cmp_round_pd_mask", "_mm512_cmp_round_ps_mask", "_mm512_cmpeq_pd_mask", "_mm512_cmpeq_ps_mask", "_mm512_cmple_pd_mask", "_mm512_cmple_ps_mask", "_mm512_cmplt_pd_mask", "_mm512_cmplt_ps_mask", "_mm512_cmpneq_pd_mask", "_mm512_cmpneq_ps_mask", "_mm512_cmpnle_pd_mask", "_mm512_cmpnle_ps_mask", "_mm512_cmpnlt_pd_mask", "_mm512_cmpnlt_ps_mask", "_mm512_cmpord_pd_mask", "_mm512_cmpord_ps_mask", "_mm512_cmpunord_pd_mask", "_mm512_cmpunord_ps_mask", "_mm512_conflict_epi32", "_mm512_conflict_epi64", "_mm512_cvt_roundepi32_ps", "_mm512_cvt_roundepu32_ps", "_mm512_cvt_roundpd_epi32", "_mm512_cvt_roundpd_epu32", "_mm512_cvt_roundpd_ps", "_mm512_cvt_roundph_ps", "_mm512_cvt_roundps_epi32", "_mm512_cvt_roundps_epu32", "_mm512_cvt_roundps_pd", "_mm512_cvt_roundps_ph", "_mm512_cvtepi64_epi8", "_mm512_cvtpd_epi32", "_mm512_cvtpd_epu32", "_mm512_cvtpd_ps", "_mm512_cvtpd_pslo", "_mm512_cvtph_ps", "_mm512_cvtps_epi32", "_mm512_cvtps_epu32", "_mm512_cvtps_pd", "_mm512_cvtps_ph", "_mm512_cvtpslo_pd", "_mm512_cvtsepi32_epi16", "_mm512_cvtsepi32_epi8", "_mm512_cvtsepi64_epi16", "_mm512_cvtsepi64_epi32", "_mm512_cvtsepi64_epi8", "_mm512_cvtt_roundpd_epi32", "_mm512_cvtt_roundpd_epu32", "_mm512_cvtt_roundps_epi32", "_mm512_cvtt_roundps_epu32", "_mm512_cvttpd_epi32", "_mm512_cvttpd_epu32", "_mm512_cvttps_epi32", "_mm512_cvttps_epu32", "_mm512_cvtusepi32_epi16", "_mm512_cvtusepi32_epi8", "_mm512_cvtusepi64_epi16", "_mm512_cvtusepi64_epi32", "_mm512_cvtusepi64_epi8", "_mm512_div_round_pd", "_mm512_div_round_ps", "_mm512_fixupimm_pd", "_mm512_fixupimm_ps", "_mm512_fixupimm_round_pd", "_mm512_fixupimm_round_ps", "_mm512_fmadd_round_pd", "_mm512_fmadd_round_ps", "_mm512_fmaddsub_round_pd", "_mm512_fmaddsub_round_ps", "_mm512_fmsub_round_pd", "_mm512_fmsub_round_ps", "_mm512_fmsubadd_round_pd", "_mm512_fmsubadd_round_ps", "_mm512_fnmadd_round_pd", "_mm512_fnmadd_round_ps", "_mm512_fnmsub_round_pd", "_mm512_fnmsub_round_ps", "_mm512_getexp_round_pd", "_mm512_getexp_round_ps", "_mm512_getmant_pd", "_mm512_getmant_ps", "_mm512_getmant_round_pd", "_mm512_getmant_round_ps", "_mm512_i32gather_epi32", "_mm512_i32gather_epi64", "_mm512_i32gather_pd", "_mm512_i32gather_ps", "_mm512_i32logather_epi64", "_mm512_i32logather_pd", "_mm512_i32loscatter_epi64", "_mm512_i32loscatter_pd", "_mm512_i32scatter_epi32", "_mm512_i32scatter_epi64", "_mm512_i32scatter_pd", "_mm512_i32scatter_ps", "_mm512_i64gather_epi32", "_mm512_i64gather_epi64", "_mm512_i64gather_pd", "_mm512_i64gather_ps", "_mm512_i64scatter_epi32", "_mm512_i64scatter_epi64", "_mm512_i64scatter_pd", "_mm512_i64scatter_ps", "_mm512_madd52hi_epu64", "_mm512_madd52lo_epu64", "_mm512_mask2_permutex2var_epi32", "_mm512_mask2_permutex2var_epi64", "_mm512_mask2_permutex2var_epi8", "_mm512_mask2_permutex2var_pd", "_mm512_mask2_permutex2var_ps", "_mm512_mask3_fmadd_round_pd", "_mm512_mask3_fmadd_round_ps", "_mm512_mask3_fmaddsub_round_pd", "_mm512_mask3_fmaddsub_round_ps", "_mm512_mask3_fmsub_round_pd", "_mm512_mask3_fmsub_round_ps", "_mm512_mask3_fmsubadd_round_pd", "_mm512_mask3_fmsubadd_round_ps", "_mm512_mask3_fnmadd_round_pd", "_mm512_mask3_fnmadd_round_ps", "_mm512_mask3_fnmsub_round_pd", "_mm512_mask3_fnmsub_round_ps", "_mm512_mask_add_round_pd", "_mm512_mask_add_round_ps", "_mm512_mask_bitshuffle_epi64_mask", "_mm512_mask_cmp_pd_mask", "_mm512_mask_cmp_ps_mask", "_mm512_mask_cmp_round_pd_mask", "_mm512_mask_cmp_round_ps_mask", "_mm512_mask_cmpeq_pd_mask", "_mm512_mask_cmpeq_ps_mask", "_mm512_mask_cmple_pd_mask", "_mm512_mask_cmple_ps_mask", "_mm512_mask_cmplt_pd_mask", "_mm512_mask_cmplt_ps_mask", "_mm512_mask_cmpneq_pd_mask", "_mm512_mask_cmpneq_ps_mask", "_mm512_mask_cmpnle_pd_mask", "_mm512_mask_cmpnle_ps_mask", "_mm512_mask_cmpnlt_pd_mask", "_mm512_mask_cmpnlt_ps_mask", "_mm512_mask_cmpord_pd_mask", "_mm512_mask_cmpord_ps_mask", "_mm512_mask_cmpunord_pd_mask", "_mm512_mask_cmpunord_ps_mask", "_mm512_mask_compress_epi32", "_mm512_mask_compress_epi64", "_mm512_mask_compress_pd", "_mm512_mask_compress_ps", "_mm512_mask_compressstoreu_epi32", "_mm512_mask_compressstoreu_epi64", "_mm512_mask_compressstoreu_pd", "_mm512_mask_compressstoreu_ps", "_mm512_mask_conflict_epi32", "_mm512_mask_conflict_epi64", "_mm512_mask_cvt_roundepi32_ps", "_mm512_mask_cvt_roundepu32_ps", "_mm512_mask_cvt_roundpd_epi32", "_mm512_mask_cvt_roundpd_epu32", "_mm512_mask_cvt_roundpd_ps", "_mm512_mask_cvt_roundph_ps", "_mm512_mask_cvt_roundps_epi32", "_mm512_mask_cvt_roundps_epu32", "_mm512_mask_cvt_roundps_pd", "_mm512_mask_cvt_roundps_ph", "_mm512_mask_cvtepi32_storeu_epi16", "_mm512_mask_cvtepi32_storeu_epi8", "_mm512_mask_cvtepi64_epi8", "_mm512_mask_cvtepi64_storeu_epi16", "_mm512_mask_cvtepi64_storeu_epi32", "_mm512_mask_cvtepi64_storeu_epi8", "_mm512_mask_cvtpd_epi32", "_mm512_mask_cvtpd_epu32", "_mm512_mask_cvtpd_ps", "_mm512_mask_cvtpd_pslo", "_mm512_mask_cvtph_ps", "_mm512_mask_cvtps_epi32", "_mm512_mask_cvtps_epu32", "_mm512_mask_cvtps_pd", "_mm512_mask_cvtps_ph", "_mm512_mask_cvtpslo_pd", "_mm512_mask_cvtsepi32_epi16", "_mm512_mask_cvtsepi32_epi8", "_mm512_mask_cvtsepi32_storeu_epi16", "_mm512_mask_cvtsepi32_storeu_epi8", "_mm512_mask_cvtsepi64_epi16", "_mm512_mask_cvtsepi64_epi32", "_mm512_mask_cvtsepi64_epi8", "_mm512_mask_cvtsepi64_storeu_epi16", "_mm512_mask_cvtsepi64_storeu_epi32", "_mm512_mask_cvtsepi64_storeu_epi8", "_mm512_mask_cvtt_roundpd_epi32", "_mm512_mask_cvtt_roundpd_epu32", "_mm512_mask_cvtt_roundps_epi32", "_mm512_mask_cvtt_roundps_epu32", "_mm512_mask_cvttpd_epi32", "_mm512_mask_cvttpd_epu32", "_mm512_mask_cvttps_epi32", "_mm512_mask_cvttps_epu32", "_mm512_mask_cvtusepi32_epi16", "_mm512_mask_cvtusepi32_epi8", "_mm512_mask_cvtusepi32_storeu_epi16", "_mm512_mask_cvtusepi32_storeu_epi8", "_mm512_mask_cvtusepi64_epi16", "_mm512_mask_cvtusepi64_epi32", "_mm512_mask_cvtusepi64_epi8", "_mm512_mask_cvtusepi64_storeu_epi16", "_mm512_mask_cvtusepi64_storeu_epi32", "_mm512_mask_cvtusepi64_storeu_epi8", "_mm512_mask_div_round_pd", "_mm512_mask_div_round_ps", "_mm512_mask_expand_epi32", "_mm512_mask_expand_epi64", "_mm512_mask_expand_pd", "_mm512_mask_expand_ps", "_mm512_mask_expandloadu_epi32", "_mm512_mask_expandloadu_epi64", "_mm512_mask_expandloadu_pd", "_mm512_mask_expandloadu_ps", "_mm512_mask_fixupimm_pd", "_mm512_mask_fixupimm_ps", "_mm512_mask_fixupimm_round_pd", "_mm512_mask_fixupimm_round_ps", "_mm512_mask_fmadd_round_pd", "_mm512_mask_fmadd_round_ps", "_mm512_mask_fmaddsub_round_pd", "_mm512_mask_fmaddsub_round_ps", "_mm512_mask_fmsub_round_pd", "_mm512_mask_fmsub_round_ps", "_mm512_mask_fmsubadd_round_pd", "_mm512_mask_fmsubadd_round_ps", "_mm512_mask_fnmadd_round_pd", "_mm512_mask_fnmadd_round_ps", "_mm512_mask_fnmsub_round_pd", "_mm512_mask_fnmsub_round_ps", "_mm512_mask_getexp_round_pd", "_mm512_mask_getexp_round_ps", "_mm512_mask_getmant_pd", "_mm512_mask_getmant_ps", "_mm512_mask_getmant_round_pd", "_mm512_mask_getmant_round_ps", "_mm512_mask_i32gather_epi32", "_mm512_mask_i32gather_epi64", "_mm512_mask_i32gather_pd", "_mm512_mask_i32gather_ps", "_mm512_mask_i32logather_epi64", "_mm512_mask_i32logather_pd", "_mm512_mask_i32loscatter_epi64", "_mm512_mask_i32loscatter_pd", "_mm512_mask_i32scatter_epi32", "_mm512_mask_i32scatter_epi64", "_mm512_mask_i32scatter_pd", "_mm512_mask_i32scatter_ps", "_mm512_mask_i64gather_epi32", "_mm512_mask_i64gather_epi64", "_mm512_mask_i64gather_pd", "_mm512_mask_i64gather_ps", "_mm512_mask_i64scatter_epi32", "_mm512_mask_i64scatter_epi64", "_mm512_mask_i64scatter_pd", "_mm512_mask_i64scatter_ps", "_mm512_mask_madd52hi_epu64", "_mm512_mask_madd52lo_epu64", "_mm512_mask_max_round_pd", "_mm512_mask_max_round_ps", "_mm512_mask_min_round_pd", "_mm512_mask_min_round_ps", "_mm512_mask_mul_round_pd", "_mm512_mask_mul_round_ps", "_mm512_mask_multishift_epi64_epi8", "_mm512_mask_permutevar_pd", "_mm512_mask_permutevar_ps", "_mm512_mask_permutex2var_epi32", "_mm512_mask_permutex2var_epi64", "_mm512_mask_permutex2var_epi8", "_mm512_mask_permutex2var_pd", "_mm512_mask_permutex2var_ps", "_mm512_mask_permutexvar_epi64", "_mm512_mask_permutexvar_epi8", "_mm512_mask_permutexvar_pd", "_mm512_mask_permutexvar_ps", "_mm512_mask_roundscale_pd", "_mm512_mask_roundscale_ps", "_mm512_mask_roundscale_round_pd", "_mm512_mask_roundscale_round_ps", "_mm512_mask_scalef_pd", "_mm512_mask_scalef_ps", "_mm512_mask_scalef_round_pd", "_mm512_mask_scalef_round_ps", "_mm512_mask_sll_epi32", "_mm512_mask_sll_epi64", "_mm512_mask_sqrt_round_pd", "_mm512_mask_sqrt_round_ps", "_mm512_mask_sra_epi32", "_mm512_mask_sra_epi64", "_mm512_mask_srl_epi32", "_mm512_mask_srl_epi64", "_mm512_mask_sub_round_pd", "_mm512_mask_sub_round_ps", "_mm512_mask_ternarylogic_epi64", "_mm512_maskz_add_round_pd", "_mm512_maskz_add_round_ps", "_mm512_maskz_compress_epi32", "_mm512_maskz_compress_epi64", "_mm512_maskz_compress_pd", "_mm512_maskz_compress_ps", "_mm512_maskz_conflict_epi32", "_mm512_maskz_conflict_epi64", "_mm512_maskz_cvt_roundepi32_ps", "_mm512_maskz_cvt_roundepu32_ps", "_mm512_maskz_cvt_roundpd_epi32", "_mm512_maskz_cvt_roundpd_epu32", "_mm512_maskz_cvt_roundpd_ps", "_mm512_maskz_cvt_roundph_ps", "_mm512_maskz_cvt_roundps_epi32", "_mm512_maskz_cvt_roundps_epu32", "_mm512_maskz_cvt_roundps_pd", "_mm512_maskz_cvt_roundps_ph", "_mm512_maskz_cvtepi64_epi8", "_mm512_maskz_cvtpd_epi32", "_mm512_maskz_cvtpd_epu32", "_mm512_maskz_cvtpd_ps", "_mm512_maskz_cvtph_ps", "_mm512_maskz_cvtps_epi32", "_mm512_maskz_cvtps_epu32", "_mm512_maskz_cvtps_pd", "_mm512_maskz_cvtps_ph", "_mm512_maskz_cvtsepi32_epi16", "_mm512_maskz_cvtsepi32_epi8", "_mm512_maskz_cvtsepi64_epi16", "_mm512_maskz_cvtsepi64_epi32", "_mm512_maskz_cvtsepi64_epi8", "_mm512_maskz_cvtt_roundpd_epi32", "_mm512_maskz_cvtt_roundpd_epu32", "_mm512_maskz_cvtt_roundps_epi32", "_mm512_maskz_cvtt_roundps_epu32", "_mm512_maskz_cvttpd_epi32", "_mm512_maskz_cvttpd_epu32", "_mm512_maskz_cvttps_epi32", "_mm512_maskz_cvttps_epu32", "_mm512_maskz_cvtusepi32_epi16", "_mm512_maskz_cvtusepi32_epi8", "_mm512_maskz_cvtusepi64_epi16", "_mm512_maskz_cvtusepi64_epi32", "_mm512_maskz_cvtusepi64_epi8", "_mm512_maskz_div_round_pd", "_mm512_maskz_div_round_ps", "_mm512_maskz_expand_epi32", "_mm512_maskz_expand_epi64", "_mm512_maskz_expand_pd", "_mm512_maskz_expand_ps", "_mm512_maskz_expandloadu_epi32", "_mm512_maskz_expandloadu_epi64", "_mm512_maskz_expandloadu_pd", "_mm512_maskz_expandloadu_ps", "_mm512_maskz_fixupimm_pd", "_mm512_maskz_fixupimm_ps", "_mm512_maskz_fixupimm_round_pd", "_mm512_maskz_fixupimm_round_ps", "_mm512_maskz_fmadd_round_pd", "_mm512_maskz_fmadd_round_ps", "_mm512_maskz_fmaddsub_round_pd", "_mm512_maskz_fmaddsub_round_ps", "_mm512_maskz_fmsub_round_pd", "_mm512_maskz_fmsub_round_ps", "_mm512_maskz_fmsubadd_round_pd", "_mm512_maskz_fmsubadd_round_ps", "_mm512_maskz_fnmadd_round_pd", "_mm512_maskz_fnmadd_round_ps", "_mm512_maskz_fnmsub_round_pd", "_mm512_maskz_fnmsub_round_ps", "_mm512_maskz_getexp_pd", "_mm512_maskz_getexp_round_pd", "_mm512_maskz_getexp_round_ps", "_mm512_maskz_getmant_pd", "_mm512_maskz_getmant_ps", "_mm512_maskz_getmant_round_pd", "_mm512_maskz_getmant_round_ps", "_mm512_maskz_madd52hi_epu64", "_mm512_maskz_madd52lo_epu64", "_mm512_maskz_max_round_pd", "_mm512_maskz_max_round_ps", "_mm512_maskz_min_round_pd", "_mm512_maskz_min_round_ps", "_mm512_maskz_mul_round_pd", "_mm512_maskz_mul_round_ps", "_mm512_maskz_multishift_epi64_epi8", "_mm512_maskz_permutevar_pd", "_mm512_maskz_permutevar_ps", "_mm512_maskz_permutex2var_epi32", "_mm512_maskz_permutex2var_epi64", "_mm512_maskz_permutex2var_epi8", "_mm512_maskz_permutex2var_pd", "_mm512_maskz_permutex2var_ps", "_mm512_maskz_permutexvar_epi64", "_mm512_maskz_permutexvar_epi8", "_mm512_maskz_permutexvar_pd", "_mm512_maskz_permutexvar_ps", "_mm512_maskz_roundscale_pd", "_mm512_maskz_roundscale_ps", "_mm512_maskz_roundscale_round_pd", "_mm512_maskz_roundscale_round_ps", "_mm512_maskz_scalef_pd", "_mm512_maskz_scalef_ps", "_mm512_maskz_scalef_round_pd", "_mm512_maskz_scalef_round_ps", "_mm512_maskz_sll_epi32", "_mm512_maskz_sll_epi64", "_mm512_maskz_sqrt_round_pd", "_mm512_maskz_sqrt_round_ps", "_mm512_maskz_sra_epi32", "_mm512_maskz_sra_epi64", "_mm512_maskz_srl_epi32", "_mm512_maskz_srl_epi64", "_mm512_maskz_sub_round_pd", "_mm512_maskz_sub_round_ps", "_mm512_maskz_ternarylogic_epi64", "_mm512_max_round_pd", "_mm512_max_round_ps", "_mm512_min_round_pd", "_mm512_min_round_ps", "_mm512_mul_round_pd", "_mm512_mul_round_ps", "_mm512_multishift_epi64_epi8", "_mm512_permutevar_pd", "_mm512_permutevar_ps", "_mm512_permutex2var_epi32", "_mm512_permutex2var_epi64", "_mm512_permutex2var_epi8", "_mm512_permutex2var_pd", "_mm512_permutex2var_ps", "_mm512_permutexvar_epi64", "_mm512_permutexvar_epi8", "_mm512_permutexvar_pd", "_mm512_permutexvar_ps", "_mm512_roundscale_pd", "_mm512_roundscale_ps", "_mm512_roundscale_round_pd", "_mm512_roundscale_round_ps", "_mm512_scalef_pd", "_mm512_scalef_ps", "_mm512_scalef_round_pd", "_mm512_scalef_round_ps", "_mm512_sll_epi32", "_mm512_sll_epi64", "_mm512_sqrt_round_pd", "_mm512_sqrt_round_ps", "_mm512_sra_epi32", "_mm512_sra_epi64", "_mm512_srl_epi32", "_mm512_srl_epi64", "_mm512_sub_round_pd", "_mm512_sub_round_ps", "_mm512_ternarylogic_epi64", "_mm_add_round_sd", "_mm_add_round_ss", "_mm_aeskeygenassist_si128", "_mm_bitshuffle_epi64_mask", "_mm_cmp_pd_mask", "_mm_cmp_ps_mask", "_mm_cmp_round_sd_mask", "_mm_cmp_round_ss_mask", "_mm_cmp_sd_mask", "_mm_cmp_ss_mask", "_mm_comi_round_sd", "_mm_comi_round_ss", "_mm_conflict_epi32", "_mm_conflict_epi64", "_mm_cvt_roundi32_ss", "_mm_cvt_roundi64_sd", "_mm_cvt_roundi64_ss", "_mm_cvt_roundsd_i32", "_mm_cvt_roundsd_i64", "_mm_cvt_roundsd_si32", "_mm_cvt_roundsd_si64", "_mm_cvt_roundsd_ss", "_mm_cvt_roundsd_u32", "_mm_cvt_roundsd_u64", "_mm_cvt_roundsi32_ss", "_mm_cvt_roundsi64_sd", "_mm_cvt_roundsi64_ss", "_mm_cvt_roundss_i32", "_mm_cvt_roundss_i64", "_mm_cvt_roundss_sd", "_mm_cvt_roundss_si32", "_mm_cvt_roundss_si64", "_mm_cvt_roundss_u32", "_mm_cvt_roundss_u64", "_mm_cvt_roundu32_ss", "_mm_cvt_roundu64_sd", "_mm_cvt_roundu64_ss", "_mm_cvtepi32_epi16", "_mm_cvtepi32_epi8", "_mm_cvtepi64_epi16", "_mm_cvtepi64_epi32", "_mm_cvtepi64_epi8", "_mm_cvtpd_epu32", "_mm_cvtps_epu32", "_mm_cvtsd_i32", "_mm_cvtsd_u32", "_mm_cvtsd_u64", "_mm_cvtsepi32_epi16", "_mm_cvtsepi32_epi8", "_mm_cvtsepi64_epi16", "_mm_cvtsepi64_epi32", "_mm_cvtsepi64_epi8", "_mm_cvtss_i32", "_mm_cvtss_u32", "_mm_cvtss_u64", "_mm_cvtt_roundsd_i32", "_mm_cvtt_roundsd_i64", "_mm_cvtt_roundsd_si32", "_mm_cvtt_roundsd_si64", "_mm_cvtt_roundsd_u32", "_mm_cvtt_roundsd_u64", "_mm_cvtt_roundss_i32", "_mm_cvtt_roundss_i64", "_mm_cvtt_roundss_si32", "_mm_cvtt_roundss_si64", "_mm_cvtt_roundss_u32", "_mm_cvtt_roundss_u64", "_mm_cvttpd_epu32", "_mm_cvttps_epu32", "_mm_cvttsd_i32", "_mm_cvttsd_i64", "_mm_cvttsd_u32", "_mm_cvttsd_u64", "_mm_cvttss_i32", "_mm_cvttss_i64", "_mm_cvttss_u32", "_mm_cvttss_u64", "_mm_cvtusepi32_epi16", "_mm_cvtusepi32_epi8", "_mm_cvtusepi64_epi16", "_mm_cvtusepi64_epi32", "_mm_cvtusepi64_epi8", "_mm_div_round_sd", "_mm_div_round_ss", "_mm_fixupimm_pd", "_mm_fixupimm_ps", "_mm_fixupimm_round_sd", "_mm_fixupimm_round_ss", "_mm_fixupimm_sd", "_mm_fixupimm_ss", "_mm_fmadd_round_sd", "_mm_fmadd_round_ss", "_mm_fmsub_round_sd", "_mm_fmsub_round_ss", "_mm_fnmadd_round_sd", "_mm_fnmadd_round_ss", "_mm_fnmsub_round_sd", "_mm_fnmsub_round_ss", "_mm_getexp_pd", "_mm_getexp_round_sd", "_mm_getexp_round_ss", "_mm_getexp_sd", "_mm_getexp_ss", "_mm_getmant_pd", "_mm_getmant_ps", "_mm_getmant_round_sd", "_mm_getmant_round_ss", "_mm_getmant_sd", "_mm_getmant_ss", "_mm_i32scatter_epi32", "_mm_i32scatter_epi64", "_mm_i32scatter_pd", "_mm_i32scatter_ps", "_mm_i64scatter_epi32", "_mm_i64scatter_epi64", "_mm_i64scatter_pd", "_mm_i64scatter_ps", "_mm_madd52hi_epu64", "_mm_madd52lo_epu64", "_mm_mask2_permutex2var_epi32", "_mm_mask2_permutex2var_epi64", "_mm_mask2_permutex2var_epi8", "_mm_mask2_permutex2var_pd", "_mm_mask2_permutex2var_ps", "_mm_mask3_fmadd_round_sd", "_mm_mask3_fmadd_round_ss", "_mm_mask3_fmsub_round_sd", "_mm_mask3_fmsub_round_ss", "_mm_mask3_fnmadd_round_sd", "_mm_mask3_fnmadd_round_ss", "_mm_mask3_fnmsub_round_sd", "_mm_mask3_fnmsub_round_ss", "_mm_mask_add_round_sd", "_mm_mask_add_round_ss", "_mm_mask_bitshuffle_epi64_mask", "_mm_mask_cmp_pd_mask", "_mm_mask_cmp_ps_mask", "_mm_mask_cmp_round_sd_mask", "_mm_mask_cmp_round_ss_mask", "_mm_mask_cmp_sd_mask", "_mm_mask_cmp_ss_mask", "_mm_mask_compress_epi32", "_mm_mask_compress_epi64", "_mm_mask_compress_pd", "_mm_mask_compress_ps", "_mm_mask_compressstoreu_epi32", "_mm_mask_compressstoreu_epi64", "_mm_mask_compressstoreu_pd", "_mm_mask_compressstoreu_ps", "_mm_mask_conflict_epi32", "_mm_mask_conflict_epi64", "_mm_mask_cvt_roundps_ph", "_mm_mask_cvt_roundsd_ss", "_mm_mask_cvt_roundss_sd", "_mm_mask_cvtepi32_epi16", "_mm_mask_cvtepi32_epi8", "_mm_mask_cvtepi32_storeu_epi16", "_mm_mask_cvtepi32_storeu_epi8", "_mm_mask_cvtepi64_epi16", "_mm_mask_cvtepi64_epi32", "_mm_mask_cvtepi64_epi8", "_mm_mask_cvtepi64_storeu_epi16", "_mm_mask_cvtepi64_storeu_epi32", "_mm_mask_cvtepi64_storeu_epi8", "_mm_mask_cvtpd_epi32", "_mm_mask_cvtpd_epu32", "_mm_mask_cvtpd_ps", "_mm_mask_cvtps_epu32", "_mm_mask_cvtps_ph", "_mm_mask_cvtsd_ss", "_mm_mask_cvtsepi32_epi16", "_mm_mask_cvtsepi32_epi8", "_mm_mask_cvtsepi32_storeu_epi16", "_mm_mask_cvtsepi32_storeu_epi8", "_mm_mask_cvtsepi64_epi16", "_mm_mask_cvtsepi64_epi32", "_mm_mask_cvtsepi64_epi8", "_mm_mask_cvtsepi64_storeu_epi16", "_mm_mask_cvtsepi64_storeu_epi32", "_mm_mask_cvtsepi64_storeu_epi8", "_mm_mask_cvtss_sd", "_mm_mask_cvttpd_epi32", "_mm_mask_cvttpd_epu32", "_mm_mask_cvttps_epi32", "_mm_mask_cvttps_epu32", "_mm_mask_cvtusepi32_epi16", "_mm_mask_cvtusepi32_epi8", "_mm_mask_cvtusepi32_storeu_epi16", "_mm_mask_cvtusepi32_storeu_epi8", "_mm_mask_cvtusepi64_epi16", "_mm_mask_cvtusepi64_epi32", "_mm_mask_cvtusepi64_epi8", "_mm_mask_cvtusepi64_storeu_epi16", "_mm_mask_cvtusepi64_storeu_epi32", "_mm_mask_cvtusepi64_storeu_epi8", "_mm_mask_div_round_sd", "_mm_mask_div_round_ss", "_mm_mask_expand_epi32", "_mm_mask_expand_epi64", "_mm_mask_expand_pd", "_mm_mask_expand_ps", "_mm_mask_expandloadu_epi32", "_mm_mask_expandloadu_epi64", "_mm_mask_expandloadu_pd", "_mm_mask_expandloadu_ps", "_mm_mask_fixupimm_pd", "_mm_mask_fixupimm_ps", "_mm_mask_fixupimm_round_sd", "_mm_mask_fixupimm_round_ss", "_mm_mask_fixupimm_sd", "_mm_mask_fixupimm_ss", "_mm_mask_fmadd_round_sd", "_mm_mask_fmadd_round_ss", "_mm_mask_fmsub_round_sd", "_mm_mask_fmsub_round_ss", "_mm_mask_fnmadd_round_sd", "_mm_mask_fnmadd_round_ss", "_mm_mask_fnmsub_round_sd", "_mm_mask_fnmsub_round_ss", "_mm_mask_getexp_pd", "_mm_mask_getexp_round_sd", "_mm_mask_getexp_round_ss", "_mm_mask_getexp_sd", "_mm_mask_getexp_ss", "_mm_mask_getmant_pd", "_mm_mask_getmant_ps", "_mm_mask_getmant_round_sd", "_mm_mask_getmant_round_ss", "_mm_mask_getmant_sd", "_mm_mask_getmant_ss", "_mm_mask_i32scatter_epi32", "_mm_mask_i32scatter_epi64", "_mm_mask_i32scatter_pd", "_mm_mask_i32scatter_ps", "_mm_mask_i64scatter_epi32", "_mm_mask_i64scatter_epi64", "_mm_mask_i64scatter_pd", "_mm_mask_i64scatter_ps", "_mm_mask_madd52hi_epu64", "_mm_mask_madd52lo_epu64", "_mm_mask_max_round_sd", "_mm_mask_max_round_ss", "_mm_mask_max_sd", "_mm_mask_max_ss", "_mm_mask_min_round_sd", "_mm_mask_min_round_ss", "_mm_mask_min_sd", "_mm_mask_min_ss", "_mm_mask_mul_round_sd", "_mm_mask_mul_round_ss", "_mm_mask_multishift_epi64_epi8", "_mm_mask_permutex2var_epi32", "_mm_mask_permutex2var_epi64", "_mm_mask_permutex2var_epi8", "_mm_mask_permutex2var_pd", "_mm_mask_permutex2var_ps", "_mm_mask_permutexvar_epi8", "_mm_mask_rcp14_sd", "_mm_mask_rcp14_ss", "_mm_mask_roundscale_pd", "_mm_mask_roundscale_ps", "_mm_mask_roundscale_round_sd", "_mm_mask_roundscale_round_ss", "_mm_mask_roundscale_sd", "_mm_mask_roundscale_ss", "_mm_mask_rsqrt14_sd", "_mm_mask_rsqrt14_ss", "_mm_mask_scalef_pd", "_mm_mask_scalef_ps", "_mm_mask_scalef_round_sd", "_mm_mask_scalef_round_ss", "_mm_mask_scalef_sd", "_mm_mask_scalef_ss", "_mm_mask_sqrt_round_sd", "_mm_mask_sqrt_round_ss", "_mm_mask_sqrt_sd", "_mm_mask_sqrt_ss", "_mm_mask_sra_epi64", "_mm_mask_sub_round_sd", "_mm_mask_sub_round_ss", "_mm_mask_ternarylogic_epi64", "_mm_maskz_add_round_sd", "_mm_maskz_add_round_ss", "_mm_maskz_compress_epi32", "_mm_maskz_compress_epi64", "_mm_maskz_compress_pd", "_mm_maskz_compress_ps", "_mm_maskz_conflict_epi32", "_mm_maskz_conflict_epi64", "_mm_maskz_cvt_roundps_ph", "_mm_maskz_cvt_roundsd_ss", "_mm_maskz_cvt_roundss_sd", "_mm_maskz_cvtepi32_epi16", "_mm_maskz_cvtepi32_epi8", "_mm_maskz_cvtepi64_epi16", "_mm_maskz_cvtepi64_epi32", "_mm_maskz_cvtepi64_epi8", "_mm_maskz_cvtpd_epu32", "_mm_maskz_cvtps_epu32", "_mm_maskz_cvtps_ph", "_mm_maskz_cvtsd_ss", "_mm_maskz_cvtsepi32_epi16", "_mm_maskz_cvtsepi32_epi8", "_mm_maskz_cvtsepi64_epi16", "_mm_maskz_cvtsepi64_epi32", "_mm_maskz_cvtsepi64_epi8", "_mm_maskz_cvtss_sd", "_mm_maskz_cvttpd_epi32", "_mm_maskz_cvttpd_epu32", "_mm_maskz_cvttps_epi32", "_mm_maskz_cvttps_epu32", "_mm_maskz_cvtusepi32_epi16", "_mm_maskz_cvtusepi32_epi8", "_mm_maskz_cvtusepi64_epi16", "_mm_maskz_cvtusepi64_epi32", "_mm_maskz_cvtusepi64_epi8", "_mm_maskz_div_round_sd", "_mm_maskz_div_round_ss", "_mm_maskz_expand_epi32", "_mm_maskz_expand_epi64", "_mm_maskz_expand_pd", "_mm_maskz_expand_ps", "_mm_maskz_expandloadu_epi32", "_mm_maskz_expandloadu_epi64", "_mm_maskz_expandloadu_pd", "_mm_maskz_expandloadu_ps", "_mm_maskz_fixupimm_pd", "_mm_maskz_fixupimm_ps", "_mm_maskz_fixupimm_round_sd", "_mm_maskz_fixupimm_round_ss", "_mm_maskz_fixupimm_sd", "_mm_maskz_fixupimm_ss", "_mm_maskz_fmadd_round_sd", "_mm_maskz_fmadd_round_ss", "_mm_maskz_fmsub_round_sd", "_mm_maskz_fmsub_round_ss", "_mm_maskz_fnmadd_round_sd", "_mm_maskz_fnmadd_round_ss", "_mm_maskz_fnmsub_round_sd", "_mm_maskz_fnmsub_round_ss", "_mm_maskz_getexp_pd", "_mm_maskz_getexp_round_sd", "_mm_maskz_getexp_round_ss", "_mm_maskz_getexp_sd", "_mm_maskz_getexp_ss", "_mm_maskz_getmant_pd", "_mm_maskz_getmant_ps", "_mm_maskz_getmant_round_sd", "_mm_maskz_getmant_round_ss", "_mm_maskz_getmant_sd", "_mm_maskz_getmant_ss", "_mm_maskz_madd52hi_epu64", "_mm_maskz_madd52lo_epu64", "_mm_maskz_max_round_sd", "_mm_maskz_max_round_ss", "_mm_maskz_max_sd", "_mm_maskz_max_ss", "_mm_maskz_min_round_sd", "_mm_maskz_min_round_ss", "_mm_maskz_min_sd", "_mm_maskz_min_ss", "_mm_maskz_mul_round_sd", "_mm_maskz_mul_round_ss", "_mm_maskz_multishift_epi64_epi8", "_mm_maskz_permutex2var_epi32", "_mm_maskz_permutex2var_epi64", "_mm_maskz_permutex2var_epi8", "_mm_maskz_permutex2var_pd", "_mm_maskz_permutex2var_ps", "_mm_maskz_permutexvar_epi8", "_mm_maskz_rcp14_sd", "_mm_maskz_rcp14_ss", "_mm_maskz_roundscale_pd", "_mm_maskz_roundscale_ps", "_mm_maskz_roundscale_round_sd", "_mm_maskz_roundscale_round_ss", "_mm_maskz_roundscale_sd", "_mm_maskz_roundscale_ss", "_mm_maskz_rsqrt14_sd", "_mm_maskz_rsqrt14_ss", "_mm_maskz_scalef_pd", "_mm_maskz_scalef_ps", "_mm_maskz_scalef_round_sd", "_mm_maskz_scalef_round_ss", "_mm_maskz_scalef_sd", "_mm_maskz_scalef_ss", "_mm_maskz_sqrt_round_sd", "_mm_maskz_sqrt_round_ss", "_mm_maskz_sqrt_sd", "_mm_maskz_sqrt_ss", "_mm_maskz_sra_epi64", "_mm_maskz_sub_round_sd", "_mm_maskz_sub_round_ss", "_mm_maskz_ternarylogic_epi64", "_mm_max_round_sd", "_mm_max_round_ss", "_mm_min_round_sd", "_mm_min_round_ss", "_mm_mmask_i32gather_epi32", "_mm_mmask_i32gather_epi64", "_mm_mmask_i32gather_pd", "_mm_mmask_i32gather_ps", "_mm_mmask_i64gather_epi32", "_mm_mmask_i64gather_epi64", "_mm_mmask_i64gather_pd", "_mm_mmask_i64gather_ps", "_mm_mul_round_sd", "_mm_mul_round_ss", "_mm_multishift_epi64_epi8", "_mm_permutex2var_epi32", "_mm_permutex2var_epi64", "_mm_permutex2var_epi8", "_mm_permutex2var_pd", "_mm_permutex2var_ps", "_mm_permutexvar_epi8", "_mm_rcp14_sd", "_mm_rcp14_ss", "_mm_roundscale_pd", "_mm_roundscale_ps", "_mm_roundscale_round_sd", "_mm_roundscale_round_ss", "_mm_roundscale_sd", "_mm_roundscale_ss", "_mm_rsqrt14_sd", "_mm_rsqrt14_ss", "_mm_scalef_pd", "_mm_scalef_ps", "_mm_scalef_round_sd", "_mm_scalef_round_ss", "_mm_scalef_sd", "_mm_scalef_ss", "_mm_sqrt_round_sd", "_mm_sqrt_round_ss", "_mm_sra_epi64", "_mm_sub_round_sd", "_mm_sub_round_ss", "_mm_ternarylogic_epi64"

}

# Functions with memory access errors - skip in fuzzer (#[cfg(not(fuzzing))])
NO_FUZZ_FUNCTIONS: set[str] = {

}

# Functions with unsupported operations in Miri - skip in miri (#[cfg(not(miri))])
NO_MIRI_FUNCTIONS: set[str] = {

    # unsupported operation: can't call foreign function
    "_mm_sfence", "_mm_clflush", "_mm_lfence", "_mm_mfence",
    "_mm_maskmoveu_si128",
    "_mm512_max_ps", "_mm512_mask_max_ps", "_mm512_maskz_max_ps",
    "_mm512_max_pd", "_mm512_mask_max_pd", "_mm512_maskz_max_pd",
    "_mm512_min_ps", "_mm512_mask_min_ps", "_mm512_maskz_min_ps",
    "_mm512_min_pd", "_mm512_mask_min_pd", "_mm512_maskz_min_pd",
    "_mm512_rcp14_ps", "_mm512_mask_rcp14_ps", "_mm512_maskz_rcp14_ps",
    "_mm256_rcp14_ps", "_mm256_mask_rcp14_ps", "_mm256_maskz_rcp14_ps",
    "_mm_rcp14_ps", "_mm_mask_rcp14_ps", "_mm_maskz_rcp14_ps",
    "_mm512_rcp14_pd", "_mm512_mask_rcp14_pd", "_mm512_maskz_rcp14_pd",
    "_mm256_rcp14_pd", "_mm256_mask_rcp14_pd", "_mm256_maskz_rcp14_pd",
    "_mm_rcp14_pd", "_mm_mask_rcp14_pd", "_mm_maskz_rcp14_pd",
    "_mm512_rsqrt14_ps", "_mm512_mask_rsqrt14_ps", "_mm512_maskz_rsqrt14_ps",
    "_mm256_rsqrt14_ps", "_mm256_mask_rsqrt14_ps", "_mm256_maskz_rsqrt14_ps",
    "_mm_rsqrt14_ps", "_mm_mask_rsqrt14_ps", "_mm_maskz_rsqrt14_ps",
    "_mm512_rsqrt14_pd", "_mm512_mask_rsqrt14_pd", "_mm512_maskz_rsqrt14_pd",
    "_mm256_rsqrt14_pd", "_mm256_mask_rsqrt14_pd", "_mm256_maskz_rsqrt14_pd",
    "_mm_rsqrt14_pd", "_mm_mask_rsqrt14_pd", "_mm_maskz_rsqrt14_pd",
    "_mm512_getexp_ps", "_mm512_mask_getexp_ps", "_mm512_maskz_getexp_ps",
    "_mm256_getexp_ps", "_mm256_mask_getexp_ps", "_mm256_maskz_getexp_ps",
    "_mm_getexp_ps", "_mm_mask_getexp_ps", "_mm_maskz_getexp_ps",
    "_mm512_getexp_pd", "_mm512_mask_getexp_pd",
}

# Deprecated intrinsics — excluded entirely from test generation
DEPRECATED_FUNCTIONS = {
    "_mm_getcsr", "_mm_setcsr",   # deprecated: use inline assembly instead
    "_mm_pause",                   # deprecated: use core::hint::spin_loop()
}

# Types without helpers in values.rs — functions using these are skipped entirely
UNSTABLE_TYPES = {
    "bf16", "f16",
    "__m128h", "__m256h", "__m512h",
    "__m128bh_avx", "__m256bh_avx",  # extra aliases that may appear
}

# Extension stem → Rust target_feature string (only where they differ)
FEATURE_FLAGS = {
    "sse41": "sse4.1",
    "sse42": "sse4.2",
    "bmi":   "bmi1",   # x86_64/bmi.rs is bmi1 intrinsics
    "test":  "sse2",   # x86/test.rs contains SSE2-level helpers
}

# SIMD type → random creator from values.rs
RANDOM_CREATORS: dict[str, str] = {
    "__m128":    "create_random__m128()",
    "__m128d":   "create_random__m128d()",
    "__m128i":   "create_random__m128i()",
    "__m128bh":  "create_random__m128bh()",
    "__m256":    "create_random__m256()",
    "__m256d":   "create_random__m256d()",
    "__m256i":   "create_random__m256i()",
    "__m256bh":  "create_random__m256bh()",
    "__m512":    "create_random__m512()",
    "__m512d":   "create_random__m512d()",
    "__m512i":   "create_random__m512i()",
    "__m512bh":  "create_random__m512bh()",
    "__mmask8":  "create_random__mmask8()",
    "__mmask16": "create_random__mmask16()",
    "__mmask32": "create_random__mmask32()",
    "__mmask64": "create_random__mmask64()",
    "i8":    "rand::random::<i8>()",
    "i16":   "rand::random::<i16>()",
    "i32":   "rand::random::<i32>()",
    "i64":   "rand::random::<i64>()",
    "u8":    "rand::random::<u8>()",
    "u16":   "rand::random::<u16>()",
    "u32":   "rand::random::<u32>()",
    "u64":   "rand::random::<u64>()",
    "f32":   "rand::random::<f32>()",
    "f64":   "rand::random::<f64>()",
    "usize": "rand::random::<usize>()",
    "bool":  "rand::random::<bool>()",
}

# SIMD type → fixed initializer (simple, deterministic values)
FIXED_INITS: dict[str, str] = {
    "__m128":    "create__m128_from([1.0, 2.0, 3.0, 4.0])",
    "__m128d":   "create__m128d_from([1.0, 2.0])",
    "__m128i":   "create__m128i_from_i32_array([1, 2, 3, 4])",
    "__m128bh":  "create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "__m256":    "create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])",
    "__m256d":   "create__m256d_from([1.0, 2.0, 3.0, 4.0])",
    "__m256i":   "create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])",
    "__m256bh":  "create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])",
    "__m512":    "create__m512_from([" + ", ".join(f"{i+1}.0" for i in range(16)) + "])",
    "__m512d":   "create__m512d_from([" + ", ".join(f"{i+1}.0" for i in range(8)) + "])",
    "__m512i":   "create__m512i_from_i32_array([" + ", ".join(str(i+1) for i in range(16)) + "])",
    "__m512bh":  "create__m512bh_from([" + ", ".join(str(i % 20 + 1) for i in range(32)) + "])",
    "__mmask8":  "create__mmask8_from(0b01010101)",
    "__mmask16": "create__mmask16_from(0b0101010101010101)",
    "__mmask32": "create__mmask32_from(0x55555555u32)",
    "__mmask64": "create__mmask64_from(0x5555555555555555u64)",
    "i8":    "1i8",
    "i16":   "1i16",
    "i32":   "1i32",
    "i64":   "1i64",
    "u8":    "1u8",
    "u16":   "1u16",
    "u32":   "1u32",
    "u64":   "1u64",
    "f32":   "1.0f32",
    "f64":   "1.0f64",
    "usize": "0usize",
    "bool":  "true",
}

# Zeroed SIMD inits — used for gather/scatter offset/index params to avoid OOB reads
ZERO_SIMD_INITS: dict[str, str] = {
    "__m128i": "create__m128i_from_i32_array([0, 0, 0, 0])",
    "__m256i": "create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])",
    "__m512i": "create__m512i_from_i32_array([" + ", ".join("0" for _ in range(16)) + "])",
}

# Sequential init table: ptype → (elem_count, formatter(vals) → str)
# Types not listed fall back to FIXED_INITS (masks, bool, usize).
def _f(name: str, vals: list[int], float_: bool) -> str:
    elems = ", ".join(f"{v}.0" if float_ else str(v) for v in vals)
    return f"{name}([{elems}])"

SEQ_TYPES: dict[str, tuple[int, object]] = {
    "__m128":   (4,  lambda v: _f("create__m128_from",             v, True)),
    "__m128d":  (2,  lambda v: _f("create__m128d_from",            v, True)),
    "__m128i":  (4,  lambda v: _f("create__m128i_from_i32_array",  v, False)),
    "__m128bh": (8,  lambda v: _f("create__m128bh_from",           v, False)),
    "__m256":   (8,  lambda v: _f("create__m256_from",             v, True)),
    "__m256d":  (4,  lambda v: _f("create__m256d_from",            v, True)),
    "__m256i":  (8,  lambda v: _f("create__m256i_from_i32_array",  v, False)),
    "__m256bh": (16, lambda v: _f("create__m256bh_from",           v, False)),
    "__m512":   (16, lambda v: _f("create__m512_from",             v, True)),
    "__m512d":  (8,  lambda v: _f("create__m512d_from",            v, True)),
    "__m512i":  (16, lambda v: _f("create__m512i_from_i32_array",  v, False)),
    "__m512bh": (32, lambda v: _f("create__m512bh_from",           v, False)),
    "i8":   (1, lambda v: f"{v[0]}i8"),
    "i16":  (1, lambda v: f"{v[0]}i16"),
    "i32":  (1, lambda v: f"{v[0]}i32"),
    "i64":  (1, lambda v: f"{v[0]}i64"),
    "u8":   (1, lambda v: f"{v[0]}u8"),
    "u16":  (1, lambda v: f"{v[0]}u16"),
    "u32":  (1, lambda v: f"{v[0]}u32"),
    "u64":  (1, lambda v: f"{v[0]}u64"),
    "f32":  (1, lambda v: f"{v[0]}.0f32"),
    "f64":  (1, lambda v: f"{v[0]}.0f64"),
}


def seq_init(ptype: str, ctr: list[int]) -> str:
    """Return a fixed init expression with sequentially increasing values.
    `ctr` is a single-element list used as a mutable int counter."""
    if ptype not in SEQ_TYPES:
        return FIXED_INITS.get(ptype, f"0 /* {ptype} */")
    n, fmt = SEQ_TYPES[ptype]
    vals = list(range(ctr[0], ctr[0] + n))
    ctr[0] += n
    return fmt(vals)

# Return type → (unpack function, element count, zero literal)
UNPACK_INFO: dict[str, tuple[str, int, str]] = {
    "__m128":  ("unpack__m128_to_f32_array",  4,  "0.0f32"),
    "__m128d": ("unpack__m128d_to_f64_array", 2,  "0.0f64"),
    "__m128i": ("unpack__m128i_to_i32_array", 4,  "0i32"),
    "__m256":  ("unpack__m256_to_f32_array",  8,  "0.0f32"),
    "__m256d": ("unpack__m256d_to_f64_array", 4,  "0.0f64"),
    "__m256i": ("unpack__m256i_to_i32_array", 8,  "0i32"),
    "__m512":  ("unpack__m512_to_f32_array",  16, "0.0f32"),
    "__m512d": ("unpack__m512d_to_f64_array", 8,  "0.0f64"),
    "__m512i": ("unpack__m512i_to_i32_array", 16, "0i32"),
}

# Primitive return types handled via check_int_equality
INT_RETURNS = {
    "i8", "i16", "i32", "i64",
    "u8", "u16", "u32", "u64",
    "__mmask8", "__mmask16", "__mmask32", "__mmask64",
}


# ---------------------------------------------------------------------------
# Parsing
# ---------------------------------------------------------------------------

def source_to_ext(src_path: str) -> str:
    """Derive module name from TODO source path (strips directory, drops .rs)."""
    return Path(src_path).stem


def ext_to_feature(ext: str) -> str:
    return FEATURE_FLAGS.get(ext, ext.lower())


def ext_to_struct(ext: str) -> str:
    return ext.upper()


def parse_sig(raw: str) -> dict | None:
    """
    Parse a single signature line such as:
      pub fn _mm_add_epi32(a: __m128i, b: __m128i) -> __m128i {
      pub fn _mm_blend_epi32<const IMM4: i32>(a: __m128i, b: __m128i) -> __m128i {
      pub unsafe fn _mm_loadu_si128(mem_addr: *const __m128i) -> __m128i {
      pub unsafe fn _mm_loadiwkey(      ← incomplete, multi-line signature
    Returns None if not a function line.
    """
    line = raw.strip()
    if not line or "fn " not in line:
        return None

    is_unsafe = "unsafe fn" in line

    name_m = re.search(r"fn\s+(\w+)", line)
    if not name_m:
        return None
    func_name = name_m.group(1)

    # Const generics  e.g. <const IMM8: i32>
    const_generics = []
    cg_m = re.search(r"fn\s+\w+<([^>]+)>", line)
    if cg_m:
        const_generics = re.findall(r"const\s+(\w+):\s*(\w+)", cg_m.group(1))

    # Detect incomplete multi-line signature (no closing paren on this line)
    if ")" not in line:
        return {"name": func_name, "params": None, "return_type": None,
                "const_generics": const_generics, "is_unsafe": is_unsafe,
                "is_complete": False}

    # Extract parameter list
    paren_m = re.search(r"\(([^)]*)\)", line)
    params_str = paren_m.group(1).strip() if paren_m else ""

    # Return type
    ret_m = re.search(r"\)\s*->\s*([\w:*<>&\[\]_; ]+?)(?:\s*\{|$)", line)
    return_type = ret_m.group(1).strip() if ret_m else "()"

    params = []
    for part in params_str.split(","):
        part = part.strip()
        if not part:
            continue
        colon = part.rfind(":")
        if colon == -1:
            continue
        pname = part[:colon].strip().lstrip("&").strip()
        ptype = part[colon + 1:].strip()
        params.append((pname, ptype))

    return {"name": func_name, "params": params, "return_type": return_type,
            "const_generics": const_generics, "is_unsafe": is_unsafe,
            "is_complete": True}


def parse_todo(path: Path) -> dict[str, list[dict]]:
    """Parse a TODO file → {ext: [sig, ...]}"""
    result: dict[str, list[dict]] = defaultdict(list)
    current_ext: str | None = None
    seen: set[tuple[str, str]] = set()

    for line in path.read_text().splitlines():
        line = line.rstrip()
        if not line:
            continue
        if re.match(r"^src/", line):
            current_ext = source_to_ext(line)
            continue
        if current_ext is None:
            continue
        m = re.match(r"^\d+:(pub\s+(?:unsafe\s+)?fn\s+.+)", line)
        if not m:
            continue
        sig = parse_sig(m.group(1))
        if sig is None:
            continue
        key = (current_ext, sig["name"])
        if key in seen:
            continue
        seen.add(key)
        result[current_ext].append(sig)

    return result


# ---------------------------------------------------------------------------
# Code generation
# ---------------------------------------------------------------------------

def has_ptr(params: list | None) -> bool:
    return bool(params and any("*" in pt or pt.startswith("&") for _, pt in params))


def has_unstable_type(params: list | None, ret: str) -> bool:
    """True if the function uses types not yet available in stable values.rs."""
    all_types = ([pt for _, pt in params] if params else []) + [ret]
    return any(
        any(u in t for u in UNSTABLE_TYPES)
        for t in all_types
    )


def skip_fuzz(name: str, params: list | None) -> bool:
    return (            has_ptr(params) or
            name in NO_FUZZ_FUNCTIONS)


def skip_miri(name: str) -> bool:
    """Check if function should be skipped in Miri (cfg(not(miri)))."""
    return name in NO_MIRI_FUNCTIONS


def const_val(cg_name: str) -> str:
    """Return a safe literal for a const generic parameter."""
    upper = cg_name.upper()
    if upper == "SCALE":
        return "1"    # gather/scatter: must be 1, 2, 4, or 8
    if upper == "SAE":
        return "8"    # static_assert_sae!: must be 4 or 8
    if upper == "ROUNDING":
        return "8"    # static_assert_rounding!: must be 4, 8, 9, 10, or 11
    return "0"


def const_suffix(cg: list) -> str:
    return f"::<{', '.join(const_val(n) for n, _ in cg)}>" if cg else ""


def inner_ref_type(ptype: str) -> str | None:
    """If ptype is '&T' or '&mut T', return T. Else None."""
    pt = ptype.strip()
    if pt.startswith("&mut "):
        return pt[5:].strip()
    if pt.startswith("&"):
        return pt[1:].strip()
    return None


def arg_expr(ptype: str, *, random: bool) -> str:
    """Expression to pass for a parameter of the given type."""
    pt = ptype.strip()
    if "*" in pt:
        return "__ptr__"  # placeholder; handled by caller
    if pt.startswith("&"):
        return "__ref__"  # placeholder; handled by caller
    table = RANDOM_CREATORS if random else FIXED_INITS
    return table.get(pt, f"0 /* {pt} */")


def load_expected_values(path: Path) -> dict[str, str]:
    """Parse expected_values.txt: 'test_name - rust_expr' → {test_name: rust_expr}"""
    if not path.exists():
        return {}
    result: dict[str, str] = {}
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if " - " not in line:
            continue
        name, _, value = line.partition(" - ")
        result[name.strip()] = value.strip()
    return result


def emit_check(lines: list[str], call: str, ret: str, expected: str | None = None) -> None:
    """Append lines that call `call` and check its result."""
    if expected is not None:
        # User-supplied expected value: emit check based on return type
        if ret in UNPACK_INFO:
            fn, _, _ = UNPACK_INFO[ret]
            lines.append(f"        let result = {fn}({call});")
            lines.append(f"        check_array_equality(&result, &{expected})?;")
        elif ret in INT_RETURNS:
            lines.append(f"        let result = {call};")
            lines.append(f"        check_int_equality(result as i32, {expected})?;")
        elif ret in ("()", ""):
            lines.append(f"        {call};")
        else:
            lines.append(f"        let _result = {call};")
    elif ret in UNPACK_INFO:
        fn, size, zero = UNPACK_INFO[ret]
        lines.append(f"        let result = {fn}({call});")
        lines.append(f"        check_array_equality(&result, &[{zero}; {size}])?;")
    elif ret in INT_RETURNS:
        lines.append(f"        let result = {call};")
        lines.append(f"        check_int_equality(result as i32, 0)?;")
    elif ret in ("()", ""):
        lines.append(f"        {call};")
    else:
        # f16, bf16, __m128h, etc. – compile but don't check
        lines.append(f"        let _result = {call};")


def test_name(func_name: str) -> str:
    """test_ + strip leading underscores: _mm_add → test_mm_add"""
    return "test_" + func_name.lstrip("_")


def gen_fn(sig: dict, expected_values: dict[str, str] | None = None) -> str:
    name = sig["name"]
    test = test_name(name)
    expected = (expected_values or {}).get(test)
    params: list = sig["params"] or []
    ret: str = sig["return_type"] or "()"
    cg: list = sig["const_generics"]
    complete: bool = sig["is_complete"]
    cs = const_suffix(cg)
    no_fuzz = skip_fuzz(name, params)
    no_miri = skip_miri(name)

    lines = []

    # Add cfg(not(miri)) attribute for functions that don't work in Miri
    if no_miri:
        lines.append("#[cfg(not(miri))]")

    lines.append(f"pub(super) fn {test}() -> Result<(), String> {{")
    lines.append("    unsafe {")

    is_gather = any(p in name.lower() for p in ("gather", "scatter"))
    ctr = [1]  # sequential counter, reset per-function for stable inputs

    if not complete:
        lines.append(f"        todo!(\"{name}\")")
    elif has_ptr(params):
        # Build local buffers for pointer and reference arguments
        # Gather/scatter: large array (safe for any valid offset) + zeroed SIMD offsets
        array_size = 64 if is_gather else 1
        call_args: list[str] = []
        for pname, ptype in params:
            ref_inner = inner_ref_type(ptype)
            if "*const" in ptype:
                inner = ptype.replace("*const", "").strip()
                init = seq_init(inner, ctr)
                lines.append(f"        let ptr_{pname} = [{init}; {array_size}];")
                call_args.append(f"ptr_{pname}.as_ptr()")
            elif "*mut" in ptype:
                inner = ptype.replace("*mut", "").strip()
                init = seq_init(inner, ctr)
                lines.append(f"        let mut ptr_{pname} = [{init}; {array_size}];")
                call_args.append(f"ptr_{pname}.as_mut_ptr()")
            elif ref_inner is not None:
                # &T or &mut T — create a local variable
                init = seq_init(ref_inner, ctr)
                is_mut = ptype.strip().startswith("&mut")
                mut_kw = "mut " if is_mut else ""
                lines.append(f"        let {mut_kw}ref_{pname} = {init};")
                ref_kw = "&mut " if is_mut else "&"
                call_args.append(f"{ref_kw}ref_{pname}")
            else:
                # Gather/scatter: zeroed SIMD for index/offset params (all read from base+0)
                if is_gather:
                    init = ZERO_SIMD_INITS.get(ptype, FIXED_INITS.get(ptype, f"0 /* {ptype} */"))
                else:
                    init = seq_init(ptype, ctr)
                lines.append(f"        let {pname} = {init};")
                call_args.append(pname)
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret, expected)
    else:
        call_args = [seq_init(pt, ctr) for _, pt in params]
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret, expected)

    # Fuzzing block (still inside the single unsafe {})
    if not no_fuzz and complete:
        lines.append("")
        lines.append("        if crate::get_fuzzing() {")
        lines.append("            log::info!(\"Starting fuzzing\");")
        lines.append("            for _ in 0..crate::cpu::get_iterations() {")
        fuzz_args = [arg_expr(pt, random=True) for _, pt in params
                     if "*" not in pt and not pt.startswith("&")]
        fuzz_call = f"{name}{cs}({', '.join(fuzz_args)})"
        lines.append(f"                let _ = {fuzz_call};")
        lines.append("            }")
        lines.append("        }")

    lines += ["    }", "    Ok(())", "}"]
    return "\n".join(lines)


def gen_part(funcs: list[dict], expected_values: dict[str, str] | None = None) -> str:
    header = [
        "use std::arch::x86_64::*;",
        "",
        "#[allow(unused_imports)]",
        "use crate::cpu::common::values::*;",
        "#[allow(unused_imports)]",
        "use crate::cpu::common::{check_array_equality, check_int_equality};",
        "",
    ]
    bodies = [gen_fn(sig, expected_values) for sig in funcs]
    return "\n".join(header) + "\n" + "\n\n".join(bodies) + "\n"


def gen_ext_rs(ext: str, funcs: list[dict], n_parts: int) -> str:
    struct = ext_to_struct(ext)
    lines = []
    for i in range(1, n_parts + 1):
        lines.append(f"mod part{i};")
    lines.append("")
    for i in range(1, n_parts + 1):
        lines.append(f"use crate::cpu::auto_generated::{ext}::part{i}::*;")
    lines += [
        "",
        "use crate::cpu::{ExtensionTest, TestFunction};",
        "",
        f"pub struct {struct};",
        "",
        f"impl ExtensionTest for {struct} {{",
        "    fn get_name() -> &'static str {",
        f"        \"{struct}\"",
        "    }",
        "",
        "    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {",
        "        &[",
    ]
    for sig in funcs:
        tname = test_name(sig["name"])
        # Add cfg(not(miri)) for functions that don't work in Miri
        if sig["name"] in NO_MIRI_FUNCTIONS:
            lines.append(f"            #[cfg(not(miri))]")
        lines.append(f"            (&{tname}, \"{tname}\"),")
    lines += ["        ]", "    }", "}"]
    return "\n".join(lines) + "\n"


def gen_mod_rs(exts: list[tuple[str, str]]) -> str:
    lines = []
    for ext, feature in exts:
        arch = "any(target_arch = \"x86\", target_arch = \"x86_64\")"
        lines.append(f"#[cfg(all({arch}, target_feature = \"{feature}\"))]")
        lines.append(f"pub mod {ext};")
        lines.append("")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    base = Path(__file__).parent.parent

    merged: dict[str, list[dict]] = defaultdict(list)
    seen: set[tuple[str, str]] = set()

    full = base / "signatures.txt"
    if not full.exists():
        print(f"Warning: {full} not found, skipping")
    for ext, sigs in parse_todo(full).items():
        for sig in sigs:
            key = (ext, sig["name"])
            if key not in seen:
                seen.add(key)
                merged[ext].append(sig)

    expected_values = load_expected_values(base / "expected_values.txt")

    out = base / OUTPUT_DIR
    out.mkdir(parents=True, exist_ok=True)

    generated: list[tuple[str, str]] = []

    # Collect stats for the summary table
    # (ext, total_raw, generated, parts, no_fuzz, unstable)
    rows: list[tuple[str, int, int, int, int, int]] = []

    for ext in sorted(merged):
        all_funcs = merged[ext]
        if not all_funcs:
            continue

        # Split into stable (generated) and skipped (unstable types, incomplete sigs, deprecated)
        stable = [s for s in all_funcs
                  if s["is_complete"]
                  and not has_unstable_type(s["params"], s["return_type"] or "()")
                  and s["name"] not in DEPRECATED_FUNCTIONS
                   and s["name"] not in IGNORED_FUNCTIONS]
        skipped_count = len(all_funcs) - len(stable)

        if not stable:
            rows.append((ext, len(all_funcs), 0, 0, 0, skipped_count))
            continue

        feature = ext_to_feature(ext)
        generated.append((ext, feature))

        parts = [stable[i:i + FUNCTIONS_PER_PART]
                 for i in range(0, len(stable), FUNCTIONS_PER_PART)]

        parts_dir = out / ext
        parts_dir.mkdir(exist_ok=True)

        # Remove stale part files that exceed the new count
        for old in parts_dir.glob("part*.rs"):
            m = re.match(r"part(\d+)\.rs$", old.name)
            if m and int(m.group(1)) > len(parts):
                old.unlink()

        for idx, chunk in enumerate(parts, 1):
            (parts_dir / f"part{idx}.rs").write_text(gen_part(chunk, expected_values))

        (out / f"{ext}.rs").write_text(gen_ext_rs(ext, stable, len(parts)))

        no_fuzz_count = sum(1 for s in stable if skip_fuzz(s["name"], s["params"]))
        rows.append((ext, len(all_funcs), len(stable), len(parts),
                     no_fuzz_count, skipped_count))

    (out / "mod.rs").write_text(gen_mod_rs(generated))

    # Pretty table
    col = dict(ext=26, total=6, gen=5, parts=5, nofuzz=7, skipped=7)
    sep = "  "
    header = (f"{'extension':<{col['ext']}}{sep}"
              f"{'total':>{col['total']}}{sep}"
              f"{'gen':>{col['gen']}}{sep}"
              f"{'parts':>{col['parts']}}{sep}"
              f"{'no-fuzz':>{col['nofuzz']}}{sep}"
              f"{'skipped':>{col['skipped']}}")
    rule = "-" * len(header)
    print(rule)
    print(header)
    print(rule)
    for ext, total, gen, parts, nofuzz, unstable in sorted(rows, key=lambda r: r[1], reverse=True):
        print(f"{ext:<{col['ext']}}{sep}"
              f"{total:>{col['total']}}{sep}"
              f"{gen:>{col['gen']}}{sep}"
              f"{parts:>{col['parts']}}{sep}"
              f"{nofuzz:>{col['nofuzz']}}{sep}"
              f"{unstable:>{col['skipped']}}")
    print(rule)
    totals = (sum(r[1] for r in rows), sum(r[2] for r in rows),
              sum(r[3] for r in rows), sum(r[4] for r in rows),
              sum(r[5] for r in rows))
    print(f"{'TOTAL':<{col['ext']}}{sep}"
          f"{totals[0]:>{col['total']}}{sep}"
          f"{totals[1]:>{col['gen']}}{sep}"
          f"{totals[2]:>{col['parts']}}{sep}"
          f"{totals[3]:>{col['nofuzz']}}{sep}"
          f"{totals[4]:>{col['skipped']}}")
    print(rule)
    print(f"\nDone → {out}  ({len(generated)} extensions)")


if __name__ == "__main__":
    main()
