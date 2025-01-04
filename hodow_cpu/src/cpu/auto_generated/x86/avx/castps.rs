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
fn test_x86_avx_mm256_castps_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castps_pd(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[2.000000473111868, 512.0001225471497, 8192.001972198486, 131072.0316772461]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_pd(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_pd(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1065353216, 1073741824, 1077936128, 1082130432, 1084227584, 1086324736, 1088421888, 1090519040]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[0, -1082130432, 1073741824, -1069547520, 1082130432, -1063256064, 1086324736, -1059061760]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_array_equality(&result, &[1120403456, 1128792064, 1133903872, 1137180672, 1140457472, 1142292480, 1143930880, 1145569280]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-8388609, -8388609, -8388609, -8388609, -8388609, -8388609, -8388609, -8388609]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2139095039, 2139095039, 2139095039, 2139095039, 2139095039, 2139095039, 2139095039, 2139095039]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[2143289344, 2143289344, 2143289344, 2143289344, 2143289344, 2143289344, 2143289344, 2143289344]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castps_si256_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castps_si256(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[2139095040, -8388608, -2147483648, 4194304, 2139095040, -8388608, -2147483648, 4194304]).map_err(|e| crate::cpu::with_call(e, "_mm256_castps_si256(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castps_si256(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castps_si256_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castps_si256_boundary_mixed_impl() }
}
