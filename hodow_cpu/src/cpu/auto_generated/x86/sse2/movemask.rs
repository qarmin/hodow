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

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 43690).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]));
        check_int_equality(result, 19290).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result, 39321).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_movemask_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_movemask_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "_mm_movemask_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movemask_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_movemask_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_movemask_pd_boundary_mixed_impl() }
}
