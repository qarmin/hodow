use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_faminmax_vamaxq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vamaxq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0])));

        crate::cpu::fuzz(&mut || {
            let _ = vamaxq_f32(create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_faminmax_vamaxq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vamaxq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));

        crate::cpu::fuzz(&mut || {
            let _ = vamaxq_f64(create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
