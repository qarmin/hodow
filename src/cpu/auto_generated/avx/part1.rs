use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cmp_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_pd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmp_pd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmp_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cmp_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmp_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmp_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmp_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutevar_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permutevar_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_permutevar_ps(create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permute_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_permute_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_permute_ps::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutevar_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permutevar_pd(create__m128d_from([1.0, 2.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_permutevar_pd(create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permute_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_permute_pd::<0>(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_permute_pd::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcast_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_broadcast_ss(0 /* &f32 */));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_broadcast_ss(0 /* &f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskload_pd() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f64; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128d_to_f64_array(_mm_maskload_pd(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskstore_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f64; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m128d_from([1.0, 2.0]);
        _mm_maskstore_pd(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_maskload_ps() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1.0f32; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128_to_f32_array(_mm_maskload_ps(ptr_mem_addr.as_ptr(), mask));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskstore_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f32; 1];
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_maskstore_ps(ptr_mem_addr.as_mut_ptr(), mask, a);
    }
    Ok(())
}

pub(super) fn test_mm_testz_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_testc_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_testc_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_testc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_testnzc_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_testnzc_pd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_testz_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_testc_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_testc_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_testc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_testnzc_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_testnzc_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_testnzc_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}
