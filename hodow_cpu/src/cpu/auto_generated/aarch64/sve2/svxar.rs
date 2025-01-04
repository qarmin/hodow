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
fn test_aarch64_sve2_svxar_n_s8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svxar_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-127]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s8_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svxar_n_s8::<2>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-64]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s8::<2>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s8::<2>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s8_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s8_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svxar_n_s8::<8>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s8::<8>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s8::<8>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s8_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s8_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s8_imm_4_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svxar_n_s8::<4>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[48]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s8::<4>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s8::<4>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s8_imm_4() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s8_imm_4_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svxar_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-32767]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s16_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svxar_n_s16::<2>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-16384]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s16::<2>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s16::<2>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s16_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s16_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s16_imm_16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svxar_n_s16::<16>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s16::<16>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s16::<16>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s16_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s16_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s16_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svxar_n_s16::<8>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[768]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s16::<8>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s16::<8>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s16_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s16_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svxar_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-2147483647]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s32_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svxar_n_s32::<2>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1073741824]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s32::<2>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s32::<2>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s32_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s32_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s32_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svxar_n_s32::<32>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s32::<32>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s32::<32>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s32_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s32_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s32_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svxar_n_s32::<31>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[6]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s32::<31>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s32::<31>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s32_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s32_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s32_imm_16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svxar_n_s32::<16>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[196608]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s32::<16>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s32::<16>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s32_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s32_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svxar_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s64_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svxar_n_s64::<2>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-4611686018427387904]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s64::<2>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s64::<2>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s64_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s64_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s64_imm_64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svxar_n_s64::<64>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s64::<64>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s64::<64>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s64_imm_64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s64_imm_64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s64_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svxar_n_s64::<31>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[25769803776]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s64::<31>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s64::<31>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s64_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svxar_n_s64::<32>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[12884901888]).map_err(|e| crate::cpu::with_call(e, "svxar_n_s64::<32>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_s64::<32>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_s64_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svxar_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[129]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u8_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svxar_n_u8::<2>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[192]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u8::<2>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u8::<2>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u8_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u8_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svxar_n_u8::<8>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u8::<8>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u8::<8>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u8_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u8_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u8_imm_4_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svxar_n_u8::<4>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[48]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u8::<4>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u8::<4>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u8_imm_4() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u8_imm_4_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svxar_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[32769]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u16_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svxar_n_u16::<2>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[49152]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u16::<2>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u16::<2>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u16_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u16_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u16_imm_16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svxar_n_u16::<16>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u16::<16>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u16::<16>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u16_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u16_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u16_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svxar_n_u16::<8>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[768]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u16::<8>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u16::<8>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u16_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u16_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svxar_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2147483649]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u32_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svxar_n_u32::<2>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3221225472]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u32::<2>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u32::<2>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u32_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u32_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u32_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svxar_n_u32::<32>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u32::<32>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u32::<32>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u32_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u32_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u32_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svxar_n_u32::<31>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[6]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u32::<31>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u32::<31>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u32_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u32_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u32_imm_16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svxar_n_u32::<16>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[196608]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u32::<16>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u32::<16>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u32_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u32_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svxar_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[9223372036854775809]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u64_imm_2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svxar_n_u64::<2>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[13835058055282163712]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u64::<2>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u64::<2>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u64_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u64_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u64_imm_64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svxar_n_u64::<64>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u64::<64>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u64::<64>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u64_imm_64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u64_imm_64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u64_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svxar_n_u64::<31>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[25769803776]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u64::<31>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u64::<31>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u64_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svxar_n_u64::<32>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[12884901888]).map_err(|e| crate::cpu::with_call(e, "svxar_n_u64::<32>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svxar_n_u64::<32>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svxar_n_u64_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svxar_n_u64_imm_32_impl() }
}
