use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshrnb_n_s32::<1>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svshrnb_n_s32::<1>(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnb_n_s32::<1>(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshrnb_n_s64::<1>(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svshrnb_n_s64::<1>(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnb_n_s64::<1>(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svshrnb_n_u16::<1>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svshrnb_n_u16::<1>(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnb_n_u16::<1>(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshrnb_n_u32::<1>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svshrnb_n_u32::<1>(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnb_n_u32::<1>(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshrnb_n_u64::<1>(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svshrnb_n_u64::<1>(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnb_n_u64::<1>(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svshrnt_n_s16::<1>(create_svint8_t_from(1i8), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svshrnt_n_s16::<1>(create_svint8_t_from(1i8), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnt_n_s16::<1>(create_random_svint8_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svshrnt_n_s32::<1>(create_svint16_t_from(1i16), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svshrnt_n_s32::<1>(create_svint16_t_from(1i16), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnt_n_s32::<1>(create_random_svint16_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svshrnt_n_s64::<1>(create_svint32_t_from(1i32), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svshrnt_n_s64::<1>(create_svint32_t_from(1i32), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnt_n_s64::<1>(create_random_svint32_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svshrnt_n_u16::<1>(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svshrnt_n_u16::<1>(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnt_n_u16::<1>(create_random_svuint8_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svshrnt_n_u32::<1>(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svshrnt_n_u32::<1>(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnt_n_u32::<1>(create_random_svuint16_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svshrnt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svshrnt_n_u64::<1>(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svshrnt_n_u64::<1>(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svshrnt_n_u64::<1>(create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svshrnt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svshrnt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsli_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsli_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsli_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsli_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsli_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsli_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsli_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsli_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsli_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsli_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsli_n_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsli_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsli_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsm4e_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsm4e_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[576807844]).map_err(|e| format!("{e} | call: svsm4e_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsm4e_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsm4e_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsm4e_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsm4ekey_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsm4ekey_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1492370698]).map_err(|e| format!("{e} | call: svsm4ekey_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsm4ekey_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsm4ekey_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsm4ekey_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsqadd_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsqadd_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsqadd_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsqadd_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsqadd_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsqadd_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsqadd_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsqadd_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsqadd_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsqadd_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsqadd_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsqadd_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsqadd_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsqadd_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsqadd_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsqadd_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsqadd_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsqadd_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsqadd_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsqadd_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsqadd_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsqadd_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsqadd_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsqadd_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsqadd_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svsqadd_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqadd_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsqadd_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsqadd_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsra_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsra_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsra_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsra_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svsra_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsra_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsra_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsra_n_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svsra_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svsra_n_u8_impl() }
}
