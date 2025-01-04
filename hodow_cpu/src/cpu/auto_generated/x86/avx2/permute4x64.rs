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

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, 8589934593, 8589934593, 8589934593]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 100, 100, 100]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[17179869187, 8589934593, 8589934593, 8589934593]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<1>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[34359738375, 34359738375, 34359738375, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<255>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_imm_255_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_imm_63_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<63>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[34359738375, 34359738375, 34359738375, 8589934593]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<63>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<63>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_imm_63() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_imm_63_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_epi64_imm_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permute4x64_epi64::<64>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, 8589934593, 8589934593, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_epi64::<64>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_epi64::<64>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_epi64_imm_64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_epi64_imm_64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 100.0, 100.0, 100.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<1>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_imm_1_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 4.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<255>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_imm_255_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<31>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_imm_31_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permute4x64_pd_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute4x64_pd::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute4x64_pd::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute4x64_pd::<32>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permute4x64_pd_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permute4x64_pd_imm_32_impl() }
}
