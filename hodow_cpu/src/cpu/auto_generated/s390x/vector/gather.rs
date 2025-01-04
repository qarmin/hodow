use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_gather_element() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_gather_element::<0>(0 /* T */, 0 /* Offset */, 0 /* Element */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_gather_element::<0>(0 /* T */, 0 /* Offset */, 0 /* Element */);
        });
        Ok(Verdict::Unverified(None))
    }
}
