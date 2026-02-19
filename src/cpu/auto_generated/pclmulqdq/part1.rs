use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_clmulepi64_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}
