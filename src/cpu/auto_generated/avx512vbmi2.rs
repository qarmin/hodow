mod part1;
mod part2;

use crate::cpu::auto_generated::avx512vbmi2::part1::*;
use crate::cpu::auto_generated::avx512vbmi2::part2::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VBMI2;

impl ExtensionTest for AVX512VBMI2 {
    fn get_name() -> &'static str {
        "AVX512VBMI2"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_mask_expandloadu_epi16, "test_mm_mask_expandloadu_epi16"),
            (&test_mm_maskz_expandloadu_epi16, "test_mm_maskz_expandloadu_epi16"),
            (&test_mm_mask_expandloadu_epi8, "test_mm_mask_expandloadu_epi8"),
            (&test_mm_maskz_expandloadu_epi8, "test_mm_maskz_expandloadu_epi8"),
            (&test_mm_mask_compressstoreu_epi16, "test_mm_mask_compressstoreu_epi16"),
            (&test_mm_mask_compressstoreu_epi8, "test_mm_mask_compressstoreu_epi8"),
            (&test_mm_mask_compress_epi16, "test_mm_mask_compress_epi16"),
            (&test_mm_maskz_compress_epi16, "test_mm_maskz_compress_epi16"),
            (&test_mm_mask_compress_epi8, "test_mm_mask_compress_epi8"),
            (&test_mm_maskz_compress_epi8, "test_mm_maskz_compress_epi8"),
            (&test_mm_mask_expand_epi16, "test_mm_mask_expand_epi16"),
            (&test_mm_maskz_expand_epi16, "test_mm_maskz_expand_epi16"),
            (&test_mm_mask_expand_epi8, "test_mm_mask_expand_epi8"),
            (&test_mm_maskz_expand_epi8, "test_mm_maskz_expand_epi8"),
            (&test_mm_shldv_epi64, "test_mm_shldv_epi64"),
            (&test_mm_mask_shldv_epi64, "test_mm_mask_shldv_epi64"),
            (&test_mm_maskz_shldv_epi64, "test_mm_maskz_shldv_epi64"),
            (&test_mm_shldv_epi32, "test_mm_shldv_epi32"),
            (&test_mm_mask_shldv_epi32, "test_mm_mask_shldv_epi32"),
            (&test_mm_maskz_shldv_epi32, "test_mm_maskz_shldv_epi32"),
            (&test_mm_shldv_epi16, "test_mm_shldv_epi16"),
            (&test_mm_mask_shldv_epi16, "test_mm_mask_shldv_epi16"),
            (&test_mm_maskz_shldv_epi16, "test_mm_maskz_shldv_epi16"),
            (&test_mm_shrdv_epi64, "test_mm_shrdv_epi64"),
            (&test_mm_mask_shrdv_epi64, "test_mm_mask_shrdv_epi64"),
            (&test_mm_maskz_shrdv_epi64, "test_mm_maskz_shrdv_epi64"),
            (&test_mm_shrdv_epi32, "test_mm_shrdv_epi32"),
            (&test_mm_mask_shrdv_epi32, "test_mm_mask_shrdv_epi32"),
            (&test_mm_maskz_shrdv_epi32, "test_mm_maskz_shrdv_epi32"),
            (&test_mm_shrdv_epi16, "test_mm_shrdv_epi16"),
            (&test_mm_mask_shrdv_epi16, "test_mm_mask_shrdv_epi16"),
            (&test_mm_maskz_shrdv_epi16, "test_mm_maskz_shrdv_epi16"),
            (&test_mm_shldi_epi64, "test_mm_shldi_epi64"),
            (&test_mm_mask_shldi_epi64, "test_mm_mask_shldi_epi64"),
            (&test_mm_maskz_shldi_epi64, "test_mm_maskz_shldi_epi64"),
            (&test_mm_shldi_epi32, "test_mm_shldi_epi32"),
            (&test_mm_mask_shldi_epi32, "test_mm_mask_shldi_epi32"),
            (&test_mm_maskz_shldi_epi32, "test_mm_maskz_shldi_epi32"),
            (&test_mm_shldi_epi16, "test_mm_shldi_epi16"),
            (&test_mm_mask_shldi_epi16, "test_mm_mask_shldi_epi16"),
            (&test_mm_maskz_shldi_epi16, "test_mm_maskz_shldi_epi16"),
            (&test_mm_shrdi_epi64, "test_mm_shrdi_epi64"),
            (&test_mm_mask_shrdi_epi64, "test_mm_mask_shrdi_epi64"),
            (&test_mm_maskz_shrdi_epi64, "test_mm_maskz_shrdi_epi64"),
            (&test_mm_shrdi_epi32, "test_mm_shrdi_epi32"),
            (&test_mm_mask_shrdi_epi32, "test_mm_mask_shrdi_epi32"),
            (&test_mm_maskz_shrdi_epi32, "test_mm_maskz_shrdi_epi32"),
            (&test_mm_shrdi_epi16, "test_mm_shrdi_epi16"),
            (&test_mm_mask_shrdi_epi16, "test_mm_mask_shrdi_epi16"),
            (&test_mm_maskz_shrdi_epi16, "test_mm_maskz_shrdi_epi16"),
        ]
    }
}
