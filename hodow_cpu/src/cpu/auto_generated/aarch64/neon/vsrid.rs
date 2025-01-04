use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vsrid_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_s64::<1>(1i64, 2i64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vsrid_n_s64::<1>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_s64::<1>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_s64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_s64::<2>(1i64, 2i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vsrid_n_s64::<2>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_s64::<2>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_s64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_s64::<64>(1i64, 2i64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vsrid_n_s64::<64>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_s64::<64>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_s64::<31>(1i64, 2i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vsrid_n_s64::<31>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_s64::<31>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_s64::<32>(1i64, 2i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vsrid_n_s64::<32>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_s64::<32>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_u64::<1>(1u64, 2u64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vsrid_n_u64::<1>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_u64::<1>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_u64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_u64::<2>(1u64, 2u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vsrid_n_u64::<2>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_u64::<2>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_u64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_u64::<64>(1u64, 2u64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vsrid_n_u64::<64>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_u64::<64>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_u64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_u64::<31>(1u64, 2u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vsrid_n_u64::<31>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_u64::<31>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsrid_n_u64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vsrid_n_u64::<32>(1u64, 2u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vsrid_n_u64::<32>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsrid_n_u64::<32>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
