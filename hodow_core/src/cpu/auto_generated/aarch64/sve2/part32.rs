use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svtbx_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svtbx_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_u8(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svtbx_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_u16(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svtbx_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svtbx_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpkhi_b_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svunpkhi_b(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpkhi_b(create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpkhi_b(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpkhi_b() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpkhi_b_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpkhi_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svunpkhi_s16(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpkhi_s16(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpkhi_s16(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpkhi_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpkhi_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpkhi_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svunpkhi_s32(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpkhi_s32(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpkhi_s32(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpkhi_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpkhi_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpkhi_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svunpkhi_s64(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpkhi_s64(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpkhi_s64(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpkhi_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpkhi_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpkhi_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svunpkhi_u16(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpkhi_u16(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpkhi_u16(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpkhi_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpkhi_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpkhi_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svunpkhi_u32(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpkhi_u32(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpkhi_u32(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpkhi_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpkhi_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpkhi_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svunpkhi_u64(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpkhi_u64(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpkhi_u64(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpkhi_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpkhi_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpklo_b_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svunpklo_b(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpklo_b(create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpklo_b(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpklo_b() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpklo_b_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpklo_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svunpklo_s16(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpklo_s16(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpklo_s16(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpklo_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpklo_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpklo_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svunpklo_s32(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpklo_s32(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpklo_s32(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpklo_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpklo_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpklo_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svunpklo_s64(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpklo_s64(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpklo_s64(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpklo_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpklo_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpklo_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svunpklo_u16(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpklo_u16(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpklo_u16(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpklo_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpklo_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpklo_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svunpklo_u32(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpklo_u32(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpklo_u32(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpklo_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpklo_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svunpklo_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svunpklo_u64(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svunpklo_u64(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svunpklo_u64(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svunpklo_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svunpklo_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svuqadd_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svuqadd_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u8));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svuqadd_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svuqadd_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u8));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svuqadd_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svuqadd_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u8));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svuqadd_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svuqadd_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u16));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svuqadd_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svuqadd_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u16));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svuqadd_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svuqadd_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u16));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svuqadd_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svuqadd_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u32));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svuqadd_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svuqadd_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u32));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svuqadd_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svuqadd_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u32));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svuqadd_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svuqadd_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3u64));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s64_m(create_svbool_t(), create_random_svint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svuqadd_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svuqadd_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3u64));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svuqadd_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svuqadd_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svuqadd_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3u64));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svuqadd_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuqadd_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svuqadd_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svuqadd_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b8_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b8_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b8_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b8_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b8_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b8_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b16_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b16_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b16_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b16_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b16_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b16_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b32_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b32_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b32_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b32_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b32_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b64_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b64_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b64_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b64_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b64_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b8_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b8_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b8_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b8_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b8_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b16_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b16_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b16_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b16_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b16_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b32_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b32_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b32_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b32_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b32_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b32_s64_impl() }
}
