use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_vsumqg() -> Result<Verdict, String> {
    unsafe {
        let result = vec_vsumqg(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);

        crate::cpu::fuzz(&mut || {
            let _ = vec_vsumqg(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
