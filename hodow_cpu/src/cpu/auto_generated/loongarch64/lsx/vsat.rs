use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vsat_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_b::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_b::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_h::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_h::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_w::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_w::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_d::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_d::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_bu::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_bu::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_hu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_hu::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_hu::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_wu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_wu::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_wu::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_du() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vsat_du::<0>(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vsat_du::<0>(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
