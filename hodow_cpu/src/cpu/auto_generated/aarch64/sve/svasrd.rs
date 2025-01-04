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
fn test_aarch64_sve_svasrd_n_s8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_m::<1>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_m_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_m::<2>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_m::<2>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_m::<2>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_m_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_m_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_m_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_m::<8>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_m::<8>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_m::<8>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_m_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_m_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_m_imm_4_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_m::<4>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_m::<4>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_m::<4>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_m_imm_4() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_m_imm_4_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_x::<1>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_x_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_x::<2>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_x::<2>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_x::<2>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_x_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_x_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_x_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_x::<8>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_x::<8>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_x::<8>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_x_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_x_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_x_imm_4_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_x::<4>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_x::<4>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_x::<4>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_x_imm_4() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_x_imm_4_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_z::<1>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_z_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_z::<2>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_z::<2>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_z::<2>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_z_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_z_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_z_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_z::<8>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_z::<8>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_z::<8>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_z_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_z_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_z_imm_4_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_z::<4>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s8_z::<4>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s8_z::<4>(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_z_imm_4() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_z_imm_4_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_m::<1>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_m_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_m::<2>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_m::<2>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_m::<2>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_m_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_m_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_m_imm_16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_m::<16>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_m::<16>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_m::<16>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_m_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_m_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_m_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_m::<8>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_m::<8>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_m::<8>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_m_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_m_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_x::<1>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_x_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_x::<2>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_x::<2>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_x::<2>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_x_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_x_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_x_imm_16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_x::<16>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_x::<16>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_x::<16>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_x_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_x_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_x_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_x::<8>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_x::<8>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_x::<8>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_x_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_x_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_z::<1>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_z_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_z::<2>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_z::<2>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_z::<2>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_z_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_z_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_z_imm_16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_z::<16>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_z::<16>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_z::<16>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_z_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_z_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_z_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_z::<8>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s16_z::<8>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s16_z::<8>(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_z_imm_8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_z_imm_8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_m::<1>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_m_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_m::<2>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_m::<2>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_m::<2>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_m_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_m_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_m_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_m::<32>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_m::<32>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_m::<32>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_m_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_m_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_m_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_m::<31>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_m::<31>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_m::<31>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_m_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_m_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_m_imm_16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_m::<16>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_m::<16>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_m::<16>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_m_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_m_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_x::<1>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_x_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_x::<2>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_x::<2>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_x::<2>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_x_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_x_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_x_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_x::<32>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_x::<32>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_x::<32>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_x_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_x_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_x_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_x::<31>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_x::<31>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_x::<31>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_x_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_x_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_x_imm_16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_x::<16>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_x::<16>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_x::<16>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_x_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_x_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_z::<1>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_z_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_z::<2>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_z::<2>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_z::<2>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_z_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_z_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_z_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_z::<32>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_z::<32>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_z::<32>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_z_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_z_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_z_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_z::<31>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_z::<31>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_z::<31>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_z_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_z_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_z_imm_16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_z::<16>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s32_z::<16>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s32_z::<16>(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_z_imm_16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_z_imm_16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_m::<1>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_m_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_m::<2>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_m::<2>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_m::<2>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_m_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_m_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_m_imm_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_m::<64>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_m::<64>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_m::<64>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_m_imm_64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_m_imm_64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_m_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_m::<31>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_m::<31>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_m::<31>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_m_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_m_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_m_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_m::<32>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_m::<32>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_m::<32>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_m_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_m_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_x::<1>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_x_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_x::<2>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_x::<2>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_x::<2>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_x_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_x_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_x_imm_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_x::<64>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_x::<64>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_x::<64>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_x_imm_64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_x_imm_64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_x_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_x::<31>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_x::<31>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_x::<31>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_x_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_x_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_x_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_x::<32>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_x::<32>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_x::<32>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_x_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_x_imm_32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_z::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_z::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_z::<1>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_z_imm_2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_z::<2>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_z::<2>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_z::<2>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_z_imm_2() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_z_imm_2_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_z_imm_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_z::<64>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_z::<64>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_z::<64>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_z_imm_64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_z_imm_64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_z_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_z::<31>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_z::<31>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_z::<31>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_z_imm_31() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_z_imm_31_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_z_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_z::<32>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svasrd_n_s64_z::<32>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svasrd_n_s64_z::<32>(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_z_imm_32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_z_imm_32_impl() }
}
