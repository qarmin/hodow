use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_fp8_vscaleq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vscaleq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_int32x4_t_from([5, 6, 7, 8])));

        crate::cpu::fuzz(&mut || {
            let _ = vscaleq_f32(create_random_float32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_fp8_vscaleq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vscaleq_f64(create_float64x2_t_from([1.0, 2.0]), create_int64x2_t_from([3, 4])));

        crate::cpu::fuzz(&mut || {
            let _ = vscaleq_f64(create_random_float64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
