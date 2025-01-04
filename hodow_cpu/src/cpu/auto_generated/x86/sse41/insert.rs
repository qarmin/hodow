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

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<1>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<255>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_imm_255_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<31>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_imm_31_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_ps_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_insert_ps::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 5.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_ps::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_ps::<32>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_ps_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_ps_imm_32_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[5, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), 1i32));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), 1i32));
        check_array_equality(&result, &[1, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), 1i32));
        check_array_equality(&result, &[1, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), 1i32));
        check_array_equality(&result, &[1, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), 1i32));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), 1i32));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), 1i32));
        check_array_equality(&result, &[1, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[1, 5, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<1>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<15>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 5]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<15>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<15>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_imm_15() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_imm_15_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 5, 3, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<7>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_imm_7_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi8_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_insert_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 5, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi8::<8>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi8_imm_8_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32));
        check_array_equality(&result, &[1, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32));
        check_array_equality(&result, &[1, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32));
        check_array_equality(&result, &[1, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32));
        check_array_equality(&result, &[1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32));
        check_array_equality(&result, &[1, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<0>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[1, 5, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<1>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_insert_epi32_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi32::<3>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[1, 2, 3, 5]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi32::<3>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi32::<3>(create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_insert_epi32_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_insert_epi32_imm_3_impl() }
}
