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

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal2_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_normal3_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_avx_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_avx_pbh(create_random__m128());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneps_avx_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal2_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_normal3_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_avx_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneps_avx_pbh_boundary_mixed_impl() }
}
