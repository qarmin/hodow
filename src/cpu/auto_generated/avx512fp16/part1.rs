use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_set_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_set_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_set_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_set_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_set_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_set_sh(0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set_sh(0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set1_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_set1_ph(0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set1_ph(0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_set1_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_set1_ph(0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_set1_ph(0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_set1_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_set1_ph(0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set1_ph(0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_setr_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_setr_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_setr_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_setr_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_setr_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_setr_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setr_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_setr_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setr_ph(0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */, 0 /* f16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_setzero_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_setzero_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_setzero_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_setzero_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_setzero_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_setzero_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setzero_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_setzero_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setzero_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_undefined_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_undefined_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_undefined_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_undefined_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_undefined_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_undefined_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_undefined_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_undefined_ph();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_undefined_ph();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_castpd_ph(create__m128d_from([1.0, 2.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castpd_ph(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_castpd_ph(create__m256d_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castpd_ph(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_castpd_ph(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd_ph(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castph_pd(0 /* __m128h */));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castph_pd(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castph_pd(0 /* __m256h */));
        check_array_equality(&result, &[0.0f64; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castph_pd(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castph_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castph_pd(0 /* __m512h */));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castph_pd(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_castps_ph(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castps_ph(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_castps_ph(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castps_ph(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_castps_ph(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps_ph(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castph_ps(0 /* __m128h */));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castph_ps(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castph_ps(0 /* __m256h */));
        check_array_equality(&result, &[0.0f32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castph_ps(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castph_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castph_ps(0 /* __m512h */));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castph_ps(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_castsi128_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_castsi128_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_castsi128_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_castsi256_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_castsi256_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_castsi256_ph(create_random__m256i());
            }
        }
    }
    Ok(())
}
