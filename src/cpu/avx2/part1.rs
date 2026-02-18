use std::arch::x86_64::{
    _mm256_abs_epi32, _mm256_add_epi32, _mm256_and_si256, _mm256_hadd_epi32, _mm256_max_epi32, _mm256_min_epi32, _mm256_mullo_epi32, _mm256_or_si256,
    _mm256_shuffle_epi8, _mm256_slli_epi32, _mm256_srli_epi32, _mm256_sub_epi32, _mm256_xor_si256,
};

use log::info;

use crate::cpu::common::check_array_equality;
use crate::cpu::common::values::{
    create__m256i_from_i32_array, create__m256i_from_i8_array, create__m256i_from_u32_array, create_random__m256i, unpack__m256i_to_i32_array,
    unpack__m256i_to_i8_array, unpack__m256i_to_u32_array,
};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm256_add_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_add_epi32(
            create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[9, 9, 9, 9, 9, 9, 9, 9])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_add_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_sub_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_sub_epi32(
            create__m256i_from_i32_array([80, 70, 60, 50, 40, 30, 20, 10]),
            create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
        ));
        check_array_equality(&result, &[72, 63, 54, 45, 36, 27, 18, 9])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_sub_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_mullo_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mullo_epi32(
            create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
            create__m256i_from_i32_array([2, 2, 2, 2, 2, 2, 2, 2]),
        ));
        check_array_equality(&result, &[16, 14, 12, 10, 8, 6, 4, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_mullo_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_and_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_and_si256(
            create__m256i_from_u32_array([4275360; 8]),
            create__m256i_from_u32_array([494901760; 8]),
        ));
        check_array_equality(&result, &[4265984; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_and_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_or_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_or_si256(
            create__m256i_from_u32_array([4275360; 8]),
            create__m256i_from_u32_array([16711935; 8]),
        ));
        check_array_equality(&result, &[16727295; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_or_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_xor_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_xor_si256(
            create__m256i_from_u32_array([4275360; 8]),
            create__m256i_from_u32_array([494901760; 8]),
        ));
        check_array_equality(&result, &[490645152; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_xor_si256(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_slli_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_slli_epi32::<2>(create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1])));
        check_array_equality(&result, &[32, 28, 24, 20, 16, 12, 8, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_slli_epi32::<2>(create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_srli_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_srli_epi32::<2>(create__m256i_from_i32_array([64, 56, 48, 40, 32, 24, 16, 8])));
        check_array_equality(&result, &[16, 14, 12, 10, 8, 6, 4, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_srli_epi32::<2>(create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_abs_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_abs_epi32(create__m256i_from_i32_array([-8, 7, -6, 5, -4, 3, -2, -1])));
        check_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_abs_epi32(create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_max_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_max_epi32(
            create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[8, 7, 6, 5, 5, 6, 7, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_max_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_min_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_min_epi32(
            create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
            create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[1, 2, 3, 4, 4, 3, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_min_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_shuffle_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_shuffle_epi8(
            create__m256i_from_i8_array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]),
            create__m256i_from_i8_array([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]),
        ));
        check_array_equality(
            &result,
            &[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16],
        )?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_shuffle_epi8(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_hadd_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hadd_epi32(
            create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
            create__m256i_from_i32_array([16, 15, 14, 13, 12, 11, 10, 9]),
        ));
        check_array_equality(&result, &[15, 11, 31, 27, 7, 3, 23, 19])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm256_hadd_epi32(create_random__m256i(), create_random__m256i());
            }
        }
    }

    Ok(())
}
