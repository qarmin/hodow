use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaba_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svaba_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaba_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaba_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaba_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaba_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaba_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaba_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaba_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_u8(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaba_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_u8(create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaba_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_u16(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaba_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_u16(create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaba_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaba_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaba_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaba_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaba_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svaba_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaba_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaba_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaba_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabalb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_u16(create_random_svuint16_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabalb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_n_u16(create_random_svuint16_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabalb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_u32(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabalb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_n_u32(create_random_svuint32_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabalb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_u64(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabalb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalb_n_u64(create_random_svuint64_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabalt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabalt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabalt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabalt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabalt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabalt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabalt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_u16(create_random_svuint16_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabalt_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_n_u16(create_random_svuint16_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabalt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_u32(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabalt_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_n_u32(create_random_svuint32_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabalt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_u64(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabalt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabalt_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabalt_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabalt_n_u64(create_random_svuint64_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabalt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabalt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabdlb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabdlb_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabdlb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabdlb_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabdlb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabdlb_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabdlb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svabdlb_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabdlb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svabdlb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabdlb_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabdlb_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabdlb_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svabdlb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svabdlb_n_u32_impl() }
}
