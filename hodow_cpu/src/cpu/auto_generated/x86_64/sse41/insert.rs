use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i64));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i64_array([0, -1]), 1i64));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i64_array([0, -1]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i64_array([100, 200]), 1i64));
        check_array_equality(&result, &[1, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i64_array([100, 200]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), 1i64));
        check_array_equality(&result, &[1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i64_array([i64::MAX, i64::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i64_array([0, 0]), 1i64));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i64_array([0, 0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i64_array([-1, -1]), 1i64));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i64_array([-1, -1]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MAX]), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<0>(create__m128i_from_i64_array([i64::MIN, i64::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_64_sse41_mm_insert_epi64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_insert_epi64::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i64));
        check_array_equality(&result, &[8589934593, 5]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_epi64::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_epi64::<1>(create_random__m128i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse41_mm_insert_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse41_mm_insert_epi64_imm_1_impl() }
}
