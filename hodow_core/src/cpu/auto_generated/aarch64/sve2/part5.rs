use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbcax_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_u8(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbcax_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_u8(create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbcax_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_u16(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbcax_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_u16(create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbcax_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbcax_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbcax_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbcax_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbdep_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbdep_n_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_n_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_n_u8(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbdep_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbdep_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbdep_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbdep_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbdep_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbdep_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbdep_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbdep_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbdep_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbdep_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbdep_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbext_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svbext_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbext_n_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svbext_n_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_n_u8(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbext_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svbext_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbext_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svbext_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbext_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svbext_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbext_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svbext_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbext_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svbext_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbext_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbext_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svbext_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbext_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbext_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbext_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbgrp_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbgrp_n_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_n_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_n_u8(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbgrp_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbgrp_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbgrp_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbgrp_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbgrp_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbgrp_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbgrp_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbgrp_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbgrp_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbgrp_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbgrp_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbsl1n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbsl1n_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbsl1n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbsl1n_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbsl1n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbsl1n_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svbsl1n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svbsl1n_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbsl1n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_u8(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svbsl1n_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_u8(create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbsl1n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_u16(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svbsl1n_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_u16(create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbsl1n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svbsl1n_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbsl1n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl1n_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svbsl1n_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svbsl1n_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl1n_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl1n_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl1n_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl2n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbsl2n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svbsl2n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl2n_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl2n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl2n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbsl2n_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbsl2n_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svbsl2n_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbsl2n_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbsl2n_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbsl2n_n_s8_impl() }
}
