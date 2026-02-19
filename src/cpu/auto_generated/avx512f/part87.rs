use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvtt_roundsd_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsd_i32::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsd_i32::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsd_u32::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsd_u32::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_i32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsd_i32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_u32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsd_u32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu32_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1u32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtu32_ss(create_random__m128(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu32_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu32_sd(create__m128d_from([1.0, 2.0]), 1u32));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtu32_sd(create_random__m128d(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comi_round_ss() -> Result<(), String> {
    unsafe {
        let result = _mm_comi_round_ss::<0, 0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comi_round_ss::<0, 0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comi_round_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_comi_round_sd::<0, 0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_comi_round_sd::<0, 0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_i64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_u64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvti64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1i64));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvti64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvti64_sd(create__m128d_from([1.0, 2.0]), 1i64));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvti64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtu64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1u64));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtu64_ss(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtu64_sd(create__m128d_from([1.0, 2.0]), 1u64));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtu64_sd(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_i64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsd_i64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_u64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsd_u64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_i64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttss_i64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_u64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttss_u64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundi64_sd::<0>(create__m128d_from([1.0, 2.0]), 1i64));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundi64_sd::<0>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundsi64_sd::<0>(create__m128d_from([1.0, 2.0]), 1i64));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsi64_sd::<0>(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundi64_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1i64));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundi64_ss::<0>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundu64_sd::<0>(create__m128d_from([1.0, 2.0]), 1u64));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundu64_sd::<0>(create_random__m128d(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsi64_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1i64));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsi64_ss::<0>(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundu64_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), 1u64));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundu64_ss::<0>(create_random__m128(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsd_si64::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_si64::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsd_i64::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_i64::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsd_u64::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_u64::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_si64::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_si64::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}
