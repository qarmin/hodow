use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svaddhnb_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddhnb_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svaddhnb_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnb_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaddhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svaddhnt_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_s16(create_random_svint8_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaddhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svaddhnt_n_s16(create_svint8_t_from(1i8), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_n_s16(create_random_svint8_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svaddhnt_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_s32(create_random_svint16_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svaddhnt_n_s32(create_svint16_t_from(1i16), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_n_s32(create_random_svint16_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svaddhnt_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_s64(create_random_svint32_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddhnt_n_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svaddhnt_n_s64(create_svint32_t_from(1i32), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_n_s64(create_random_svint32_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaddhnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svaddhnt_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_u16(create_random_svuint8_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaddhnt_n_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svaddhnt_n_u16(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_n_u16(create_random_svuint8_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddhnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svaddhnt_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_u32(create_random_svuint16_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddhnt_n_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svaddhnt_n_u32(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_n_u32(create_random_svuint16_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddhnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svaddhnt_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_u64(create_random_svuint32_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddhnt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddhnt_n_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svaddhnt_n_u64(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddhnt_n_u64(create_random_svuint32_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddhnt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddhnt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlb_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlb_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlb_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddlb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddlb_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddlb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddlb_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddlb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddlb_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlb_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlb_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlbt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlbt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlbt_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlbt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlbt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlbt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlbt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlbt_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlbt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlbt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlbt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlbt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlbt_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlbt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlbt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlbt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlbt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlbt_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlbt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlbt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlbt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlbt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlbt_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlbt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlbt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlbt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlbt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlbt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlbt_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlbt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlbt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddlt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddlt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddlt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddlt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddlt_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddlt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddlt_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddlt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddlt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddlt_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddlt_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddlt_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddlt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddlt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svaddp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[6.0]).map_err(|e| format!("{e} | call: svaddp_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svaddp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[6.0]).map_err(|e| format!("{e} | call: svaddp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svaddp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[6.0]).map_err(|e| format!("{e} | call: svaddp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svaddp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[6.0]).map_err(|e| format!("{e} | call: svaddp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaddp_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaddp_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s8_x_impl() }
}
