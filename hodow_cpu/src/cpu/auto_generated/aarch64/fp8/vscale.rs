use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_fp8_vscale_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vscale_f32(create_float32x2_t_from([1.0, 2.0]), create_int32x2_t_from([3, 4])));

        crate::cpu::fuzz(&mut || {
            let _ = vscale_f32(create_random_float32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
