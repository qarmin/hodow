use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vslid_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_s64::<0>(1i64, 2i64);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vslid_n_s64::<0>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_s64::<0>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_s64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_s64::<1>(1i64, 2i64);
        check_int_equality(result, 5).map_err(|e| crate::cpu::with_call(e, "vslid_n_s64::<1>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_s64::<1>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_s64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_s64::<63>(1i64, 2i64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vslid_n_s64::<63>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_s64::<63>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_s64::<31>(1i64, 2i64);
        check_int_equality(result, 4294967297).map_err(|e| crate::cpu::with_call(e, "vslid_n_s64::<31>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_s64::<31>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_s64::<32>(1i64, 2i64);
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "vslid_n_s64::<32>(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_s64::<32>(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_u64::<0>(1u64, 2u64);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vslid_n_u64::<0>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_u64::<0>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_u64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_u64::<1>(1u64, 2u64);
        check_int_equality(result, 5).map_err(|e| crate::cpu::with_call(e, "vslid_n_u64::<1>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_u64::<1>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_u64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_u64::<63>(1u64, 2u64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vslid_n_u64::<63>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_u64::<63>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_u64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_u64::<31>(1u64, 2u64);
        check_int_equality(result, 4294967297).map_err(|e| crate::cpu::with_call(e, "vslid_n_u64::<31>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_u64::<31>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vslid_n_u64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vslid_n_u64::<32>(1u64, 2u64);
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "vslid_n_u64::<32>(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vslid_n_u64::<32>(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
