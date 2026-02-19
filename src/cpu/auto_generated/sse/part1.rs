use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_add_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_add_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_add_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_add_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_add_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_add_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sub_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sub_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sub_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sub_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sub_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sub_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mul_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mul_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mul_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mul_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mul_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mul_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_div_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_div_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_div_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_div_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_div_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_div_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sqrt_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sqrt_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rcp_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rcp_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rsqrt_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rsqrt_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_min_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_min_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_max_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_max_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_and_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_and_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_and_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_andnot_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_andnot_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_andnot_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_or_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_or_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_or_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_xor_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_xor_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_xor_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpeq_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmplt_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmple_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpge_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpneq_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpnlt_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpnle_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}
