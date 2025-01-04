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
fn test_aarch64_sve_svext_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svext_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svext_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f32::<0>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svext_f32::<1>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svext_f32::<1>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f32::<1>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f32_imm_63_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svext_f32::<63>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svext_f32::<63>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f32::<63>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f32_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f32_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f32_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svext_f32::<31>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svext_f32::<31>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f32::<31>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f32_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f32_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f32_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svext_f32::<32>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svext_f32::<32>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f32::<32>(create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f32_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f32_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svext_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svext_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f64::<0>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svext_f64::<1>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svext_f64::<1>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f64::<1>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f64_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svext_f64::<31>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svext_f64::<31>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f64::<31>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_f64_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svext_f64::<15>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svext_f64::<15>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_f64::<15>(create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_f64_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_f64_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svext_s8::<0>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s8::<0>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s8::<0>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s8_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svext_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s8_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s8_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s8_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svext_s8::<255>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s8::<255>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s8::<255>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s8_imm_255() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s8_imm_255_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s8_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svext_s8::<31>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_s8::<31>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s8::<31>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s8_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s8_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s8_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svext_s8::<32>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_s8::<32>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s8::<32>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s8_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s8_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svext_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s16::<0>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s16_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svext_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s16_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s16_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s16_imm_127_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svext_s16::<127>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s16::<127>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s16::<127>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s16_imm_127() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s16_imm_127_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s16_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svext_s16::<31>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_s16::<31>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s16::<31>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s16_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s16_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s16_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svext_s16::<32>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s16::<32>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s16::<32>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s16_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s16_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svext_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s32::<0>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svext_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s32_imm_63_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svext_s32::<63>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s32::<63>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s32::<63>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s32_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s32_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s32_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svext_s32::<31>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s32::<31>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s32::<31>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s32_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s32_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s32_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svext_s32::<32>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s32::<32>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s32::<32>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s32_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s32_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svext_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s64::<0>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svext_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s64_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svext_s64::<31>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s64::<31>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s64::<31>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_s64_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svext_s64::<15>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_s64::<15>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_s64::<15>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_s64_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_s64_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svext_u8::<0>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u8::<0>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u8::<0>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u8_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svext_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u8_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u8_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u8_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svext_u8::<255>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u8::<255>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u8::<255>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u8_imm_255() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u8_imm_255_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u8_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svext_u8::<31>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_u8::<31>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u8::<31>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u8_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u8_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u8_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svext_u8::<32>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_u8::<32>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u8::<32>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u8_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u8_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svext_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u16::<0>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u16_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svext_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u16_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u16_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u16_imm_127_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svext_u16::<127>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u16::<127>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u16::<127>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u16_imm_127() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u16_imm_127_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u16_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svext_u16::<31>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_u16::<31>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u16::<31>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u16_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u16_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u16_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svext_u16::<32>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u16::<32>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u16::<32>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u16_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u16_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svext_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u32::<0>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svext_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u32_imm_63_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svext_u32::<63>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u32::<63>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u32::<63>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u32_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u32_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u32_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svext_u32::<31>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u32::<31>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u32::<31>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u32_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u32_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u32_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svext_u32::<32>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u32::<32>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u32::<32>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u32_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u32_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svext_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u64::<0>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svext_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svext_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u64_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svext_u64::<31>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u64::<31>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u64::<31>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svext_u64_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svext_u64::<15>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svext_u64::<15>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svext_u64::<15>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svext_u64_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svext_u64_imm_15_impl() }
}
