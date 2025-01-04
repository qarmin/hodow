use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_caf_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_caf_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_caf_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_caf_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_caf_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_caf_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_ceq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_ceq_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_ceq_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_ceq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_ceq_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_ceq_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cle_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cle_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cle_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cle_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cle_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cle_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_clt_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_clt_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_clt_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_clt_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_clt_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_clt_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cne_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cne_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cne_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cne_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cne_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cne_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cor_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cor_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cor_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cor_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cor_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cor_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cueq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cueq_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cueq_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cueq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cueq_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cueq_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cule_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cule_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cule_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cule_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cule_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cule_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cult_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cult_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cult_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cult_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cult_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cult_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cun_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cun_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cun_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cune_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cune_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cune_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cune_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cune_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cune_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_cun_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_cun_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_cun_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_saf_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_saf_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_saf_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_saf_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_saf_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_saf_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_seq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_seq_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_seq_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_seq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_seq_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_seq_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sle_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sle_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sle_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sle_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sle_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sle_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_slt_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_slt_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_slt_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_slt_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_slt_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_slt_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sne_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sne_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sne_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sne_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sne_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sne_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sor_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sor_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sor_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sor_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sor_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sor_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sueq_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sueq_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sueq_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sueq_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sueq_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sueq_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sule_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sule_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sule_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sule_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sule_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sule_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sult_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sult_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sult_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sult_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sult_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sult_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sun_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sun_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sun_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sune_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sune_d(0 /* m128d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sune_d(0 /* m128d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sune_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sune_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sune_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sun_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfcmp_sun_s(0 /* m128 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfcmp_sun_s(0 /* m128 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
