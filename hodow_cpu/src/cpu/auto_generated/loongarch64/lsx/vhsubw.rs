use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_h_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_h_b(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_h_b(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_w_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_w_h(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_w_h(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_d_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_d_w(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_d_w(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_hu_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_hu_bu(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_hu_bu(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_wu_hu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_wu_hu(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_wu_hu(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_du_wu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_du_wu(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_du_wu(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_q_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_q_d(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_q_d(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vhsubw_qu_du() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vhsubw_qu_du(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vhsubw_qu_du(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
