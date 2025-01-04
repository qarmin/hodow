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

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-4.0, 8.0, -4.0, 12.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[-10.0, 8.0, -10.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_normal2_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[-10.0, 410.0, -10.0, 810.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_normal3_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, 0.0, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, f32::INFINITY, 0.0, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, 0.0, 1.1754944e-38]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, 0.0, -f32::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_addsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, f32::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[-2.0, 6.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[-10.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_normal2_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[-10.0, 410.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_normal3_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[0.0, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[0.0, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_asym_min_max_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_addsub_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_addsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_addsub_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_addsub_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_addsub_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_addsub_pd_asym_max_min_impl() }
}
