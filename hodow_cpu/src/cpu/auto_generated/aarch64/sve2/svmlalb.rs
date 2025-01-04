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
fn test_aarch64_sve2_svmlalb_lane_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_lane_s32::<1>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_s32::<1>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_s32::<1>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s32_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_lane_s32::<7>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_s32::<7>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_s32::<7>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s32_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s32_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s32_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_lane_s32::<3>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_s32::<3>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_s32::<3>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s32_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s32_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_lane_s64::<1>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_s64::<1>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_s64::<1>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s64_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_lane_s64::<3>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_s64::<3>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_s64::<3>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s64_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s64_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_lane_u32::<1>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_u32::<1>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_u32::<1>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u32_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_lane_u32::<7>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_u32::<7>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_u32::<7>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u32_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u32_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u32_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_lane_u32::<3>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_u32::<3>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_u32::<3>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u32_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u32_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_lane_u64::<1>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_u64::<1>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_u64::<1>(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u64_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u64_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u64_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_lane_u64::<3>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_lane_u64::<3>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_lane_u64::<3>(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u64_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u64_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_n_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_n_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlalb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_u16(create_random_svuint16_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlalb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_n_u16(create_random_svuint16_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_n_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_u32(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_n_u32(create_random_svuint32_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_n_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_u64(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svmlalb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svmlalb_n_u64(create_random_svuint64_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svmlalb_n_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svmlalb_n_u64_impl() }
}
