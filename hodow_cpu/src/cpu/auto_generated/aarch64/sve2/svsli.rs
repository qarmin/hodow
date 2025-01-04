use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsli_n_s8::<0>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s8::<0>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s8::<0>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsli_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s8_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s8_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsli_n_s8::<7>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s8::<7>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s8::<7>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s8_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s8_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s8_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsli_n_s8::<3>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[17]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s8::<3>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s8::<3>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s8_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s8_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsli_n_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s16::<0>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s16_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsli_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s16_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s16_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s16_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsli_n_s16::<15>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s16::<15>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s16::<15>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s16_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s16_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s16_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsli_n_s16::<7>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[257]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s16::<7>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s16::<7>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s16_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s16_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsli_n_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s32::<0>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsli_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s32_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsli_n_s32::<31>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s32::<31>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s32::<31>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s32_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s32_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s32_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsli_n_s32::<15>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[65537]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s32::<15>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s32::<15>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s32_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s32_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsli_n_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s64::<0>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsli_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s64_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsli_n_s64::<63>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s64::<63>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s64::<63>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s64_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s64_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s64_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsli_n_s64::<31>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4294967297]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s64::<31>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s64::<31>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s64_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsli_n_s64::<32>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934593]).map_err(|e| crate::cpu::with_call(e, "svsli_n_s64::<32>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_s64::<32>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_s64_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsli_n_u8::<0>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u8::<0>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u8::<0>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsli_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u8_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u8_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsli_n_u8::<7>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u8::<7>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u8::<7>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u8_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u8_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u8_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsli_n_u8::<3>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[17]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u8::<3>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u8::<3>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u8_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u8_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsli_n_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u16::<0>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u16_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsli_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u16_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u16_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u16_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsli_n_u16::<15>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u16::<15>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u16::<15>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u16_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u16_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u16_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsli_n_u16::<7>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[257]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u16::<7>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u16::<7>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u16_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u16_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsli_n_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u32::<0>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsli_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u32_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsli_n_u32::<31>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u32::<31>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u32::<31>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u32_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u32_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u32_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsli_n_u32::<15>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[65537]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u32::<15>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u32::<15>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u32_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u32_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsli_n_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u64::<0>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsli_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u64_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsli_n_u64::<63>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u64::<63>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u64::<63>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u64_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u64_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u64_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsli_n_u64::<31>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[4294967297]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u64::<31>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u64::<31>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u64_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsli_n_u64::<32>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[8589934593]).map_err(|e| crate::cpu::with_call(e, "svsli_n_u64::<32>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsli_n_u64::<32>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsli_n_u64_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsli_n_u64_imm_32_impl() }
}
