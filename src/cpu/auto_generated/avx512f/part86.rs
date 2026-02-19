use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_cvtss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtss_sd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtss_sd(create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtsd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtsd_ss(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtsd_ss(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtsd_ss(create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundss_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_sd::<0>(create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvt_roundss_sd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvt_roundss_sd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvt_roundss_sd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvt_roundss_sd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsd_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_ss::<0>(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvt_roundsd_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvt_roundsd_ss::<0>(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvt_roundsd_ss::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvt_roundsd_ss::<0>(create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_si32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_si32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_i32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_i32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_u32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_u32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_i32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_u32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_u32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsd_si32::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_si32::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsd_i32::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_i32::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsd_u32::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_u32::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsd_i32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_u32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsd_u32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi32_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1i32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundi32_ss::<0>(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi32_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1i32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsi32_ss::<0>(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu32_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1u32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundu32_ss::<0>(create_random__m128(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti32_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1i32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvti32_ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti32_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti32_sd(create__m128d_from([1.0, 2.0]), 1i32));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvti32_sd(create_random__m128d(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundss_si32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundss_si32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundss_i32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundss_i32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundss_u32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundss_u32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_i32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttss_i32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_u32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttss_u32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsd_si32::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsd_si32::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}
