#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_xor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_xor_ps(
            create__mmask8_from(0b01010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
            create__m128_from([5.0, 6.0, 7.0, 8.0]),
        ));
        check_float_array_equality(&result, &[2.1267648e38, 0.0, 1.469368e-38, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_xor_ps(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_xor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_xor_ps(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__mmask8_from(0b01010101),
            create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]),
        ));
        check_float_array_equality(&result, &[1.3958995e-38, 2.0, 1.5428363e-38, 4.0, 2.2775203e-38, 6.0, 1.8367099e-38, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_xor_ps(create_random__m256(), create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_xor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_xor_ps(
            create__mmask8_from(0b01010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_float_array_equality(&result, &[9.570442e37, 0.0, 4.4081038e-38, 0.0, 8.8162076e-38, 0.0, 5.2897246e-38, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_xor_ps(create_random__mmask8(), create_random__m256(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_xor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_xor_ps(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        ));
        check_float_array_equality(
            &result,
            &[
                4.519375e37,
                5.2897246e-38,
                7.934587e-38,
                2.938736e-38,
                2.4979255e-38,
                4.4081038e-38,
                3.9672934e-38,
                1.7632415e-38,
                1.9836467e-38,
                2.2040519e-38,
                2.1305835e-38,
                1.469368e-38,
                1.6897731e-38,
                1.3224311e-38,
                1.2489627e-38,
                7.523164e-37,
            ],
        )?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_xor_ps(create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_xor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_xor_ps(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__mmask16_from(0b0101010101010101),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
            create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]),
        ));
        check_float_array_equality(
            &result,
            &[
                8.2284605e-37,
                2.0,
                8.698658e-37,
                4.0,
                1.1049647e-36,
                6.0,
                9.639054e-37,
                8.0,
                1.3870833e-36,
                10.0,
                1.4341031e-36,
                12.0,
                1.2930438e-36,
                14.0,
                1.1519845e-36,
                16.0,
            ],
        )?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_xor_ps(create_random__m512(), create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_xor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_xor_ps(
            create__mmask16_from(0b0101010101010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]),
        ));
        check_float_array_equality(
            &result,
            &[
                4.519375e37,
                0.0,
                7.934587e-38,
                0.0,
                2.4979255e-38,
                0.0,
                3.9672934e-38,
                0.0,
                1.9836467e-38,
                0.0,
                2.1305835e-38,
                0.0,
                1.6897731e-38,
                0.0,
                1.2489627e-38,
                0.0,
            ],
        )?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_xor_ps(create_random__mmask16(), create_random__m512(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_f32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_broadcast_f32x2(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_broadcast_f32x2(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_broadcast_f32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_broadcast_f32x2(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__mmask8_from(0b01010101),
            create__m128_from([9.0, 10.0, 11.0, 12.0]),
        ));
        check_float_array_equality(&result, &[9.0, 2.0, 9.0, 4.0, 9.0, 6.0, 9.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_broadcast_f32x2(create_random__m256(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_broadcast_f32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_broadcast_f32x2(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_broadcast_f32x2(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_broadcast_f32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_broadcast_f32x2(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_broadcast_f32x2(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_broadcast_f32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_broadcast_f32x2(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__mmask16_from(0b0101010101010101),
            create__m128_from([17.0, 18.0, 19.0, 20.0]),
        ));
        check_float_array_equality(&result, &[17.0, 2.0, 17.0, 4.0, 17.0, 6.0, 17.0, 8.0, 17.0, 10.0, 17.0, 12.0, 17.0, 14.0, 17.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_broadcast_f32x2(create_random__m512(), create_random__mmask16(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_broadcast_f32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_broadcast_f32x2(
            create__mmask16_from(0b0101010101010101),
            create__m128_from([1.0, 2.0, 3.0, 4.0]),
        ));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_broadcast_f32x2(create_random__mmask16(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_broadcast_f32x8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_broadcast_f32x8(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_broadcast_f32x8(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_broadcast_f32x8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_broadcast_f32x8(
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
            create__mmask16_from(0b0101010101010101),
            create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]),
        ));
        check_float_array_equality(&result, &[17.0, 2.0, 19.0, 4.0, 21.0, 6.0, 23.0, 8.0, 17.0, 10.0, 19.0, 12.0, 21.0, 14.0, 23.0, 16.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_broadcast_f32x8(create_random__m512(), create_random__mmask16(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_broadcast_f32x8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_broadcast_f32x8(
            create__mmask16_from(0b0101010101010101),
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_broadcast_f32x8(create_random__mmask16(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_f64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_broadcast_f64x2(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_broadcast_f64x2(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_broadcast_f64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_broadcast_f64x2(
            create__m256d_from([1.0, 2.0, 3.0, 4.0]),
            create__mmask8_from(0b01010101),
            create__m128d_from([5.0, 6.0]),
        ));
        check_float_array_equality(&result, &[5.0, 2.0, 5.0, 4.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_broadcast_f64x2(create_random__m256d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_broadcast_f64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_broadcast_f64x2(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_broadcast_f64x2(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_broadcast_f64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_broadcast_f64x2(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_broadcast_f64x2(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_broadcast_f64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_broadcast_f64x2(
            create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__mmask8_from(0b01010101),
            create__m128d_from([9.0, 10.0]),
        ));
        check_float_array_equality(&result, &[9.0, 2.0, 9.0, 4.0, 9.0, 6.0, 9.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_broadcast_f64x2(create_random__m512d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_broadcast_f64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_broadcast_f64x2(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_broadcast_f64x2(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_broadcast_i32x2(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 1, 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_broadcast_i32x2(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_broadcast_i32x2(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[5, 2, 5, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_broadcast_i32x2(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_broadcast_i32x2(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_broadcast_i32x2(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_broadcast_i32x2(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 1, 2, 1, 2, 1, 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_broadcast_i32x2(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_broadcast_i32x2(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[9, 2, 9, 4, 9, 6, 9, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_broadcast_i32x2(create_random__m256i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_broadcast_i32x2(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_broadcast_i32x2(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_broadcast_i32x2(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_broadcast_i32x2(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_broadcast_i32x2(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([17, 18, 19, 20]),
        ));
        check_array_equality(&result, &[17, 2, 17, 4, 17, 6, 17, 8, 17, 10, 17, 12, 17, 14, 17, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_broadcast_i32x2(create_random__m512i(), create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_broadcast_i32x2(
            create__mmask16_from(0b0101010101010101),
            create__m128i_from_i32_array([1, 2, 3, 4]),
        ));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_broadcast_i32x2(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_broadcast_i32x8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_broadcast_i32x8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_broadcast_i32x8(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_broadcast_i32x8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_broadcast_i32x8(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[17, 2, 19, 4, 21, 6, 23, 8, 17, 10, 19, 12, 21, 14, 23, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_broadcast_i32x8(create_random__m512i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_broadcast_i32x8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_broadcast_i32x8(
            create__mmask16_from(0b0101010101010101),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 1, 0, 3, 0, 5, 0, 7, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_broadcast_i32x8(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_broadcast_i64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_broadcast_i64x2(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_broadcast_i64x2(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_broadcast_i64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_broadcast_i64x2(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([9, 10, 11, 12]),
        ));
        check_array_equality(&result, &[9, 10, 3, 4, 9, 10, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_broadcast_i64x2(create_random__m256i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_broadcast_i64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_broadcast_i64x2(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 0, 0, 1, 2, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_broadcast_i64x2(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_broadcast_i64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_broadcast_i64x2(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_broadcast_i64x2(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_broadcast_i64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_broadcast_i64x2(
            create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
            create__mmask8_from(0b01010101),
            create__m128i_from_i32_array([17, 18, 19, 20]),
        ));
        check_array_equality(&result, &[17, 18, 3, 4, 17, 18, 7, 8, 17, 18, 11, 12, 17, 18, 15, 16])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_broadcast_i64x2(create_random__m512i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_broadcast_i64x2() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_broadcast_i64x2(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 0, 0, 1, 2, 0, 0, 1, 2, 0, 0, 1, 2, 0, 0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_broadcast_i64x2(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_extractf32x8_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_extractf32x8_ps::<0>(create__m512_from([
            1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
        ])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_extractf32x8_ps::<0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_extractf32x8_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_mask_extractf32x8_ps::<0>(
            create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
            create__mmask8_from(0b01010101),
            create__m512_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]),
        ));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_extractf32x8_ps::<0>(create_random__m256(), create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_extractf32x8_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_maskz_extractf32x8_ps::<0>(
            create__mmask8_from(0b01010101),
            create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]),
        ));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_extractf32x8_ps::<0>(create_random__mmask8(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_extractf64x2_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_extractf64x2_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(
            create__m128d_from([1.0, 2.0]),
            create__mmask8_from(0b01010101),
            create__m256d_from([3.0, 4.0, 5.0, 6.0]),
        ));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_extractf64x2_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_extractf64x2_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_extractf64x2_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(
            create__m128d_from([1.0, 2.0]),
            create__mmask8_from(0b01010101),
            create__m512d_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]),
        ));
        check_float_array_equality(&result, &[3.0, 2.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_extractf64x2_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(
            create__mmask8_from(0b01010101),
            create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]),
        ));
        check_float_array_equality(&result, &[1.0, 0.0])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_extracti32x8_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_extracti32x8_epi32::<0>(create__m512i_from_i32_array([
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
        ])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_extracti32x8_epi32::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_extracti32x8_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_mask_extracti32x8_epi32::<0>(
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
            create__mmask8_from(0b01010101),
            create__m512i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]),
        ));
        check_array_equality(&result, &[9, 2, 11, 4, 13, 6, 15, 8])?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_extracti32x8_epi32::<0>(create_random__m256i(), create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}
