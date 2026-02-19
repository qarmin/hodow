use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_sd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_sd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_ss_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ss_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}
