use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vdiv_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_b(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_b(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vdiv_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_h(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_h(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vdiv_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_w(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_w(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vdiv_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_d(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_d(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vdiv_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_bu(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_bu(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vdiv_hu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_hu(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_hu(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vdiv_wu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_wu(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_wu(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vdiv_du() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vdiv_du(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vdiv_du(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
