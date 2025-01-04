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

pub(super) fn test_arm_shared_sha2_vsha1mq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsha1mq_u32(create_uint32x4_t_from([1, 2, 3, 4]), 5u32, create_uint32x4_t_from([6, 7, 8, 9])));
        check_array_equality(&result, &[3222712689, 46475, 363, 1073741835]).map_err(|e| crate::cpu::with_call(e, "vsha1mq_u32(create_uint32x4_t_from([1, 2, 3, 4]), 5u32, create_uint32x4_t_from([6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsha1mq_u32(create_random_uint32x4_t(), rand::random::<u32>(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
