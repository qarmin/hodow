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

pub(super) fn test_arm_shared_vfp4_vfmaq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmaq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[46.0, 62.0, 80.0, 100.0]).map_err(|e| crate::cpu::with_call(e, "vfmaq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmaq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_vfp4_vfmaq_n_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmaq_n_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), 9.0f32));
        check_float_array_equality(&result, &[46.0, 56.0, 66.0, 76.0]).map_err(|e| crate::cpu::with_call(e, "vfmaq_n_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), 9.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmaq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}
