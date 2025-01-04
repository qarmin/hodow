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
fn test_aarch64_sve2_svqrdmlsh_lane_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s16_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_lane_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s16::<1>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s16_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s16_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_lane_s16::<7>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s16::<7>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s16::<7>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s16_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s16_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s16_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_lane_s16::<3>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s16::<3>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s16::<3>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s16_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_lane_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s32::<1>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s32_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_lane_s32::<3>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s32::<3>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s32::<3>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s32_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s32_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlsh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_lane_s64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlsh_lane_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_lane_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_lane_s64::<1>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_lane_s64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_lane_s64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmlsh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrdmlsh_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrdmlsh_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrdmlsh_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlsh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrdmlsh_n_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqrdmlsh_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svqrdmlsh_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqrdmlsh_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqrdmlsh_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqrdmlsh_n_s64_impl() }
}
