use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_va_float() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(va_float(0 /* vector_float */, 0 /* vector_float */));

        crate::cpu::fuzz(&mut || {
            let _ = va_float(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(None))
    }
}
