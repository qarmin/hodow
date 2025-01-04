use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_sm4_vsm3tt2aq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsm3tt2aq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[2, 1572864, 4, 3026455]).map_err(|e| crate::cpu::with_call(e, "vsm3tt2aq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsm3tt2aq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sm4_vsm3tt2aq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsm3tt2aq_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[2, 1572864, 4, 3158040]).map_err(|e| crate::cpu::with_call(e, "vsm3tt2aq_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsm3tt2aq_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sm4_vsm3tt2aq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsm3tt2aq_u32::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[2, 1572864, 4, 3421210]).map_err(|e| crate::cpu::with_call(e, "vsm3tt2aq_u32::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsm3tt2aq_u32::<3>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
