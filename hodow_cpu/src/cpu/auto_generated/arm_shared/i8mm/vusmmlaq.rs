#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_arm_shared_i8mm_vusmmlaq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusmmlaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[1709, 2254, 3279, 4336]).map_err(|e| crate::cpu::with_call(e, "vusmmlaq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusmmlaq_s32(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}
