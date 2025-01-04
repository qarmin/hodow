use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcvtd_f64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_f64_s64(1i64);
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vcvtd_f64_s64(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_f64_s64(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_f64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_f64_u64(1u64);
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vcvtd_f64_u64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_f64_u64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_s64::<1>(1i64);
        check_float_equality(result, 0.5).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_s64::<1>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_s64::<1>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_s64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_s64::<2>(1i64);
        check_float_equality(result, 0.25).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_s64::<2>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_s64::<2>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_s64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_s64::<64>(1i64);
        check_float_equality(result, 5.421010862427522e-20).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_s64::<64>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_s64::<64>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_s64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_s64::<31>(1i64);
        check_float_equality(result, 4.656612873077393e-10).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_s64::<31>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_s64::<31>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_s64::<32>(1i64);
        check_float_equality(result, 2.3283064365386963e-10).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_s64::<32>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_s64::<32>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_u64::<1>(1u64);
        check_float_equality(result, 0.5).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_u64::<1>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_u64::<1>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_u64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_u64::<2>(1u64);
        check_float_equality(result, 0.25).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_u64::<2>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_u64::<2>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_u64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_u64::<64>(1u64);
        check_float_equality(result, 5.421010862427522e-20).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_u64::<64>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_u64::<64>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_u64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_u64::<31>(1u64);
        check_float_equality(result, 4.656612873077393e-10).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_u64::<31>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_u64::<31>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_f64_u64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_f64_u64::<32>(1u64);
        check_float_equality(result, 2.3283064365386963e-10).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_f64_u64::<32>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_f64_u64::<32>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_s64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_s64_f64::<1>(1.0f64);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_s64_f64::<1>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_s64_f64::<1>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_s64_f64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_s64_f64::<2>(1.0f64);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_s64_f64::<2>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_s64_f64::<2>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_s64_f64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_s64_f64::<64>(1.0f64);
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_s64_f64::<64>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_s64_f64::<64>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_s64_f64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_s64_f64::<31>(1.0f64);
        check_int_equality(result, 2147483648).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_s64_f64::<31>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_s64_f64::<31>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_s64_f64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_s64_f64::<32>(1.0f64);
        check_int_equality(result, 4294967296).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_s64_f64::<32>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_s64_f64::<32>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_u64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_u64_f64::<1>(1.0f64);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_u64_f64::<1>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_u64_f64::<1>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_u64_f64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_u64_f64::<2>(1.0f64);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_u64_f64::<2>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_u64_f64::<2>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_u64_f64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_u64_f64::<64>(1.0f64);
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_u64_f64::<64>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_u64_f64::<64>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_u64_f64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_u64_f64::<31>(1.0f64);
        check_int_equality(result, 2147483648).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_u64_f64::<31>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_u64_f64::<31>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_n_u64_f64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_n_u64_f64::<32>(1.0f64);
        check_int_equality(result, 4294967296).map_err(|e| crate::cpu::with_call(e, "vcvtd_n_u64_f64::<32>(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_n_u64_f64::<32>(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_s64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_s64_f64(1.0f64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vcvtd_s64_f64(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_s64_f64(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtd_u64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtd_u64_f64(1.0f64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vcvtd_u64_f64(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtd_u64_f64(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}
