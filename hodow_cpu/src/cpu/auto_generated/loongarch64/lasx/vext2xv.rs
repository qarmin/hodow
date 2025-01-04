use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_h_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_h_b(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_h_b(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_w_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_w_h(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_w_h(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_d_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_d_w(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_d_w(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_w_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_w_b(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_w_b(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_d_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_d_h(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_d_h(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_d_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_d_b(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_d_b(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_hu_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_hu_bu(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_hu_bu(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_wu_hu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_wu_hu(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_wu_hu(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_du_wu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_du_wu(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_du_wu(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_wu_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_wu_bu(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_wu_bu(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_du_hu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_du_hu(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_du_hu(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_vext2xv_du_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_vext2xv_du_bu(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_vext2xv_du_bu(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
