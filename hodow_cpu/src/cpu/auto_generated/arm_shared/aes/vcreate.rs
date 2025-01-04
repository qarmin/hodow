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

pub(super) fn test_arm_shared_aes_vcreate_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcreate_p64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vcreate_p64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_p64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
