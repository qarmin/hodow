use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_msum_u128() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_msum_u128::<0>(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_msum_u128::<0>(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
