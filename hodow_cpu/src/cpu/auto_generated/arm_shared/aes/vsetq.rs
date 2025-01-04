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

pub(super) fn test_arm_shared_aes_vsetq_lane_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vsetq_lane_p64::<0>(1u64, create_poly64x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| crate::cpu::with_call(e, "vsetq_lane_p64::<0>(1u64, create_poly64x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsetq_lane_p64::<0>(rand::random::<u64>(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vsetq_lane_p64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vsetq_lane_p64::<1>(1u64, create_poly64x2_t_from([2, 3])));
        check_array_equality(&result, &[2, 1]).map_err(|e| crate::cpu::with_call(e, "vsetq_lane_p64::<1>(1u64, create_poly64x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsetq_lane_p64::<1>(rand::random::<u64>(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
