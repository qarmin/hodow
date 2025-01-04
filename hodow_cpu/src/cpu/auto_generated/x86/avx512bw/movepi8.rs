#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 17361641481138401520).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 72075259255263248).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 9838263505978427528).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 8608480567731124087).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_movepi8_mask_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_movepi8_mask(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 17327863968529182840).map_err(|e| crate::cpu::with_call(e, "_mm512_movepi8_mask(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movepi8_mask(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_movepi8_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_movepi8_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 4042322160).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 16846864).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 2290649224).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2004318071).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_movepi8_mask_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movepi8_mask(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 4034457720).map_err(|e| crate::cpu::with_call(e, "_mm256_movepi8_mask(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movepi8_mask(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_movepi8_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_movepi8_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([0, -1, 2, -3]));
        check_int_equality(result, 61680).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([100, 200, 300, 400]));
        check_int_equality(result, 4112).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 34952).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 30583).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_movepi8_mask_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movepi8_mask(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 61560).map_err(|e| crate::cpu::with_call(e, "_mm_movepi8_mask(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movepi8_mask(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_movepi8_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_movepi8_mask_boundary_mixed_impl() }
}
