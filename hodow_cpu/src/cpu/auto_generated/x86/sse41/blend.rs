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
fn test_x86_sse41_mm_blend_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<1>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<255>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_imm_255_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<15>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<15>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<15>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_imm_15() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_imm_15_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_epi16_imm_16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_blend_epi16::<16>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 7, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_epi16::<16>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_epi16::<16>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_epi16_imm_16() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_epi16_imm_16_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<0>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<1>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<1>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_pd_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_blend_pd::<3>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_pd::<3>(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_pd::<3>(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_pd_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_pd_imm_3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<0>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<1>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<15>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<15>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<15>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_imm_15() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_imm_15_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_blend_ps_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_blend_ps::<7>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 6.0, 7.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_blend_ps::<7>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_blend_ps::<7>(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_blend_ps_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_blend_ps_imm_7_impl() }
}
