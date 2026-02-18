use std::arch::x86_64::{
    __m256i, _mm256_abs_epi32, _mm256_add_epi32, _mm256_and_si256, _mm256_hadd_epi32, _mm256_max_epi32, _mm256_min_epi32, _mm256_mullo_epi32, _mm256_or_si256, _mm256_set_epi32,
    _mm256_set_epi8, _mm256_shuffle_epi8, _mm256_slli_epi32, _mm256_srli_epi32, _mm256_sub_epi32, _mm256_xor_si256,
};

use log::info;

use crate::cpu::common::{check_array_equality, create_random__m256i};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm256_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_add_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi32(10, 20, 30, 40, 50, 60, 70, 80);
        let b = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let result = _mm256_sub_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(2, 2, 2, 2, 2, 2, 2, 2);
        let result = _mm256_mullo_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi32(4275360, 4275360, 4275360, 4275360, 4275360, 4275360, 4275360, 4275360);
        let b = _mm256_set_epi32(494901760, 494901760, 494901760, 494901760, 494901760, 494901760, 494901760, 494901760);
        let result = _mm256_and_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        check_array_equality(&result, &[4265984, 4265984, 4265984, 4265984, 4265984, 4265984, 4265984, 4265984])?;
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
        let a = _mm256_set_epi32(4275360, 4275360, 4275360, 4275360, 4275360, 4275360, 4275360, 4275360);
        let b = _mm256_set_epi32(16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935, 16711935);
        let result = _mm256_or_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        check_array_equality(&result, &[16727295, 16727295, 16727295, 16727295, 16727295, 16727295, 16727295, 16727295])?;
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
        let a = _mm256_set_epi32(4275360, 4275360, 4275360, 4275360, 4275360, 4275360, 4275360, 4275360);
        let b = _mm256_set_epi32(494901760, 494901760, 494901760, 494901760, 494901760, 494901760, 494901760, 494901760);
        let result = _mm256_xor_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        check_array_equality(&result, &[490645152, 490645152, 490645152, 490645152, 490645152, 490645152, 490645152, 490645152])?;
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
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let result = _mm256_slli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi32(8, 16, 24, 32, 40, 48, 56, 64);
        let result = _mm256_srli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi32(-1, -2, 3, -4, 5, -6, 7, -8);
        let result = _mm256_abs_epi32(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_max_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_min_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
        let a = _mm256_set_epi8(
            31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
        );
        let b = _mm256_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = _mm256_shuffle_epi8(a, b);
        let result = std::mem::transmute::<__m256i, [i8; 32]>(result);
        check_array_equality(
            &result,
            &[
                15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16,
            ],
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
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm256_hadd_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
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
