use std::arch::x86_64::{__m128i, _mm_broadcastd_epi32, _mm_set_epi32};

use log::info;

use crate::cpu::common::check_array_equality;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_broadcastd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 0, 42);
        let result = _mm_broadcastd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[42, 42, 42, 42])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_broadcastd_epi32(_mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random()));
            }
        }
    }

    Ok(())
}
