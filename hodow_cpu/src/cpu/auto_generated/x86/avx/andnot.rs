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
fn test_x86_avx_mm256_andnot_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[2.5, 3.337610787760802e-308, 2.7813423231340017e-308, 4.450147717014403e-308]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[10.0, 2.25, 6.675221575521604e-308, 2.7813423231340017e-308]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[3.4766779039175e-309, 3.12901011352575e-309, 1.564505056762876e-309, 8.69169475979376e-310]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_andnot_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-0.0, -0.0, -0.0, -0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx,sse2")]
fn test_x86_avx_mm256_andnot_pd_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse2")) {
            return Ok(Verdict::Skipped("sse2 not present"));
        }
    unsafe {
        let a_wide = create__m256d_from([1.0f64, 2.0f64, 3.0f64, 4.0f64]);
        let a_narrow = create__m128d_from([1.0f64, 2.0f64]);
        let b_wide = create__m256d_from([5.0f64, 6.0f64, 7.0f64, 8.0f64]);
        let b_narrow = create__m128d_from([5.0f64, 6.0f64]);
        let wide = unpack__m256d_to_f64_array(_mm256_andnot_pd(a_wide, b_wide));
        let narrow = unpack__m128d_to_f64_array(_mm_andnot_pd(a_narrow, b_narrow));
        check_float_array_equality(&wide[..2], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(a_wide, b_wide) vs _mm_andnot_pd(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_vs_narrow_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_pd_prop_self_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256d_from([1.0f64, 2.0f64, 3.0f64, 4.0f64]);
        let zero = create__m256d_from([0.0, 0.0, 0.0, 0.0]);
        let lhs = unpack__m256d_to_f64_array(_mm256_andnot_pd(a, a));
        let rhs = unpack__m256d_to_f64_array(zero);
        check_float_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_pd(a, a) vs zero"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_pd_prop_self_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_pd_prop_self_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[2.25, 2.938736e-38, 3.2326095e-38, 3.526483e-38, 3.8203566e-38, 2.938736e-38, 2.6448623e-38, 1.1754944e-38]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_float_array_equality(&result, &[10.0, 2.25, 3.526483e-38, 1.469368e-38, 4.1142302e-38, 0.0, 2.3509887e-38, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_float_array_equality(&result, &[1.83671e-39, 1.653039e-39, 8.2652e-40, 4.59177e-40, 4.59177e-40, 7.80602e-40, 1.515286e-39, 2.29589e-40]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_andnot_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_andnot_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_asym_max_min_impl() }
}

#[target_feature(enable = "avx,sse")]
fn test_x86_avx_mm256_andnot_ps_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse")) {
            return Ok(Verdict::Skipped("sse not present"));
        }
    unsafe {
        let a_wide = create__m256_from([1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32]);
        let a_narrow = create__m128_from([1.0f32, 2.0f32, 3.0f32, 4.0f32]);
        let b_wide = create__m256_from([9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32]);
        let b_narrow = create__m128_from([9.0f32, 10.0f32, 11.0f32, 12.0f32]);
        let wide = unpack__m256_to_f32_array(_mm256_andnot_ps(a_wide, b_wide));
        let narrow = unpack__m128_to_f32_array(_mm_andnot_ps(a_narrow, b_narrow));
        check_float_array_equality(&wide[..4], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(a_wide, b_wide) vs _mm_andnot_ps(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_vs_narrow_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_andnot_ps_prop_self_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256_from([1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32]);
        let zero = create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        let lhs = unpack__m256_to_f32_array(_mm256_andnot_ps(a, a));
        let rhs = unpack__m256_to_f32_array(zero);
        check_float_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm256_andnot_ps(a, a) vs zero"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_andnot_ps_prop_self_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_andnot_ps_prop_self_zero_impl() }
}
