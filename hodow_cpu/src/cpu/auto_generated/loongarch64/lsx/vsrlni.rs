use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vsrlni_b_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsrlni_b_h::<0>(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsrlni_b_h::<0>(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsrlni_h_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsrlni_h_w::<0>(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsrlni_h_w::<0>(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsrlni_w_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsrlni_w_d::<0>(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsrlni_w_d::<0>(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsrlni_d_q() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsrlni_d_q::<0>(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsrlni_d_q::<0>(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
