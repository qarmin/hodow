use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsra_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrsra_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svrsra_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsra_n_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsra_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsra_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsra_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrsra_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svrsra_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsra_n_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsra_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsra_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsra_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrsra_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svrsra_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsra_n_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsra_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsra_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsra_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsra_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svrsra_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsra_n_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsra_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsra_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsra_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrsra_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svrsra_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsra_n_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsra_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsra_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrsubhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svrsubhnb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrsubhnb_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svrsubhnb_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrsubhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svrsubhnb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrsubhnb_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svrsubhnb_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrsubhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svrsubhnb_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrsubhnb_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svrsubhnb_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrsubhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svrsubhnb_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrsubhnb_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svrsubhnb_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrsubhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svrsubhnb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrsubhnb_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svrsubhnb_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsubhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svrsubhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsubhnb_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svrsubhnb_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnb_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrsubhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svrsubhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_s16(create_random_svint8_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrsubhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svrsubhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_n_s16(create_random_svint8_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrsubhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svrsubhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_s32(create_random_svint16_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrsubhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svrsubhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_n_s32(create_random_svint16_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrsubhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svrsubhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_s64(create_random_svint32_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrsubhnt_n_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svrsubhnt_n_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_n_s64(create_random_svint32_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrsubhnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svrsubhnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_u16(create_random_svuint8_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrsubhnt_n_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svrsubhnt_n_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_n_u16(create_random_svuint8_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrsubhnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svrsubhnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_u32(create_random_svuint16_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrsubhnt_n_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svrsubhnt_n_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_n_u32(create_random_svuint16_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsubhnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svrsubhnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_u64(create_random_svuint32_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrsubhnt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrsubhnt_n_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svrsubhnt_n_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsubhnt_n_u64(create_random_svuint32_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svrsubhnt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svrsubhnt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsbclb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svsbclb_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclb_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsbclb_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svsbclb_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclb_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsbclb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svsbclb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclb_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsbclb_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svsbclb_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclb_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsbclt_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svsbclt_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclt_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsbclt_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svsbclt_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclt_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsbclt_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svsbclt_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclt_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsbclt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsbclt_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svsbclt_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsbclt_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsbclt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsbclt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshllb_n_s16::<1>(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllb_n_s16::<1>(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllb_n_s16::<1>(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshllb_n_s32::<1>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllb_n_s32::<1>(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllb_n_s32::<1>(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svshllb_n_s64::<1>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllb_n_s64::<1>(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllb_n_s64::<1>(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshllb_n_u16::<1>(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllb_n_u16::<1>(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllb_n_u16::<1>(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshllb_n_u32::<1>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllb_n_u32::<1>(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllb_n_u32::<1>(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svshllb_n_u64::<1>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllb_n_u64::<1>(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllb_n_u64::<1>(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshllt_n_s16::<1>(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllt_n_s16::<1>(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllt_n_s16::<1>(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshllt_n_s32::<1>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllt_n_s32::<1>(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllt_n_s32::<1>(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svshllt_n_s64::<1>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllt_n_s64::<1>(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllt_n_s64::<1>(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshllt_n_u16::<1>(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllt_n_u16::<1>(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllt_n_u16::<1>(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshllt_n_u32::<1>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllt_n_u32::<1>(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllt_n_u32::<1>(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshllt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svshllt_n_u64::<1>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svshllt_n_u64::<1>(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshllt_n_u64::<1>(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshllt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshllt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svshrnb_n_s16::<1>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svshrnb_n_s16::<1>(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnb_n_s16::<1>(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnb_n_s16_impl() }
}
