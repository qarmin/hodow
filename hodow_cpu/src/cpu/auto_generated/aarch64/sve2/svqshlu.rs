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
fn test_aarch64_sve2_svqshlu_n_s8_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_m::<0>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_m::<0>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_m::<0>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_m_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_m::<1>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_m_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_m_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_m_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_m::<7>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[255]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_m::<7>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_m::<7>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_m_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_m_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_m_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_m::<3>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[16]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_m::<3>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_m::<3>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_m_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_m_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_x::<0>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_x::<0>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_x::<0>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_x_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_x::<1>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_x_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_x_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_x_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_x::<7>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[255]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_x::<7>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_x::<7>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_x_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_x_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_x_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_x::<3>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[16]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_x::<3>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_x::<3>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_x_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_x_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_z::<0>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_z::<0>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_z::<0>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_z_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_z::<1>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_z_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_z_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_z_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_z::<7>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[255]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_z::<7>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_z::<7>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_z_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_z_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_z_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_z::<3>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[16]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s8_z::<3>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s8_z::<3>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_z_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_z_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_m::<0>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_m::<0>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_m::<0>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_m_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_m::<1>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_m_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_m_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_m_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_m::<15>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[65535]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_m::<15>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_m::<15>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_m_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_m_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_m_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_m::<7>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[256]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_m::<7>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_m::<7>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_m_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_m_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_x::<0>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_x::<0>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_x::<0>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_x_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_x::<1>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_x_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_x_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_x_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_x::<15>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[65535]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_x::<15>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_x::<15>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_x_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_x_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_x_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_x::<7>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[256]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_x::<7>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_x::<7>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_x_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_x_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_z::<0>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_z::<0>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_z::<0>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_z_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_z::<1>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_z_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_z_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_z_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_z::<15>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[65535]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_z::<15>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_z::<15>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_z_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_z_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_z_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_z::<7>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[256]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s16_z::<7>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s16_z::<7>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_z_imm_7() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_z_imm_7_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_m::<0>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_m::<0>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_m::<0>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_m_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_m::<1>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_m_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_m_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_m_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_m::<31>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4294967295]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_m::<31>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_m::<31>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_m_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_m_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_m_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_m::<15>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[65536]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_m::<15>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_m::<15>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_m_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_m_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_x::<0>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_x::<0>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_x::<0>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_x_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_x::<1>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_x_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_x_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_x_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_x::<31>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4294967295]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_x::<31>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_x::<31>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_x_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_x_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_x_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_x::<15>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[65536]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_x::<15>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_x::<15>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_x_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_x_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_z::<0>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_z::<0>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_z::<0>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_z_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_z::<1>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_z_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_z_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_z_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_z::<31>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4294967295]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_z::<31>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_z::<31>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_z_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_z_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_z_imm_15_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_z::<15>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[65536]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s32_z::<15>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s32_z::<15>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_z_imm_15() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_z_imm_15_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_m::<0>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_m::<0>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_m::<0>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_m_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_m::<1>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_m_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_m_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_m_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_m::<63>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_m::<63>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_m::<63>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_m_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_m_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_m_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_m::<31>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4294967296]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_m::<31>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_m::<31>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_m_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_m_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_m_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_m::<32>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_m::<32>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_m::<32>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_m_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_m_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_x::<0>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_x::<0>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_x::<0>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_x_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_x::<1>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_x_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_x_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_x_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_x::<63>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_x::<63>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_x::<63>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_x_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_x_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_x_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_x::<31>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4294967296]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_x::<31>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_x::<31>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_x_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_x_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_x_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_x::<32>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_x::<32>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_x::<32>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_x_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_x_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_z::<0>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_z::<0>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_z::<0>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_z_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_z::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_z::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_z::<1>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_z_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_z_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_z_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_z::<63>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_z::<63>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_z::<63>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_z_imm_63() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_z_imm_63_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_z_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_z::<31>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4294967296]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_z::<31>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_z::<31>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_z_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_z_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_z_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_z::<32>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| crate::cpu::with_call(e, "svqshlu_n_s64_z::<32>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqshlu_n_s64_z::<32>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_z_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_z_imm_32_impl() }
}
