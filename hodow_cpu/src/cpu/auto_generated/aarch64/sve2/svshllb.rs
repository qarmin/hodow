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
fn test_aarch64_sve2_svshllb_n_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshllb_n_s16::<0>(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s16::<0>(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s16::<0>(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s16_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshllb_n_s16::<1>(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s16::<1>(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s16::<1>(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s16_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s16_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s16_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshllb_n_s16::<7>(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[128]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s16::<7>(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s16::<7>(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s16_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s16_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s16_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshllb_n_s16::<3>(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[8]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s16::<3>(create_svint8_t_from(1i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s16::<3>(create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s16_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s16_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshllb_n_s32::<0>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s32::<0>(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s32::<0>(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshllb_n_s32::<1>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s32::<1>(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s32::<1>(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s32_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshllb_n_s32::<15>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[32768]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s32::<15>(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s32::<15>(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s32_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s32_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s32_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshllb_n_s32::<7>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[128]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s32::<7>(create_svint16_t_from(1i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s32::<7>(create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s32_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s32_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svshllb_n_s64::<0>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s64::<0>(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s64::<0>(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svshllb_n_s64::<1>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s64::<1>(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s64::<1>(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s64_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svshllb_n_s64::<31>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[2147483648]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s64::<31>(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s64::<31>(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s64_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svshllb_n_s64::<15>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[32768]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_s64::<15>(create_svint32_t_from(1i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_s64::<15>(create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_s64_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_s64_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshllb_n_u16::<0>(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u16::<0>(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u16::<0>(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u16_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshllb_n_u16::<1>(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u16::<1>(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u16::<1>(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u16_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u16_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u16_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshllb_n_u16::<7>(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[128]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u16::<7>(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u16::<7>(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u16_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u16_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u16_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshllb_n_u16::<3>(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[8]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u16::<3>(create_svuint8_t_from(1u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u16::<3>(create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u16_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u16_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshllb_n_u32::<0>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u32::<0>(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u32::<0>(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshllb_n_u32::<1>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u32::<1>(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u32::<1>(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u32_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshllb_n_u32::<15>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[32768]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u32::<15>(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u32::<15>(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u32_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u32_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u32_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshllb_n_u32::<7>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[128]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u32::<7>(create_svuint16_t_from(1u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u32::<7>(create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u32_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u32_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svshllb_n_u64::<0>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u64::<0>(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u64::<0>(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svshllb_n_u64::<1>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u64::<1>(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u64::<1>(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u64_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svshllb_n_u64::<31>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[2147483648]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u64::<31>(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u64::<31>(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u64_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u64_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u64_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svshllb_n_u64::<15>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[32768]).map_err(|e| crate::cpu::with_call(e, "svshllb_n_u64::<15>(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svshllb_n_u64::<15>(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svshllb_n_u64_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svshllb_n_u64_imm_15_impl() }
}
