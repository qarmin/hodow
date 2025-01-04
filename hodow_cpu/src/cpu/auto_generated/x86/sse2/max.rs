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
fn test_x86_sse2_mm_max_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 210, 310, 410, 510, 610, 710, 810]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_max_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epi16(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i16_array([1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16]);
        let b = create__m128i_from_i16_array([9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16]);
        let lhs = unpack__m128i_to_i16_array(_mm_max_epi16(a, b));
        let rhs = unpack__m128i_to_i16_array(_mm_max_epi16(b, a));
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(a, b) vs _mm_max_epi16(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_prop_commutative_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epi16_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i16_array([1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16]);
        let lhs = unpack__m128i_to_i16_array(_mm_max_epi16(a, a));
        let rhs = unpack__m128i_to_i16_array(a);
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_max_epi16(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epi16_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epi16_prop_idempotent_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)])));
        check_array_equality(&result, &[10, 255, 12, 253, 14, 251, 16, 249, 10, 255, 12, 253, 14, 251, 16, 249]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)])));
        check_array_equality(&result, &[110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_max_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_epu8(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i8_array([1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8]);
        let b = create__m128i_from_i8_array([17i8, 18i8, 19i8, 20i8, 21i8, 22i8, 23i8, 24i8, 25i8, 26i8, 27i8, 28i8, 29i8, 30i8, 31i8, 32i8]);
        let lhs = unpack__m128i_to_u8_array(_mm_max_epu8(a, b));
        let rhs = unpack__m128i_to_u8_array(_mm_max_epu8(b, a));
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(a, b) vs _mm_max_epu8(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_prop_commutative_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_epu8_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i8_array([1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8]);
        let lhs = unpack__m128i_to_u8_array(_mm_max_epu8(a, a));
        let rhs = unpack__m128i_to_u8_array(a);
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_max_epu8(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_epu8_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_epu8_prop_idempotent_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_sd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_sd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0, 9.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0, 210.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_max_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([1.0f64, 2.0f64]);
        let b = create__m128d_from([3.0f64, 4.0f64]);
        let lhs = unpack__m128d_to_f64_array(_mm_max_pd(a, b));
        let rhs = unpack__m128d_to_f64_array(_mm_max_pd(b, a));
        check_float_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(a, b) vs _mm_max_pd(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_prop_commutative_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_max_pd_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([1.0f64, 2.0f64]);
        let lhs = unpack__m128d_to_f64_array(_mm_max_pd(a, a));
        let rhs = unpack__m128d_to_f64_array(a);
        check_float_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm_max_pd(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_max_pd_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_max_pd_prop_idempotent_impl() }
}
