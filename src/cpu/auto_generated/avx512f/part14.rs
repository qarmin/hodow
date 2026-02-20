use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

#[cfg(not(miri))]
pub(super) fn test_mm256_mask_rcp14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_rcp14_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.1999950408935547, 2.0, 0.1428546905517578, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_rcp14_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_maskz_rcp14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_rcp14_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 0.0, 0.3333320617675781, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_rcp14_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_rcp14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_rcp14_pd(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 0.5])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rcp14_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_mask_rcp14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_rcp14_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_array_equality(&result, &[0.3333320617675781, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_rcp14_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_maskz_rcp14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_rcp14_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_rcp14_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_rsqrt14_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1.0, 0.7070694, 0.5773392, 0.5, 0.44719696, 0.40823746, 0.3779564, 0.3535347, 0.33332443, 0.31621933, 0.30150223, 0.2886696, 0.27734375, 0.2672577, 0.25819778, 0.25])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_rsqrt14_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_mask_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_rsqrt14_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[0.2425251, 2.0, 0.22940636, 4.0, 0.21821022, 6.0, 0.20850945, 8.0, 0.19999504, 10.0, 0.19244766, 12.0, 0.18569374, 14.0, 0.17960167, 16.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_rsqrt14_ps(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_maskz_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_rsqrt14_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1.0, 0.0, 0.5773392, 0.0, 0.44719696, 0.0, 0.3779564, 0.0, 0.33332443, 0.0, 0.30150223, 0.0, 0.27734375, 0.0, 0.25819778, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_rsqrt14_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_rsqrt14_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 0.7070694, 0.5773392, 0.5, 0.44719696, 0.40823746, 0.3779564, 0.3535347])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_rsqrt14_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_mask_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_rsqrt14_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0.33332443, 2.0, 0.30150223, 4.0, 0.27734375, 6.0, 0.25819778, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_rsqrt14_ps(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_maskz_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_rsqrt14_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 0.0, 0.5773392, 0.0, 0.44719696, 0.0, 0.3779564, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_rsqrt14_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt14_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 0.7070694, 0.5773392, 0.5])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rsqrt14_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_mask_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_rsqrt14_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.44719696, 2.0, 0.3779564, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_rsqrt14_ps(create_random__m128(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_maskz_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_rsqrt14_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 0.0, 0.5773392, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_rsqrt14_ps(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_rsqrt14_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 0.7070693969726563, 0.5773391723632813, 0.5, 0.44719696044921875, 0.4082374572753906, 0.3779563903808594, 0.3535346984863281])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_rsqrt14_pd(create_random__m512d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_mask_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_rsqrt14_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0.3333244323730469, 2.0, 0.3015022277832031, 4.0, 0.27734375, 6.0, 0.2581977844238281, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_rsqrt14_pd(create_random__m512d(), create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_maskz_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_rsqrt14_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 0.0, 0.5773391723632813, 0.0, 0.44719696044921875, 0.0, 0.3779563903808594, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_rsqrt14_pd(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_rsqrt14_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 0.7070693969726563, 0.5773391723632813, 0.5])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_rsqrt14_pd(create_random__m256d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_mask_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_rsqrt14_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.44719696044921875, 2.0, 0.3779563903808594, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_rsqrt14_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_maskz_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_rsqrt14_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 0.0, 0.5773391723632813, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_rsqrt14_pd(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_rsqrt14_pd(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 0.7070693969726563])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rsqrt14_pd(create_random__m128d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_mask_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_rsqrt14_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0])));
        check_array_equality(&result, &[0.5773391723632813, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_rsqrt14_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_maskz_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_rsqrt14_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_rsqrt14_pd(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_getexp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_getexp_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0.0, 1.0, 1.0, 2.0, 2.0, 2.0, 2.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_getexp_ps(create_random__m512());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_mask_getexp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_getexp_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[4.0, 2.0, 4.0, 4.0, 4.0, 6.0, 4.0, 8.0, 4.0, 10.0, 4.0, 12.0, 4.0, 14.0, 4.0, 16.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_getexp_ps(create_random__m512(), create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm512_maskz_getexp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_getexp_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[0.0, 0.0, 1.0, 0.0, 2.0, 0.0, 2.0, 0.0, 3.0, 0.0, 3.0, 0.0, 3.0, 0.0, 3.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_getexp_ps(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_getexp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_getexp_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0, 1.0, 1.0, 2.0, 2.0, 2.0, 2.0, 3.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_getexp_ps(create_random__m256());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_mask_getexp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_getexp_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[3.0, 2.0, 3.0, 4.0, 3.0, 6.0, 3.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_getexp_ps(create_random__m256(), create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm256_maskz_getexp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_getexp_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0, 0.0, 1.0, 0.0, 2.0, 0.0, 2.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_getexp_ps(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

#[cfg(not(miri))]
pub(super) fn test_mm_getexp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_getexp_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0, 1.0, 1.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_getexp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}
