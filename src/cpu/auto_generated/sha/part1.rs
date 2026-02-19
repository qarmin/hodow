use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_sha1msg1_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sha1msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha1msg2_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha1nexte_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1nexte_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sha1nexte_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha1rnds4_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha256msg1_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha256msg1_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sha256msg1_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha256msg2_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha256msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sha256rnds2_epu32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sha256rnds2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_sha512msg1_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sha512msg1_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_sha512msg1_epi64(create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_sha512msg2_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sha512msg2_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_sha512msg2_epi64(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_sha512rnds2_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sha512rnds2_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_sha512rnds2_epi64(create_random__m256i(), create_random__m256i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sm3msg1_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sm3msg1_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sm3msg1_epi32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sm3msg2_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sm3msg2_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sm3msg2_epi32(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sm3rnds2_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sm3rnds2_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sm3rnds2_epi32::<0>(create_random__m128i(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sm4key4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sm4key4_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sm4key4_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_sm4key4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sm4key4_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_sm4key4_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sm4rnds4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_sm4rnds4_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sm4rnds4_epi32(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_sm4rnds4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sm4rnds4_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_sm4rnds4_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}
