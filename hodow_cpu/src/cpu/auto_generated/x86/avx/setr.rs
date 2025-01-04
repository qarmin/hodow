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
fn test_x86_avx_mm256_setr_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_pd(rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_setr_epi8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8, 17i8, 18i8, 19i8, 20i8, 21i8, 22i8, 23i8, 24i8, 25i8, 26i8, 27i8, 28i8, 29i8, 30i8, 31i8, 32i8));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_epi8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8, 17i8, 18i8, 19i8, 20i8, 21i8, 22i8, 23i8, 24i8, 25i8, 26i8, 27i8, 28i8, 29i8, 30i8, 31i8, 32i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_epi8(rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_epi8_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_setr_epi16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_epi16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_epi16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_epi16_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_epi32(1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_epi32(1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_epi32_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_epi64x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_epi64x(1i64, 2i64, 3i64, 4i64));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_epi64x(1i64, 2i64, 3i64, 4i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_epi64x(rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_epi64x() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_epi64x_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 10.0, 9.0, 12.0, 7.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 110.0, 210.0, 310.0, 410.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setr_m128(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128_asym_max_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0, 10.0, 9.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0, 110.0, 210.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128d_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setr_m128d(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128d(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128d(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128d_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128d_asym_max_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 2, -3, 10, 9, 12, 7]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 200, 300, 400, 110, 210, 310, 410]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setr_m128i_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setr_m128i(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_setr_m128i(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setr_m128i(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setr_m128i_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setr_m128i_asym_max_min_impl() }
}
