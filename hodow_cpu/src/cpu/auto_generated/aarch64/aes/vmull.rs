use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_aes_vmull_high_p64() -> Result<Verdict, String> {
    unsafe {
        let result = vmull_high_p64(create_poly64x2_t_from([1, 2]), create_poly64x2_t_from([3, 4]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vmull_high_p64(create_poly64x2_t_from([1, 2]), create_poly64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmull_high_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_aes_vmull_p64() -> Result<Verdict, String> {
    unsafe {
        let result = vmull_p64(1u64, 2u64);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vmull_p64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmull_p64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
