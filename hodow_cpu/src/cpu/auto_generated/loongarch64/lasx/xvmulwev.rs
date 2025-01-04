use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_q_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_q_d(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_q_d(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_d_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_d_w(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_d_w(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_w_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_w_h(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_w_h(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_h_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_h_b(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_h_b(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_q_du() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_q_du(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_q_du(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_d_wu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_d_wu(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_d_wu(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_w_hu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_w_hu(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_w_hu(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_h_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_h_bu(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_h_bu(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_d_wu_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_d_wu_w(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_d_wu_w(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_w_hu_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_w_hu_h(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_w_hu_h(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_h_bu_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_h_bu_b(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_h_bu_b(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmulwev_q_du_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmulwev_q_du_d(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmulwev_q_du_d(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
