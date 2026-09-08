use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabdlb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabdlb_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabdlt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabdlt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabdlt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabdlt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabdlt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabdlt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabdlt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabdlt_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabdlt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabdlt_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabdlt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabdlt_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlt_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlt_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svadalp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svadalp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svadalp_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svadalp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svadalp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svadalp_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svadalp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svadalp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svadalp_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svadalp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svadalp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svadalp_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadalp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadalp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadalp_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadalp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadalp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadalp_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadalp_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[8]).map_err(|e| format!("{e} | call: svadalp_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadalp_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadalp_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadalp_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadclb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svadclb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclb_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadclb_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svadclb_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclb_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadclb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svadclb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclb_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadclb_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svadclb_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclb_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadclt_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svadclt_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclt_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svadclt_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svadclt_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclt_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadclt_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svadclt_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclt_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svadclt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svadclt_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svadclt_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadclt_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svadclt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svadclt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaddhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svaddhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaddhnb_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svaddhnb_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svaddhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddhnb_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svaddhnb_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svaddhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddhnb_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svaddhnb_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaddhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svaddhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaddhnb_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svaddhnb_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svaddhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddhnb_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svaddhnb_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_n_u32_impl() }
}
