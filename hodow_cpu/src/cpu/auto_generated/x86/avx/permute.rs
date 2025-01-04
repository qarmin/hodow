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

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 5.0, 5.0, 5.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 4.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_float_array_equality(&result, &[100.0, 100.0, 100.0, 100.0, 500.0, 500.0, 500.0, 500.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 6.0, 5.0, 5.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<1>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<255>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 4.0, 4.0, 8.0, 8.0, 8.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<255>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<255>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_imm_255_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<31>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 2.0, 1.0, 8.0, 8.0, 6.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<31>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<31>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_imm_31_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_ps_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permute_ps::<32>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 1.0, 5.0, 5.0, 7.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_ps::<32>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_ps::<32>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_ps_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_ps_imm_32_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[100.0, 100.0, 100.0, 100.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<1>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 4.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<255>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_imm_255_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<31>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_imm_31_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_ps_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_ps::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_ps::<32>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_ps_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_ps_imm_32_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 3.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 100.0, 300.0, 300.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, -0.0, -0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 1.0, 3.0, 3.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<1>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<15>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 2.0, 4.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<15>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<15>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_imm_15() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_imm_15_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_permute_pd_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permute_pd::<7>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 2.0, 4.0, 3.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permute_pd::<7>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permute_pd::<7>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_permute_pd_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_permute_pd_imm_7_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 100.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<1>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<1>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<1>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_permute_pd_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<3>(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[2.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_permute_pd::<3>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_permute_pd::<3>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_permute_pd_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_permute_pd_imm_3_impl() }
}
