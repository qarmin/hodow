use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_test_mask() -> Result<Verdict, String> {
    unsafe {
        let result = vec_test_mask(0 /* T */, 0 /* Mask */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_test_mask(0 /* T */, 0 /* Mask */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
