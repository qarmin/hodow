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
fn test_aarch64_sve_svlsr_u8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_n_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_wide_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsr_wide_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_wide_n_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsr_wide_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svlsr_wide_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svlsr_wide_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svlsr_wide_n_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svlsr_wide_n_u32_z_impl() }
}
