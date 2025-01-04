use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_b_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_b_h::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_b_h::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_h_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_h_w::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_h_w::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_w_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_w_d::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_w_d::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_d_q() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_d_q::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_d_q::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_bu_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_bu_h::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_bu_h::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_hu_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_hu_w::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_hu_w::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_wu_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_wu_d::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_wu_d::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlni_du_q() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvssrlni_du_q::<0>(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvssrlni_du_q::<0>(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
