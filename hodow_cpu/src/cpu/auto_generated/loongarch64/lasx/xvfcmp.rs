use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_caf_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_caf_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_caf_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_caf_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_caf_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_caf_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_ceq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_ceq_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_ceq_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_ceq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_ceq_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_ceq_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cle_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cle_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cle_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cle_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cle_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cle_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_clt_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_clt_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_clt_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_clt_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_clt_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_clt_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cne_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cne_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cne_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cne_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cne_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cne_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cor_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cor_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cor_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cor_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cor_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cor_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cueq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cueq_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cueq_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cueq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cueq_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cueq_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cule_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cule_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cule_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cule_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cule_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cule_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cult_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cult_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cult_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cult_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cult_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cult_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cun_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cun_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cun_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cune_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cune_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cune_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cune_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cune_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cune_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cun_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_cun_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_cun_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_saf_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_saf_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_saf_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_saf_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_saf_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_saf_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_seq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_seq_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_seq_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_seq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_seq_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_seq_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sle_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sle_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sle_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sle_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sle_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sle_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_slt_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_slt_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_slt_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_slt_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_slt_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_slt_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sne_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sne_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sne_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sne_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sne_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sne_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sor_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sor_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sor_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sor_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sor_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sor_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sueq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sueq_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sueq_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sueq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sueq_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sueq_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sule_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sule_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sule_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sule_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sule_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sule_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sult_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sult_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sult_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sult_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sult_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sult_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sun_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sun_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sun_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sune_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sune_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sune_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sune_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sune_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sune_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sun_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfcmp_sun_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfcmp_sun_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
