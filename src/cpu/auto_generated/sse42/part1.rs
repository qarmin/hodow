use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cmpistrm() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpistrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpistrm::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpistri() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpistri::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpistrz() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpistrz::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpistrc() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpistrc::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpistrs() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpistrs::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpistro() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpistro::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpistra() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpistra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpistra::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpestrm() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpestrm::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpestrm::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpestri() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestri::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpestri::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpestrz() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrz::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpestrz::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpestrc() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpestrs() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestrs::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpestrs::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpestro() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestro::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpestro::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpestra() -> Result<(), String> {
    unsafe {
        let result = _mm_cmpestra::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpestra::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_crc32_u8() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u8(1u32, 2u8);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_crc32_u8(rand::random::<u32>(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_crc32_u16() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u16(1u32, 2u16);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_crc32_u16(rand::random::<u32>(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_crc32_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u32(1u32, 2u32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_crc32_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cmpgt_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_crc32_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_crc32_u64(1u64, 2u64);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_crc32_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}
