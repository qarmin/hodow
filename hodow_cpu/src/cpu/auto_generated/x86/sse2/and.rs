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
fn test_x86_sse2_mm_and_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 9, 0, 5]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 192, 292, 400]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_and_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1i32, 2i32, 3i32, 4i32]);
        let b = create__m128i_from_i32_array([5i32, 6i32, 7i32, 8i32]);
        let lhs = unpack__m128i_to_i32_array(_mm_and_si128(a, b));
        let rhs = unpack__m128i_to_i32_array(_mm_and_si128(b, a));
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(a, b) vs _mm_and_si128(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_prop_commutative_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_si128_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1i32, 2i32, 3i32, 4i32]);
        let lhs = unpack__m128i_to_i32_array(_mm_and_si128(a, a));
        let rhs = unpack__m128i_to_i32_array(a);
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_and_si128(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_si128_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_si128_prop_idempotent_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, 4.450147717014403e-308]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[100.0, 192.0]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_and_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_and_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([1.0f64, 2.0f64]);
        let b = create__m128d_from([3.0f64, 4.0f64]);
        let lhs = unpack__m128d_to_f64_array(_mm_and_pd(a, b));
        let rhs = unpack__m128d_to_f64_array(_mm_and_pd(b, a));
        check_float_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(a, b) vs _mm_and_pd(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_prop_commutative_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_and_pd_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([1.0f64, 2.0f64]);
        let lhs = unpack__m128d_to_f64_array(_mm_and_pd(a, a));
        let rhs = unpack__m128d_to_f64_array(a);
        check_float_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_and_pd(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_and_pd_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_and_pd_prop_idempotent_impl() }
}
