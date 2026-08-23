use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_wasm32_simd128_v128_load() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([0 /* v128 */; 64]);
        let _result = v128_load(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i16x8_load_extend_i8x8() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = i16x8_load_extend_i8x8(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i16x8_load_extend_u8x8() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = i16x8_load_extend_u8x8(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i32x4_load_extend_i16x4() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1i16; 32]);
        let _result = i32x4_load_extend_i16x4(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i32x4_load_extend_u16x4() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        let _result = i32x4_load_extend_u16x4(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_load_extend_i32x2() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = i64x2_load_extend_i32x2(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_load_extend_u32x2() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = i64x2_load_extend_u32x2(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load8_splat() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = v128_load8_splat(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load16_splat() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        let _result = v128_load16_splat(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load32_splat() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = v128_load32_splat(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load64_splat() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        let _result = v128_load64_splat(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load32_zero() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = v128_load32_zero(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load64_zero() -> Result<(), String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        let _result = v128_load64_zero(ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_store() -> Result<(), String> {
    unsafe {
        let mut ptr_m = crate::cpu::common::Aligned64([0 /* v128 */; 64]);
        let a = 0 /* v128 */;
        v128_store(ptr_m.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load8_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = v128_load8_lane::<0>(v, ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load16_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        let _result = v128_load16_lane::<0>(v, ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load32_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = v128_load32_lane::<0>(v, ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_load64_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        let _result = v128_load64_lane::<0>(v, ptr_m.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_store8_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        v128_store8_lane::<0>(v, ptr_m.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_store16_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        v128_store16_lane::<0>(v, ptr_m.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_store32_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        v128_store32_lane::<0>(v, ptr_m.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_v128_store64_lane() -> Result<(), String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        v128_store64_lane::<0>(v, ptr_m.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i8x16_shuffle() -> Result<(), String> {
    unsafe {
        let _result = i8x16_shuffle::<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_shuffle::<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i16x8_shuffle() -> Result<(), String> {
    unsafe {
        let _result = i16x8_shuffle::<0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_shuffle::<0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i32x4_shuffle() -> Result<(), String> {
    unsafe {
        let _result = i32x4_shuffle::<0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_shuffle::<0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_shuffle() -> Result<(), String> {
    unsafe {
        let _result = i64x2_shuffle::<0, 0>(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_shuffle::<0, 0>(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i8x16_extract_lane() -> Result<(), String> {
    unsafe {
        let result = i8x16_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u8x16_extract_lane() -> Result<(), String> {
    unsafe {
        let result = u8x16_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i8x16_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = i8x16_replace_lane::<0>(0 /* v128 */, 1i8);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_replace_lane::<0>(0 /* v128 */, rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u8x16_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = u8x16_replace_lane::<0>(0 /* v128 */, 1u8);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_replace_lane::<0>(0 /* v128 */, rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i16x8_extract_lane() -> Result<(), String> {
    unsafe {
        let result = i16x8_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u16x8_extract_lane() -> Result<(), String> {
    unsafe {
        let result = u16x8_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i16x8_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = i16x8_replace_lane::<0>(0 /* v128 */, 1i16);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_replace_lane::<0>(0 /* v128 */, rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u16x8_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = u16x8_replace_lane::<0>(0 /* v128 */, 1u16);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_replace_lane::<0>(0 /* v128 */, rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i32x4_extract_lane() -> Result<(), String> {
    unsafe {
        let result = i32x4_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u32x4_extract_lane() -> Result<(), String> {
    unsafe {
        let result = u32x4_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i32x4_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = i32x4_replace_lane::<0>(0 /* v128 */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_replace_lane::<0>(0 /* v128 */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u32x4_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = u32x4_replace_lane::<0>(0 /* v128 */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_replace_lane::<0>(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_extract_lane() -> Result<(), String> {
    unsafe {
        let result = i64x2_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u64x2_extract_lane() -> Result<(), String> {
    unsafe {
        let result = u64x2_extract_lane::<0>(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u64x2_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = i64x2_replace_lane::<0>(0 /* v128 */, 1i64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_replace_lane::<0>(0 /* v128 */, rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u64x2_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = u64x2_replace_lane::<0>(0 /* v128 */, 1u64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u64x2_replace_lane::<0>(0 /* v128 */, rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_extract_lane() -> Result<(), String> {
    unsafe {
        let _result = f32x4_extract_lane::<0>(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = f32x4_replace_lane::<0>(0 /* v128 */, 1.0f32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_replace_lane::<0>(0 /* v128 */, rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_extract_lane() -> Result<(), String> {
    unsafe {
        let _result = f64x2_extract_lane::<0>(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_extract_lane::<0>(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_replace_lane() -> Result<(), String> {
    unsafe {
        let _result = f64x2_replace_lane::<0>(0 /* v128 */, 1.0f64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_replace_lane::<0>(0 /* v128 */, rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i8x16_swizzle() -> Result<(), String> {
    unsafe {
        let _result = i8x16_swizzle(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_swizzle(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i8x16_splat() -> Result<(), String> {
    unsafe {
        let _result = i8x16_splat(1i8);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_splat(rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u8x16_splat() -> Result<(), String> {
    unsafe {
        let _result = u8x16_splat(1u8);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_splat(rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i16x8_splat() -> Result<(), String> {
    unsafe {
        let _result = i16x8_splat(1i16);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_splat(rand::random::<i16>());
            }
        }
    }
    Ok(())
}
