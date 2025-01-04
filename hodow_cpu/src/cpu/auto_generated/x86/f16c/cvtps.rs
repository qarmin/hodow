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

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[-1140850688, -1040171008, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_normal2_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[1514165824, 1581276336, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_normal3_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-67044352, -67044352, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_boundary_min_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2080406528, 2080406528, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_boundary_max_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_boundary_zero_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[2113961472, 2113961472, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_boundary_allones_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[-67077120, 32768, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_boundary_mixed_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<1>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_imm_1_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<4>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<4>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_imm_4_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtps_ph_imm_2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_ph::<2>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_ph::<2>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_ph::<2>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtps_ph_imm_2() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtps_ph_imm_2_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 1174422784, 1207977728]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[-1140850688, -1040171008, -989838336, -956283392]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_normal2_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_array_equality(&result, &[1514165824, 1581276336, 1622171600, 1648386424]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_normal3_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-67044352, -67044352, -67044352, -67044352]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_boundary_min_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2080406528, 2080406528, 2080406528, 2080406528]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_boundary_max_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_boundary_zero_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[2113961472, 2113961472, 2113961472, 2113961472]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_boundary_allones_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[-67077120, 32768, -67077120, 32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_boundary_mixed_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 1174422784, 1207977728]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<1>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_imm_1_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<4>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 1174422784, 1207977728]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<4>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<4>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_imm_4_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtps_ph_imm_2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_cvtps_ph::<2>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1073757184, 1140867584, 1174422784, 1207977728]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtps_ph::<2>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtps_ph::<2>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtps_ph_imm_2() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtps_ph_imm_2_impl() }
}
