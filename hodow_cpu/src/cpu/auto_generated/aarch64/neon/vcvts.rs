use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcvts_f32_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_f32_s32(1i32);
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vcvts_f32_s32(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_f32_s32(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_f32_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_f32_u32(1u32);
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vcvts_f32_u32(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_f32_u32(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_s32::<1>(1i32);
        check_float_equality(result, 0.5).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_s32::<1>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_s32::<1>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_s32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_s32::<2>(1i32);
        check_float_equality(result, 0.25).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_s32::<2>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_s32::<2>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_s32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_s32::<32>(1i32);
        check_float_equality(result, 2.3283064e-10).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_s32::<32>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_s32::<32>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_s32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_s32::<31>(1i32);
        check_float_equality(result, 4.656613e-10).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_s32::<31>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_s32::<31>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_s32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_s32::<16>(1i32);
        check_float_equality(result, 1.5258789e-5).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_s32::<16>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_s32::<16>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_u32::<1>(1u32);
        check_float_equality(result, 0.5).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_u32::<1>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_u32::<1>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_u32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_u32::<2>(1u32);
        check_float_equality(result, 0.25).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_u32::<2>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_u32::<2>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_u32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_u32::<32>(1u32);
        check_float_equality(result, 2.3283064e-10).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_u32::<32>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_u32::<32>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_u32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_u32::<31>(1u32);
        check_float_equality(result, 4.656613e-10).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_u32::<31>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_u32::<31>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_f32_u32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_f32_u32::<16>(1u32);
        check_float_equality(result, 1.5258789e-5).map_err(|e| crate::cpu::with_call(e, "vcvts_n_f32_u32::<16>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_f32_u32::<16>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_s32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_s32_f32::<1>(1.0f32);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vcvts_n_s32_f32::<1>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_s32_f32::<1>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_s32_f32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_s32_f32::<2>(1.0f32);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vcvts_n_s32_f32::<2>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_s32_f32::<2>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_s32_f32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_s32_f32::<32>(1.0f32);
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vcvts_n_s32_f32::<32>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_s32_f32::<32>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_s32_f32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_s32_f32::<31>(1.0f32);
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vcvts_n_s32_f32::<31>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_s32_f32::<31>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_s32_f32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_s32_f32::<16>(1.0f32);
        check_int_equality(result, 65536).map_err(|e| crate::cpu::with_call(e, "vcvts_n_s32_f32::<16>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_s32_f32::<16>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_u32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_u32_f32::<1>(1.0f32);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vcvts_n_u32_f32::<1>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_u32_f32::<1>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_u32_f32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_u32_f32::<2>(1.0f32);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vcvts_n_u32_f32::<2>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_u32_f32::<2>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_u32_f32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_u32_f32::<32>(1.0f32);
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vcvts_n_u32_f32::<32>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_u32_f32::<32>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_u32_f32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_u32_f32::<31>(1.0f32);
        check_int_equality(result, 2147483648).map_err(|e| crate::cpu::with_call(e, "vcvts_n_u32_f32::<31>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_u32_f32::<31>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_n_u32_f32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_n_u32_f32::<16>(1.0f32);
        check_int_equality(result, 65536).map_err(|e| crate::cpu::with_call(e, "vcvts_n_u32_f32::<16>(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_n_u32_f32::<16>(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_s32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_s32_f32(1.0f32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vcvts_s32_f32(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_s32_f32(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvts_u32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvts_u32_f32(1.0f32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vcvts_u32_f32(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvts_u32_f32(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}
