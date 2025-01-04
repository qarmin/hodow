use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_sha3_vsha512hq_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsha512hq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]), create_uint64x2_t_from([5, 6])));
        check_array_equality(&result, &[11189044327219203, 7177611956453380]).map_err(|e| crate::cpu::with_call(e, "vsha512hq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]), create_uint64x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsha512hq_u64(create_random_uint64x2_t(), create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
