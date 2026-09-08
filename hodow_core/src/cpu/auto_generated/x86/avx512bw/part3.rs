#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[16, 0, 0, 0, 51, 0, 0, 0, 14, 0, 0, 0, 53, 0, 0, 0, 16, 0, 0, 0, 59, 0, 0, 0, 14, 0, 0, 0, 61, 0, 0, 0, 16, 0, 0, 0, 67, 0, 0, 0, 14, 0, 0, 0, 69, 0, 0, 0, 16, 0, 0, 0, 75, 0, 0, 0, 14, 0, 0, 0, 77, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_u8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_u8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138, 238, 82, 182, 26, 126, 226, 70, 170, 14, 114, 214, 58, 158, 2, 102, 202, 46, 146, 246, 90, 190, 34, 134, 234, 78, 178, 22, 122, 222, 66, 166, 10]), create__m512i_from_u8_array([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0, 100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20])));
        check_array_equality(&result, &[40, 0, 44, 144, 0, 2, 188, 32, 88, 0, 76, 176, 68, 1, 220, 64, 40, 0, 108, 208, 132, 1, 252, 96, 88, 0, 140, 240, 68, 1, 28, 128, 40, 0, 172, 16, 0, 2, 60, 160, 44, 1, 204, 48, 68, 1, 92, 192, 20, 1, 236, 80, 156, 1, 124, 224, 88, 0, 12, 112, 0, 2, 156, 0]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138, 238, 82, 182, 26, 126, 226, 70, 170, 14, 114, 214, 58, 158, 2, 102, 202, 46, 146, 246, 90, 190, 34, 134, 234, 78, 178, 22, 122, 222, 66, 166, 10]), create__m512i_from_u8_array([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0, 100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 64]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 64]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[251, 3, 0, 0, 251, 3, 0, 0, 251, 3, 0, 0, 251, 3, 0, 0, 247, 3, 0, 0, 247, 3, 0, 0, 247, 3, 0, 0, 247, 3, 0, 0, 243, 3, 0, 0, 243, 3, 0, 0, 243, 3, 0, 0, 243, 3, 0, 0, 239, 3, 0, 0, 239, 3, 0, 0, 239, 3, 0, 0, 239, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 255, 255, 1, 0, 255, 255, 1, 0, 255, 255, 1, 0, 255, 255, 5, 0, 255, 255, 5, 0, 255, 255, 5, 0, 255, 255, 5, 0, 255, 255, 9, 0, 255, 255, 9, 0, 255, 255, 9, 0, 255, 255, 9, 0, 255, 255, 13, 0, 255, 255, 13, 0, 255, 255, 13, 0, 255, 255, 13, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[16, 0, 0, 0, 51, 0, 0, 0, 14, 0, 0, 0, 53, 0, 0, 0, 16, 0, 0, 0, 59, 0, 0, 0, 14, 0, 0, 0, 61, 0, 0, 0, 16, 0, 0, 0, 67, 0, 0, 0, 14, 0, 0, 0, 69, 0, 0, 0, 16, 0, 0, 0, 75, 0, 0, 0, 14, 0, 0, 0, 77, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<0>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_mask_dbsad_epu8::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[17, 0, 0, 0, 51, 0, 0, 0, 14, 0, 0, 0, 53, 0, 0, 0, 17, 0, 0, 0, 59, 0, 0, 0, 14, 0, 0, 0, 61, 0, 0, 0, 17, 0, 0, 0, 67, 0, 0, 0, 14, 0, 0, 0, 69, 0, 0, 0, 17, 0, 0, 0, 75, 0, 0, 0, 14, 0, 0, 0, 77, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_mask_dbsad_epu8::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_mask_dbsad_epu8::<1>(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[16, 0, 0, 0, 19, 0, 0, 0, 14, 0, 0, 0, 21, 0, 0, 0, 16, 0, 0, 0, 27, 0, 0, 0, 14, 0, 0, 0, 29, 0, 0, 0, 16, 0, 0, 0, 35, 0, 0, 0, 14, 0, 0, 0, 37, 0, 0, 0, 16, 0, 0, 0, 43, 0, 0, 0, 14, 0, 0, 0, 45, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m512i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m512i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0]), create__m512i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138, 238, 82, 182, 26, 126, 226, 70, 170, 14, 114, 214, 58, 158, 2, 102, 202, 46, 146, 246, 90, 190, 34, 134, 234, 78, 178, 22, 122, 222, 66, 166, 10])));
        check_array_equality(&result, &[40, 0, 0, 0, 0, 2, 0, 0, 88, 0, 0, 0, 68, 1, 0, 0, 40, 0, 0, 0, 32, 1, 0, 0, 88, 0, 0, 0, 68, 1, 0, 0, 40, 0, 0, 0, 0, 2, 0, 0, 44, 1, 0, 0, 0, 2, 0, 0, 40, 0, 0, 0, 32, 1, 0, 0, 44, 1, 0, 0, 68, 1, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148, 248, 92, 192, 36, 136, 236, 80, 180, 24, 124, 224, 68, 168, 12, 112, 212, 56, 156, 0]), create__m512i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138, 238, 82, 182, 26, 126, 226, 70, 170, 14, 114, 214, 58, 158, 2, 102, 202, 46, 146, 246, 90, 190, 34, 134, 234, 78, 178, 22, 122, 222, 66, 166, 10]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 64]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0; 64]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 64]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0; 64]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0; 64]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m512i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[16, 0, 0, 0, 19, 0, 0, 0, 14, 0, 0, 0, 21, 0, 0, 0, 16, 0, 0, 0, 27, 0, 0, 0, 14, 0, 0, 0, 29, 0, 0, 0, 16, 0, 0, 0, 35, 0, 0, 0, 14, 0, 0, 0, 37, 0, 0, 0, 16, 0, 0, 0, 43, 0, 0, 0, 14, 0, 0, 0, 45, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<0>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_maskz_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m512i_to_u8_array(_mm512_maskz_dbsad_epu8::<1>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 0, 0, 0, 19, 0, 0, 0, 14, 0, 0, 0, 21, 0, 0, 0, 17, 0, 0, 0, 27, 0, 0, 0, 14, 0, 0, 0, 29, 0, 0, 0, 17, 0, 0, 0, 35, 0, 0, 0, 14, 0, 0, 0, 37, 0, 0, 0, 17, 0, 0, 0, 43, 0, 0, 0, 14, 0, 0, 0, 45, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm512_maskz_dbsad_epu8::<1>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm512_maskz_dbsad_epu8::<1>(create_random__mmask32(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 0, 10, 0, 11, 0, 11, 0, 6, 0, 12, 0, 13, 0, 13, 0, 8, 0, 18, 0, 19, 0, 19, 0, 6, 0, 20, 0, 21, 0, 21, 0]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 244, 1, 240, 1, 228, 1, 0, 2, 244, 1, 240, 1, 228, 1, 0, 2, 244, 1, 240, 1, 228, 1, 0, 2, 244, 1, 240, 1, 228, 1]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138])));
        check_array_equality(&result, &[40, 0, 144, 1, 0, 2, 156, 0, 88, 0, 144, 1, 68, 1, 164, 0, 40, 0, 144, 1, 32, 1, 188, 1, 88, 0, 144, 1, 68, 1, 164, 0]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 0, 10, 0, 11, 0, 11, 0, 6, 0, 12, 0, 13, 0, 13, 0, 8, 0, 18, 0, 19, 0, 19, 0, 6, 0, 20, 0, 21, 0, 21, 0]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<0>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_dbsad_epu8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 10, 0, 11, 0, 11, 0, 6, 0, 12, 0, 13, 0, 13, 0, 9, 0, 18, 0, 19, 0, 19, 0, 6, 0, 20, 0, 21, 0, 21, 0]).map_err(|e| format!("{e} | call: _mm256_dbsad_epu8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_dbsad_epu8::<1>(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[8, 0, 0, 0, 27, 0, 0, 0, 6, 0, 0, 0, 29, 0, 0, 0, 8, 0, 0, 0, 35, 0, 0, 0, 6, 0, 0, 0, 37, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_u8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_u8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138]), create__m256i_from_u8_array([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148])));
        check_array_equality(&result, &[40, 0, 44, 144, 0, 2, 188, 32, 88, 0, 76, 176, 68, 1, 220, 64, 40, 0, 108, 208, 132, 1, 252, 96, 88, 0, 140, 240, 68, 1, 28, 128]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138]), create__m256i_from_u8_array([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128, 228, 72, 172, 16, 116, 216, 60, 160, 4, 104, 204, 48, 148]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[251, 3, 0, 0, 251, 3, 0, 0, 251, 3, 0, 0, 251, 3, 0, 0, 247, 3, 0, 0, 247, 3, 0, 0, 247, 3, 0, 0, 247, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 255, 255, 1, 0, 255, 255, 1, 0, 255, 255, 1, 0, 255, 255, 5, 0, 255, 255, 5, 0, 255, 255, 5, 0, 255, 255, 5, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[8, 0, 0, 0, 27, 0, 0, 0, 6, 0, 0, 0, 29, 0, 0, 0, 8, 0, 0, 0, 35, 0, 0, 0, 6, 0, 0, 0, 37, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<0>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_mask_dbsad_epu8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 0, 0, 0, 27, 0, 0, 0, 6, 0, 0, 0, 29, 0, 0, 0, 9, 0, 0, 0, 35, 0, 0, 0, 6, 0, 0, 0, 37, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_mask_dbsad_epu8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_mask_dbsad_epu8::<1>(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 0, 0, 0, 11, 0, 0, 0, 6, 0, 0, 0, 13, 0, 0, 0, 8, 0, 0, 0, 19, 0, 0, 0, 6, 0, 0, 0, 21, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create__m256i_from_u8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138])));
        check_array_equality(&result, &[40, 0, 0, 0, 0, 2, 0, 0, 88, 0, 0, 0, 68, 1, 0, 0, 40, 0, 0, 0, 32, 1, 0, 0, 88, 0, 0, 0, 68, 1, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84, 184, 28, 128]), create__m256i_from_u8_array([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74, 174, 18, 118, 218, 62, 162, 6, 106, 206, 50, 150, 250, 94, 194, 38, 138]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0; 32]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_u8_array([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create__m256i_from_u8_array([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 0, 0, 0, 11, 0, 0, 0, 6, 0, 0, 0, 13, 0, 0, 0, 8, 0, 0, 0, 19, 0, 0, 0, 6, 0, 0, 0, 21, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<0>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<0>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_maskz_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m256i_to_u8_array(_mm256_maskz_dbsad_epu8::<1>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 0, 0, 11, 0, 0, 0, 6, 0, 0, 0, 13, 0, 0, 0, 9, 0, 0, 0, 19, 0, 0, 0, 6, 0, 0, 0, 21, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm256_maskz_dbsad_epu8::<1>(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_maskz_dbsad_epu8::<1>(create_random__mmask16(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 0, 6, 0, 7, 0, 7, 0, 2, 0, 8, 0, 9, 0, 9, 0]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)])));
        check_array_equality(&result, &[0, 2, 244, 1, 240, 1, 228, 1, 0, 2, 244, 1, 240, 1, 228, 1]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)])));
        check_array_equality(&result, &[40, 0, 144, 1, 0, 2, 156, 0, 88, 0, 144, 1, 68, 1, 164, 0]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3, 252, 3]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 0, 6, 0, 7, 0, 7, 0, 2, 0, 8, 0, 9, 0, 9, 0]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_dbsad_epu8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 7, 0, 2, 0, 8, 0, 9, 0, 9, 0]).map_err(|e| format!("{e} | call: _mm_dbsad_epu8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_dbsad_epu8::<1>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[4, 0, 0, 0, 15, 0, 0, 0, 2, 0, 0, 0, 17, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]), create__m128i_from_i8_array([((20u8) as i8), ((19u8) as i8), ((22u8) as i8), ((17u8) as i8), ((24u8) as i8), ((15u8) as i8), ((26u8) as i8), ((13u8) as i8), ((20u8) as i8), ((19u8) as i8), ((22u8) as i8), ((17u8) as i8), ((24u8) as i8), ((15u8) as i8), ((26u8) as i8), ((13u8) as i8)])));
        check_array_equality(&result, &[40, 0, 2, 253, 40, 0, 6, 249, 40, 0, 2, 253, 40, 0, 6, 249]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]), create__m128i_from_i8_array([((20u8) as i8), ((19u8) as i8), ((22u8) as i8), ((17u8) as i8), ((24u8) as i8), ((15u8) as i8), ((26u8) as i8), ((13u8) as i8), ((20u8) as i8), ((19u8) as i8), ((22u8) as i8), ((17u8) as i8), ((24u8) as i8), ((15u8) as i8), ((26u8) as i8), ((13u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]), create__m128i_from_i8_array([((120u8) as i8), ((220u8) as i8), ((64u8) as i8), ((164u8) as i8), ((8u8) as i8), ((108u8) as i8), ((208u8) as i8), ((52u8) as i8), ((152u8) as i8), ((252u8) as i8), ((96u8) as i8), ((196u8) as i8), ((40u8) as i8), ((140u8) as i8), ((240u8) as i8), ((84u8) as i8)])));
        check_array_equality(&result, &[40, 0, 44, 144, 0, 2, 188, 32, 88, 0, 76, 176, 68, 1, 220, 64]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]), create__m128i_from_i8_array([((120u8) as i8), ((220u8) as i8), ((64u8) as i8), ((164u8) as i8), ((8u8) as i8), ((108u8) as i8), ((208u8) as i8), ((52u8) as i8), ((152u8) as i8), ((252u8) as i8), ((96u8) as i8), ((196u8) as i8), ((40u8) as i8), ((140u8) as i8), ((240u8) as i8), ((84u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[251, 3, 0, 0, 251, 3, 0, 0, 251, 3, 0, 0, 251, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 255, 255, 1, 0, 255, 255, 1, 0, 255, 255, 1, 0, 255, 255]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[4, 0, 0, 0, 15, 0, 0, 0, 2, 0, 0, 0, 17, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<0>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_mask_dbsad_epu8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 0, 0, 0, 15, 0, 0, 0, 2, 0, 0, 0, 17, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_dbsad_epu8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_dbsad_epu8::<1>(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 0, 0, 0, 7, 0, 0, 0, 2, 0, 0, 0, 9, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)])));
        check_array_equality(&result, &[0, 2, 0, 0, 240, 1, 0, 0, 0, 2, 0, 0, 240, 1, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8), ((0u8) as i8), ((255u8) as i8), ((2u8) as i8), ((253u8) as i8), ((4u8) as i8), ((251u8) as i8), ((6u8) as i8), ((249u8) as i8)]), create__m128i_from_i8_array([((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8), ((10u8) as i8), ((9u8) as i8), ((12u8) as i8), ((7u8) as i8), ((14u8) as i8), ((5u8) as i8), ((16u8) as i8), ((3u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)])));
        check_array_equality(&result, &[40, 0, 0, 0, 0, 2, 0, 0, 88, 0, 0, 0, 68, 1, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((100u8) as i8), ((200u8) as i8), ((44u8) as i8), ((144u8) as i8), ((244u8) as i8), ((88u8) as i8), ((188u8) as i8), ((32u8) as i8), ((132u8) as i8), ((232u8) as i8), ((76u8) as i8), ((176u8) as i8), ((20u8) as i8), ((120u8) as i8), ((220u8) as i8), ((64u8) as i8)]), create__m128i_from_i8_array([((110u8) as i8), ((210u8) as i8), ((54u8) as i8), ((154u8) as i8), ((254u8) as i8), ((98u8) as i8), ((198u8) as i8), ((42u8) as i8), ((142u8) as i8), ((242u8) as i8), ((86u8) as i8), ((186u8) as i8), ((30u8) as i8), ((130u8) as i8), ((230u8) as i8), ((74u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]), create__m128i_from_i8_array([((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8), ((0u8) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8), ((u8::MIN) as i8), ((u8::MAX) as i8), ((0u8) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)])));
        check_array_equality(&result, &[252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)])));
        check_array_equality(&result, &[252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0, 252, 3, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i8_array([((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8), ((u8::MAX) as i8)]), create__m128i_from_i8_array([((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8), ((u8::MIN) as i8)]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_imm_0() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 0, 0, 0, 7, 0, 0, 0, 2, 0, 0, 0, 9, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<0>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<0>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_dbsad_epu8_imm_1() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_u8_array(_mm_maskz_dbsad_epu8::<1>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0, 7, 0, 0, 0, 2, 0, 0, 0, 9, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_dbsad_epu8::<1>(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_dbsad_epu8::<1>(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[-128, -128, 127, 127, -128, -128, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtsepi16_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[127, -128, 127, -128, 127, -128, 127, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[127, -1, 127, -3, 127, -5, 127, -7, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[-128, -56, 127, -112, -128, 88, -128, 32, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[127, 127, 127, -1, 127, 127, 127, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, 127, -128, 127, -128, 127, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_epi8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, -128, 127, -128, 127, -128, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtsepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtsepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-128, 0, -128, 0, -128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[-128, 0, 127, 0, -128, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 0, -128, 0, -128, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 0, 127, 0, 127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtsepi16_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[127, 0, 127, 0, 127, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtsepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtsepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_cvtusepi16_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtusepi16_epi8(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 6, 0, 7, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-1, -1, -1, -3, -1, -5, -1, -7, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[-1, -56, -1, -112, -1, 88, -1, 32, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 127, -1, -1, -1, 127, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_asym_min_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_epi8_asym_max_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_mask_cvtusepi16_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_mask_cvtusepi16_epi8(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0; 16]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtusepi16_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_maskz_cvtusepi16_epi8(create__mmask8_from(0b01010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_maskz_cvtusepi16_epi8(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtsepi16_storeu_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtsepi16_storeu_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtsepi16_storeu_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtusepi16_storeu_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtusepi16_storeu_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8_normal2() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8_normal3() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8_boundary_min() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8_boundary_max() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8_boundary_zero() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8_boundary_allones() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtusepi16_storeu_epi8_boundary_mixed() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.0.as_mut_ptr(), k, a);
    }
    Ok(())
}
