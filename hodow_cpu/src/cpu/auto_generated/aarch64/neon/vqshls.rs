use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqshls_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_s32::<0>(1i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqshls_n_s32::<0>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_s32::<0>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_n_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_s32::<1>(1i32);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vqshls_n_s32::<1>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_s32::<1>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_n_s32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_s32::<31>(1i32);
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vqshls_n_s32::<31>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_s32::<31>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_n_s32_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_s32::<15>(1i32);
        check_int_equality(result, 32768).map_err(|e| crate::cpu::with_call(e, "vqshls_n_s32::<15>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_s32::<15>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_u32::<0>(1u32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqshls_n_u32::<0>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_u32::<0>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_n_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_u32::<1>(1u32);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vqshls_n_u32::<1>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_u32::<1>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_n_u32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_u32::<31>(1u32);
        check_int_equality(result, 2147483648).map_err(|e| crate::cpu::with_call(e, "vqshls_n_u32::<31>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_u32::<31>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_n_u32_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_n_u32::<15>(1u32);
        check_int_equality(result, 32768).map_err(|e| crate::cpu::with_call(e, "vqshls_n_u32::<15>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_n_u32::<15>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_s32(1i32, 2i32);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vqshls_s32(1i32, 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_s32(rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshls_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshls_u32(1u32, 2i32);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vqshls_u32(1u32, 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshls_u32(rand::random::<u32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
