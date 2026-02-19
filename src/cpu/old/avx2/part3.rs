use std::arch::x86_64::{_mm_broadcastd_epi32, _mm_set_epi32};

use crate::cpu::common::check_array_equality;
use crate::cpu::common::values::unpack__m128i_to_i32_array;

test_simd!(
    test_mm_broadcastd_epi32,
    {
        let result = unpack__m128i_to_i32_array(_mm_broadcastd_epi32(_mm_set_epi32(0, 0, 0, 42)));
        check_array_equality(&result, &[42, 42, 42, 42])?;
    },
    _mm_broadcastd_epi32(_mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random()))
);
