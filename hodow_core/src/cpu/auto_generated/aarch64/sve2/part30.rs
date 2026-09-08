use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsra_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsra_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsra_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsri_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsri_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsri_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsri_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsri_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsri_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsri_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsri_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsri_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsri_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsri_n_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsri_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsri_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsubhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svsubhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsubhnb_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svsubhnb_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svsubhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubhnb_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svsubhnb_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svsubhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubhnb_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svsubhnb_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsubhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svsubhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsubhnb_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svsubhnb_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svsubhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubhnb_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svsubhnb_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svsubhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubhnb_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svsubhnb_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnb_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsubhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_s16(create_random_svint8_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsubhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_n_s16(create_random_svint8_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_s32(create_random_svint16_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_n_s32(create_random_svint16_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_s64(create_random_svint32_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubhnt_n_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubhnt_n_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_n_s64(create_random_svint32_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsubhnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[255]).map_err(|e| format!("{e} | call: svsubhnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_u16(create_random_svuint8_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsubhnt_n_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[255]).map_err(|e| format!("{e} | call: svsubhnt_n_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_n_u16(create_random_svuint8_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubhnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsubhnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_u32(create_random_svuint16_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubhnt_n_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsubhnt_n_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_n_u32(create_random_svuint16_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubhnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsubhnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_u64(create_random_svuint32_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubhnt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubhnt_n_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsubhnt_n_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubhnt_n_u64(create_random_svuint32_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubhnt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubhnt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsublb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsublb_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublb_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsublb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsublb_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublb_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsublb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsublb_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublb_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsublb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsublb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsublb_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsublb_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsublb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsublb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsublb_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsublb_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsublb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsublb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsublb_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsublb_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublb_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublbt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsublbt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublbt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublbt_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublbt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublbt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublbt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsublbt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublbt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublbt_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublbt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublbt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublbt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsublbt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublbt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublbt_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublbt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublbt_s32_impl() }
}
