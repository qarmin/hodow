use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublbt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsublbt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublbt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublbt_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublbt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublbt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublbt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsublbt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublbt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublbt_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublbt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublbt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublbt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsublbt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublbt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublbt_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublbt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublbt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsublt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublt_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsublt_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublt_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsublt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublt_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsublt_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublt_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsublt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublt_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsublt_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsublt_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsublt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsublt_u16(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_u16(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsublt_n_u16(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsublt_n_u16(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_n_u16(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsublt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsublt_u32(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_u32(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsublt_n_u32(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsublt_n_u32(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_n_u32(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsublt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsublt_u64(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_u64(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsublt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsublt_n_u64(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsublt_n_u64(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsublt_n_u64(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsublt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsublt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubltb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubltb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubltb_s16(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubltb_s16(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubltb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubltb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubltb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubltb_n_s16(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubltb_n_s16(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubltb_n_s16(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubltb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubltb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubltb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubltb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubltb_s32(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubltb_s32(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubltb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubltb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubltb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubltb_n_s32(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubltb_n_s32(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubltb_n_s32(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubltb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubltb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubltb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsubltb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubltb_s64(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubltb_s64(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubltb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubltb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubltb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsubltb_n_s64(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubltb_n_s64(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubltb_n_s64(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubltb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubltb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubwb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_s16(create_random_svint16_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubwb_n_s16(create_svint16_t_from(1i16), 2i8));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwb_n_s16(create_svint16_t_from(1i16), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_n_s16(create_random_svint16_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubwb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_s32(create_random_svint32_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubwb_n_s32(create_svint32_t_from(1i32), 2i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwb_n_s32(create_svint32_t_from(1i32), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_n_s32(create_random_svint32_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsubwb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_s64(create_random_svint64_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsubwb_n_s64(create_svint64_t_from(1i64), 2i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwb_n_s64(create_svint64_t_from(1i64), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_n_s64(create_random_svint64_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubwb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsubwb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_u16(create_random_svuint16_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubwb_n_u16(create_svuint16_t_from(1u16), 2u8));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsubwb_n_u16(create_svuint16_t_from(1u16), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_n_u16(create_random_svuint16_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubwb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsubwb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_u32(create_random_svuint32_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubwb_n_u32(create_svuint32_t_from(1u32), 2u16));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsubwb_n_u32(create_svuint32_t_from(1u32), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_n_u32(create_random_svuint32_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsubwb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsubwb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_u64(create_random_svuint64_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsubwb_n_u64(create_svuint64_t_from(1u64), 2u32));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsubwb_n_u64(create_svuint64_t_from(1u64), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwb_n_u64(create_random_svuint64_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubwt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_s16(create_random_svint16_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsubwt_n_s16(create_svint16_t_from(1i16), 2i8));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwt_n_s16(create_svint16_t_from(1i16), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_n_s16(create_random_svint16_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubwt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_s32(create_random_svint32_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsubwt_n_s32(create_svint32_t_from(1i32), 2i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwt_n_s32(create_svint32_t_from(1i32), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_n_s32(create_random_svint32_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsubwt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_s64(create_random_svint64_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsubwt_n_s64(create_svint64_t_from(1i64), 2i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svsubwt_n_s64(create_svint64_t_from(1i64), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_n_s64(create_random_svint64_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubwt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsubwt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_u16(create_random_svuint16_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsubwt_n_u16(create_svuint16_t_from(1u16), 2u8));
        check_array_equality(&result, &[65535]).map_err(|e| format!("{e} | call: svsubwt_n_u16(create_svuint16_t_from(1u16), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_n_u16(create_random_svuint16_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubwt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsubwt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_u32(create_random_svuint32_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsubwt_n_u32(create_svuint32_t_from(1u32), 2u16));
        check_array_equality(&result, &[4294967295]).map_err(|e| format!("{e} | call: svsubwt_n_u32(create_svuint32_t_from(1u32), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_n_u32(create_random_svuint32_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsubwt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsubwt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_u64(create_random_svuint64_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsubwt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsubwt_n_u64(create_svuint64_t_from(1u64), 2u32));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| format!("{e} | call: svsubwt_n_u64(create_svuint64_t_from(1u64), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsubwt_n_u64(create_random_svuint64_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsubwt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsubwt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtbx_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svuint32_t_from(3u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svtbx_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_f32(create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtbx_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svuint64_t_from(3u64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svtbx_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_f64(create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svtbx_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svtbx_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svtbx_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svtbx_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtbx_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtbx_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svtbx_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svtbx_s32_impl() }
}
