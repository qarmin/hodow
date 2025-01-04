use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<4>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<4>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<4>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_sd_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<11>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_sd::<11>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_sd::<11>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_sd_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_sd_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<8>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<4>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<4>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<4>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<11>(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_sd::<11>(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_sd::<11>(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_sd_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_sd_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<4>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundi64_ss_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundi64_ss::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundi64_ss::<11>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundi64_ss_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundi64_ss_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([1.0, 2.0]), 3u64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([1.0, 2.0]), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0f64, -1.0f64]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1u64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([100.0f64, 200.0f64]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MIN, f64::MIN]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1u64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::MAX, f64::MAX]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0, 0.0]), 1u64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([0.0, 0.0]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1u64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::NAN, f64::NAN]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1u64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<8>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<4>(create__m128d_from([1.0, 2.0]), 3u64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<4>(create__m128d_from([1.0, 2.0]), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<4>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_sd_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<11>(create__m128d_from([1.0, 2.0]), 3u64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_sd::<11>(create__m128d_from([1.0, 2.0]), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_sd::<11>(create_random__m128d(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_sd_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_sd_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<8>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<4>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsi64_ss::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsi64_ss::<11>(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsi64_ss_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsi64_ss_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1u64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1u64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1u64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1u64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1u64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1u64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1u64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<8>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<4>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundu64_ss_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundu64_ss::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundu64_ss::<11>(create_random__m128(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundu64_ss_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundu64_ss_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<4>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<4>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<4>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_si64_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_si64::<11>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_si64::<11>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_si64::<11>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_si64_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_si64_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<4>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<4>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<4>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_i64_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_i64::<11>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_i64::<11>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_i64::<11>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_i64_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_i64_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<8>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<8>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<4>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<4>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<4>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundsd_u64_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundsd_u64::<11>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundsd_u64::<11>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundsd_u64::<11>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundsd_u64_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundsd_u64_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<4>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_si64_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_si64::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_si64::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_si64::<11>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_si64_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_si64_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<4>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_i64_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_i64::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_i64::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_i64::<11>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_i64_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_i64_imm_11_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<8>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<8>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<4>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_imm_4_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_64_avx512f_mm_cvt_roundss_u64_imm_11_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_cvt_roundss_u64::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvt_roundss_u64::<11>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvt_roundss_u64::<11>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx512f_mm_cvt_roundss_u64_imm_11() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx512f_mm_cvt_roundss_u64_imm_11_impl() }
}
