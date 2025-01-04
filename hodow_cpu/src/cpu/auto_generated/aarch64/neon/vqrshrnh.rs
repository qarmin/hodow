use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqrshrnh_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_u16::<1>(1u16);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_u16::<1>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_u16::<1>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_u16_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_u16::<2>(1u16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_u16::<2>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_u16::<2>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_u16_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_u16::<8>(1u16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_u16::<8>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_u16::<8>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_u16_imm_4() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_u16::<4>(1u16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_u16::<4>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_u16::<4>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_s16::<1>(1i16);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_s16::<1>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_s16::<1>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_s16_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_s16::<2>(1i16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_s16::<2>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_s16::<2>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_s16_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_s16::<8>(1i16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_s16::<8>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_s16::<8>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrnh_n_s16_imm_4() -> Result<Verdict, String> {
    unsafe {
        let result = vqrshrnh_n_s16::<4>(1i16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqrshrnh_n_s16::<4>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrnh_n_s16::<4>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}
