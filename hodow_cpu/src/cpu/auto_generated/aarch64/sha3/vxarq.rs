use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_sha3_vxarq_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vxarq_u64::<0>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 6]).map_err(|e| crate::cpu::with_call(e, "vxarq_u64::<0>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vxarq_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sha3_vxarq_u64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vxarq_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 3]).map_err(|e| crate::cpu::with_call(e, "vxarq_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vxarq_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sha3_vxarq_u64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vxarq_u64::<63>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[4, 12]).map_err(|e| crate::cpu::with_call(e, "vxarq_u64::<63>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vxarq_u64::<63>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sha3_vxarq_u64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vxarq_u64::<31>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[17179869184, 51539607552]).map_err(|e| crate::cpu::with_call(e, "vxarq_u64::<31>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vxarq_u64::<31>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
