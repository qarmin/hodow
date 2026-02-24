#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm256_aesenc_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1115454548, 1601664833, 1266383704, -873270698, 2070637438, 2003791733, -1832532677, -1775226667])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_aesenclast_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1667457909, 1667457917, 1667457904, 1667458046, 1667457894, 1667457889, 1667457994, 1667457824])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_aesdec_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1368450932, -1051610861, -1800699598, -912388812, -206554351, -1448256351, -1846131385, 1460639283])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_aesdeclast_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1381126656, 1381126752, 1381126878, 1381126716, 1381126715, 1381126827, 1381126711, 1381126831])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_aesenc_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1115454540, 1601664857, 1266383680, -873270706, 2070637414, 2003791725, -1832532701, -1775226659, -989789762, 1869047665, -1154798616, -536936866, -1529358579, 548121590, 1551267414, -2083862006])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_aesenclast_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1667457901, 1667457893, 1667457896, 1667458022, 1667457918, 1667457913, 1667458002, 1667457832, 1667457816, 1667457917, 1667457840, 1667458018, 1667457994, 1667457973, 1667457897, 1667458026])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_aesdec_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1368450924, -1051610869, -1800699606, -912388820, -206554359, -1448256327, -1846131361, 1460639291, -191311689, -1820104047, 666477805, -31308976, -717320997, -2102291653, -1923693399, 1269766141])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_aesdeclast_epi128() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1381126680, 1381126776, 1381126854, 1381126692, 1381126691, 1381126835, 1381126703, 1381126823, 1381126745, 1381126841, 1381126789, 1381126813, 1381126894, 1381126857, 1381126884, 1381126748])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}
