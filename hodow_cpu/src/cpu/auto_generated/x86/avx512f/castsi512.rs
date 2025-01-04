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

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si128(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_si256_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_si256(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_si256(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_si256_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_si256_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castsi512_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[1e-45, 3e-45, 4e-45, 6e-45, 7e-45, 8e-45, 1e-44, 1.1e-44, 1.3e-44, 1.4e-44, 1.5e-44, 1.7e-44, 1.8e-44, 2e-44, 2.1e-44, 2.2e-44]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_ps(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi512_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castsi512_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314, 1.27319747483e-313, 1.6975966331e-313, 2.1219957914e-313, 2.5463949497e-313, 2.970794108e-313, 3.3951932663e-313]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi512_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi512_pd(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi512_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi512_pd_impl() }
}
