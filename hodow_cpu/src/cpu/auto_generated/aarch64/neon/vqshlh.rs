use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqshlh_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_s16::<0>(1i16);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_s16::<0>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_s16::<0>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_n_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_s16::<1>(1i16);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_s16::<1>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_s16::<1>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_n_s16_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_s16::<15>(1i16);
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_s16::<15>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_s16::<15>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_n_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_s16::<7>(1i16);
        check_int_equality(result, 128).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_s16::<7>(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_s16::<7>(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_u16::<0>(1u16);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_u16::<0>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_u16::<0>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_n_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_u16::<1>(1u16);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_u16::<1>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_u16::<1>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_n_u16_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_u16::<15>(1u16);
        check_int_equality(result, 32768).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_u16::<15>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_u16::<15>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_n_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_n_u16::<7>(1u16);
        check_int_equality(result, 128).map_err(|e| crate::cpu::with_call(e, "vqshlh_n_u16::<7>(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_n_u16::<7>(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_s16(1i16, 2i16);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vqshlh_s16(1i16, 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_s16(rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlh_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlh_u16(1u16, 2i16);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vqshlh_u16(1u16, 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlh_u16(rand::random::<u16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}
